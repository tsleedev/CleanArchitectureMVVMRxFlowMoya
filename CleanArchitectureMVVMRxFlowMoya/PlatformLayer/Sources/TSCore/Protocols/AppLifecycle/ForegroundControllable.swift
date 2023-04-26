//
//  ForegroundControllable.swift
//
//
//  Created by TAE SU LEE on 2023/04/14.
//  
//

import UIKit

@objc public protocol ForegroundControllable {
    func willEnterForeground(_ notification: Notification)
}

public extension ForegroundControllable {
    func addForegroundObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground(_:)), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    func removeForegroundObserver() {
        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
    }
}
