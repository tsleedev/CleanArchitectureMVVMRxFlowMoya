//
//  Application.swift
//
//
//  Created by TAE SU LEE on 2022/11/16.
//

import TSCore
import TSLogger
import DILayer
import PresentationLayer
import DomainLayer
import UIKit
import RxFlow
import RxSwift

final class Application: BackgroundControllable, ForegroundControllable {
    // MARK: - Singleton
    static let shared = Application()
    
    // MARK: - Properties
    private let appConfiguration: AppConfiguration
    private let appDIContainer: AppDIContainer
    private let deviceService: DeviceService
    private let notificationService: NotificationService
    
    private var coordinator: FlowCoordinator?
    private var disposeBag = DisposeBag()
    private var windowScene: UIWindowScene?
    private var window: UIWindow?
    
    private var isDidEnterBackground: Bool = false
    private var backgroundEntryTime: TimeInterval = Date().timeIntervalSince1970
    
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
        
        let notificationServiceDIContainer = appDIContainer.makeServiceDIContainer().makeNotificationServiceDIContainer()
        notificationService = NotificationService(useCase: notificationServiceDIContainer.makeUseCase())
        notificationService.registerForRemoteNotifications()
        requestNotificationAuthorization()
        bindNotification()
    }
    
    public func initialize(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.windowScene = windowScene
        
        createWindow()
        deviceService.registOrUpdate()
        addBackgroundObserver()
        addForegroundObserver()
    }
    
    func start() {
        guard let window = window else { return }
        
        let coordinator = FlowCoordinator()
        coordinator.rx.willNavigate.subscribe(onNext: { (flow, step) in
            let flowTypeName = String(describing: type(of: flow))
            let stepTypeName = String(describing: type(of: step))
            TSLogger.flow("will navigate to flow=\(flowTypeName) and step=\(stepTypeName).\(step)")
        }).disposed(by: disposeBag)
        
        coordinator.rx.didNavigate.subscribe(onNext: { (flow, step) in
            let flowTypeName = String(describing: type(of: flow))
            let stepTypeName = String(describing: type(of: step))
            TSLogger.flow("did navigate to flow=\(flowTypeName) and step=\(stepTypeName).\(step)")
        }).disposed(by: disposeBag)
        
        let appFlow = AppFlow(window: window, appDIContainer: appDIContainer)
        coordinator.coordinate(flow: appFlow, with: AppStepper())
        self.coordinator = coordinator
    }
    
    func restart() {
        reset()
        createWindow()
        start()
    }
    
    func exitApp() {
        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            Darwin.exit(0)
        }
    }
    
    func navigate(to step: Step, closeAllViewController: Bool = false) {
        if closeAllViewController {
            if let rootViewController = window?.rootViewController {
                if rootViewController.presentedViewController != nil {
                    rootViewController.dismiss(animated: false) { [unowned self] in
                        self.coordinator?.navigate(to: step)
                    }
                    return
                }
            }
        }
        coordinator?.navigate(to: step)
    }
    
    func updateDeviceToken(_ deviceToken: String) {
        deviceService.deviceToken = deviceToken
    }
    
    // MARK: - BackgroundControllable
    func didEnterBackground(_ notification: Notification) {
        backgroundEntryTime = Date().timeIntervalSince1970
        isDidEnterBackground = true
    }
    
    // MARK: - ForegroundControllable
    func willEnterForeground(_ notification: Notification) {
        if isDidEnterBackground == false { return }
        isDidEnterBackground = false
        
        let timeSinceBackgroundEntry = Date().timeIntervalSince1970 - backgroundEntryTime
        backgroundEntryTime = Date().timeIntervalSince1970
        
        // If the app is re-entered within 1 hour, restart the app from the beginning
        if timeSinceBackgroundEntry >= 60 * 60 * 1 { // 1 hour
            restart()
        }
    }
}

// MARK: - Helper
private extension Application {
    func createWindow() {
        guard let windowScene = windowScene else { return }
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.windowScene = windowScene
        let storyboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
        window.rootViewController = storyboard.instantiateInitialViewController()
        self.windowScene = windowScene
        self.window = window
    }
    
    func reset() {
        window?.rootViewController = nil
        window?.resignKey()
        window?.removeFromSuperview()
        window = nil
    }
}

// MARK: - Notification
private extension Application {
    func requestNotificationAuthorization() {
        notificationService.requestNotificationAuthorization()
            .subscribe(onSuccess: { granted in
                TSLogger.debug("Notification authorization granted: \(granted)")
            })
            .disposed(by: disposeBag)
    }
    
    func bindNotification() {
        notificationService.syncNotification()
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { notification in
                TSLogger.debug(notification)
                Application.shared.navigate(to: DeepLinkStep.settings, closeAllViewController: false)
            })
            .disposed(by: disposeBag)
    }
}
