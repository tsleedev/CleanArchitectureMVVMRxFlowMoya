//
//  Application.swift
//
//
//  Created by TAE SU LEE on 2022/11/16.
//

import TSLogger
import DILayer
import PresentationLayer
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
    
    public func initialize(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.windowScene = windowScene
        let storyboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
        window.rootViewController = storyboard.instantiateInitialViewController()
        self.window = window
        
        deviceService.registOrUpdate()
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
}
