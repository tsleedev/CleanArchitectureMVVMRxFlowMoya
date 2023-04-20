//
//  Application.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2022/11/16.
//

import TSLogger
import DILayer
import DomainLayer
import UIKit
import RxFlow
import RxSwift

final class Application {
    static let shared = Application()
    private let appConfiguration: AppConfiguration
    private let appDIContainer: AppDIContainer
    private let deviceService: DeviceService
    
    private var coordinator: FlowCoordinator?
    private var disposeBag = DisposeBag()
    private var window: UIWindow?
    
    private init() {
        #if DEBUG
        appConfiguration = AppConfiguration(mode: .useSampleData, target: .stg)
        #else
        appConfiguration = AppConfiguration(mode: .useRealData, target: .prod)
        #endif
        
        appDIContainer = AppDIContainer(configuration: appConfiguration)
        let deviceServiceDIContainer = appDIContainer.makeServiceDIContainer().makeDeviceServiceDIContainer()
        deviceService = DeviceService(appInfoUseCase: deviceServiceDIContainer.makeAppInfoUseCase(),
                                      userDefaultsUseCase: deviceServiceDIContainer.makeUserDefaultsUseCase(),
                                      deviceUseCase: deviceServiceDIContainer.makeDeviceUseCase())
    }
          
    func start(scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        deviceService.registOrUpdate()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.windowScene = windowScene
        let storyboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
        window.rootViewController = storyboard.instantiateInitialViewController()
        let coordinator = FlowCoordinator()
        
        coordinator.rx.willNavigate.subscribe(onNext: { (flow, step) in
            TSLogger.flow("will navigate to flow=\(String(describing: type(of: flow))) and step=\(step)")
        }).disposed(by: disposeBag)
        
        coordinator.rx.didNavigate.subscribe(onNext: { (flow, step) in
            TSLogger.flow("did navigate to flow=\(String(describing: type(of: flow))) and step=\(step)")
        }).disposed(by: disposeBag)
        
        let appFlow = AppFlow(window: window, appDIContainer: appDIContainer)
        coordinator.coordinate(flow: appFlow, with: AppStepper())
        self.coordinator = coordinator
        self.window = window
    }
    
    func updateDeviceToken(_ deviceToken: String) {
        deviceService.deviceToken = deviceToken
    }
}
