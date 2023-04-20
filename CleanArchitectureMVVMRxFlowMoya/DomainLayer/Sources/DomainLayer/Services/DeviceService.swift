//
//  DeviceService.swift
//  
//
//  Created by TAE SU LEE on 2023/04/17.
//

import TSCore
import Foundation
import RxSwift

public final class DeviceService: DetectDeinit {
    public var disposeBag = DisposeBag()
    
    // MARK: - Property
    private var uniqueAppInstanceIDPublishSubject = BehaviorSubject<String?>(value: nil)
    private var uniqueAppInstanceID: String? {
        didSet {
            uniqueAppInstanceIDPublishSubject.onNext(uniqueAppInstanceID)
        }
    }
    
    private var deviceTokenPublishSubject = BehaviorSubject<String?>(value: nil)
    public var deviceToken: String? {
        didSet {
            deviceTokenPublishSubject.onNext(deviceToken)
        }
    }
    
    private var previousDeviceTokenPublishSubject = BehaviorSubject<String?>(value: nil)
    public var previousDeviceToken: String? {
        didSet {
            previousDeviceTokenPublishSubject.onNext(previousDeviceToken)
        }
    }
    
    // MARK: - Initialize with UseCase
    private let appInfoUseCase: AppInfoUseCaseProtocol
    private var userDefaultsUseCase: UserDefaultsUseCaseProtocol
    private let deviceUseCase: DeviceUseCaseProtocol
    
    public init(appInfoUseCase: AppInfoUseCaseProtocol,
                userDefaultsUseCase: UserDefaultsUseCaseProtocol,
                deviceUseCase: DeviceUseCaseProtocol) {
        self.appInfoUseCase = appInfoUseCase
        self.userDefaultsUseCase = userDefaultsUseCase
        self.deviceUseCase = deviceUseCase
        super.init()
        
        setup()
        bind()
    }
    
    public func registOrUpdate() {
        if let uniqueAppInstanceID = uniqueAppInstanceID {
            update(uniqueAppInstanceID)
        } else {
            regist()
        }
    }
}

// MARK: - Setup
private extension DeviceService {
    func setup() {
        uniqueAppInstanceID = userDefaultsUseCase.uniqueAppInstanceID
        previousDeviceToken = userDefaultsUseCase.deviceToken
    }
}

// MARK: - Helper
private extension DeviceService {
    func regist() {
        let param = Params.Device.Regist(appBundleID: appInfoUseCase.appBundleID(),
                                         appVersion: appInfoUseCase.appVersion(),
                                         buildVersion: appInfoUseCase.buildVersion(),
                                         deviceModel: appInfoUseCase.deviceModel(),
                                         deviceType: appInfoUseCase.deviceType(),
                                         osType: appInfoUseCase.osType(),
                                         osVersion: appInfoUseCase.osVersion())
        deviceUseCase.regist(param)
            .subscribe(onSuccess: { [weak self] device in
                guard let self = self else { return }
                self.userDefaultsUseCase.uniqueAppInstanceID = device.uniqueAppInstanceID
            })
            .disposed(by: disposeBag)
    }
    
    func update(_ uniqueAppInstanceID: String) {
        let param = Params.Device.Update(appVersion: appInfoUseCase.appVersion(),
                                         buildVersion: appInfoUseCase.buildVersion(),
                                         osVersion: appInfoUseCase.osVersion())
        deviceUseCase.update(uniqueAppInstanceID, param)
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    func deviceToken(_ uniqueAppInstanceID: String, _ deviceToken: String) {
        let param = Params.Device.DeviceToken(deviceToken: deviceToken)
        deviceUseCase.deviceToken(uniqueAppInstanceID, param)
            .subscribe(onSuccess: { [weak self] _ in
                guard let self = self else { return }
                self.userDefaultsUseCase.deviceToken = deviceToken    
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Bind
private extension DeviceService {
    func bind() {
        uniqueAppInstanceIDPublishSubject
            .subscribe(onNext: { [weak self] newValue in
                guard let self = self else { return }
                self.userDefaultsUseCase.uniqueAppInstanceID = newValue
            })
            .disposed(by: disposeBag)
        
        Observable.combineLatest(uniqueAppInstanceIDPublishSubject.distinctUntilChanged(),
                                 deviceTokenPublishSubject.distinctUntilChanged(),
                                 previousDeviceTokenPublishSubject.distinctUntilChanged())
            .debug("DeviceService deviceTokenPublishSubject")
            .filter { ($0.0 != nil && !$0.0!.isEmpty) && ($0.1 != nil && !$0.1!.isEmpty) }
            .map { ($0.0!, $0.1!, $0.2) }
            .filter { $0.2 == nil || ($0.1 != $0.2!) }
            .map { ($0.0, $0.1) }
            .subscribe(onNext: { [weak self] uniqueAppInstanceID, deviceToken in
                guard let self = self else { return }
                self.deviceToken(uniqueAppInstanceID, deviceToken)
            })
            .disposed(by: disposeBag)
    }
}
