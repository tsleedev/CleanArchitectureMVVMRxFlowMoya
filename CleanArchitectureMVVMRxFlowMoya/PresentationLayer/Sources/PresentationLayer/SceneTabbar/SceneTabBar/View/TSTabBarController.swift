//
//  TSTabBarController.swift
//  
//
//  Created by TAE SU LEE on 2023/02/01.
//

import TSCoreUI
import UIKit

class TSTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARL: - Setup
private extension TSTabBarController {
    func setup() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        } else {
            
        }
    }
}
