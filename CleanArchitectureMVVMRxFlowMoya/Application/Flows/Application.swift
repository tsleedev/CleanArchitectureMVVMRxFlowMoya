//
//  Application.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2022/11/16.
//

import UIKit
import Logging
import RxFlow
import RxSwift

final public class Application {
    
    static let shared = Application()
    
    private var coordinator: FlowCoordinator?
    private var disposeBag = DisposeBag()
    private var window: UIWindow?
    
    func start(scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.windowScene = windowScene
        let storyboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
        window.rootViewController = storyboard.instantiateInitialViewController()
        let coordinator = FlowCoordinator()
        
        coordinator.rx.willNavigate.subscribe(onNext: { (flow, step) in
            Log.flow("will navigate to flow=\(String(describing: type(of: flow))) and step=\(step)")
        }).disposed(by: disposeBag)
        
        coordinator.rx.didNavigate.subscribe(onNext: { (flow, step) in
            Log.flow("did navigate to flow=\(String(describing: type(of: flow))) and step=\(step)")
        }).disposed(by: self.disposeBag)
        
        let appFlow = AppFlow(window: window)
        coordinator.coordinate(flow: appFlow, with: AppStepper())
        window.makeKeyAndVisible()
        self.coordinator = coordinator
        self.window = window
    }
}
