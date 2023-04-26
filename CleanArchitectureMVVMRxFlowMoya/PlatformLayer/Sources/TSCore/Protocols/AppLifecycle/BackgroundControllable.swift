//
//  BackgroundControllable.swift
//
//
//  Created by TAE SU LEE on 2023/04/14.
//  
//

import UIKit

@objc public protocol BackgroundControllable {
    func didEnterBackground(_ notification: Notification)
}

public extension BackgroundControllable {
    func addBackgroundObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackground(_:)), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }

    func removeBackgroundObserver() {
        NotificationCenter.default.removeObserver(self, name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
}
