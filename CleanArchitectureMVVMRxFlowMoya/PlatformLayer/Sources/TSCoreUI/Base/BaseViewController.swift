//
//  BaseViewController.swift
//  
//
//  Created by TAE SU LEE on 2022/11/16.
//

import TSLogger
import UIKit
import RxSwift

open class BaseViewController: UIViewController {
    
    lazy private(set) var className: String = {
        return type(of: self).description().components(separatedBy: ".").last ?? ""
    }()
    
    deinit {
        TSLogger.flow("DEINIT: \(self.className)")
    }
    
    // MARK: Rx
    public var disposeBag = DisposeBag()
}
