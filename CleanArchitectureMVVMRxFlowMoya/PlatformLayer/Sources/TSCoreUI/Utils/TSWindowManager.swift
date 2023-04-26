//
//  TSWindowManager.swift
//  
//
//  Created by TAE SU LEE on 2023/03/20.
//

import UIKit

public final class TSWindowManager {
    public static let shared = TSWindowManager()
    private var scene: UIScene?
    private var windows: [UIWindow] = []
    
    public func initialize(with scene: UIScene) {
        if self.scene == nil {
            self.scene = scene
        } else {
            assertionFailure("\(String(describing: type(of: self))) Error - scene은 한번만 설정 가능합니다.")
        }
    }
}

// MARK: - Manages from Window
public extension TSWindowManager {
    func add(_ window: UIWindow) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window.windowScene = windowScene
        window.windowLevel = windows.last?.windowLevel ?? UIWindow.Level.alert + 1
        window.makeKeyAndVisible()
        windows.append(window)
    }
    
    func remove(_ window: UIWindow?) {
        guard let window = window else { return }
        window.isHidden = true
        windows.removeAll { $0 == window }
    }
    
    func removeAll() {
        windows.removeAll()
    }
}

// MARK: - Manages from UIViewController
public extension TSWindowManager {
    func add(_ viewController: UIViewController) -> UIWindow? {
        guard let windowScene = (scene as? UIWindowScene) else { return nil }
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.windowScene = windowScene
        window.rootViewController = viewController
        window.windowLevel = windows.last?.windowLevel ?? UIWindow.Level.alert + 1
        window.makeKeyAndVisible()
        windows.append(window)
        return window
    }
}
