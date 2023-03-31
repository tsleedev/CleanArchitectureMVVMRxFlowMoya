//
//  DetectDeinit.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2022/11/16.
//

import TSLogger
import Foundation

open class DetectDeinit: NSObject {
    lazy private(set) var className: String = {
      return type(of: self).description().components(separatedBy: ".").last ?? ""
    }()
    
    deinit {
        TSLogger.debug("DEINIT: \(self.className)")
    }
}
