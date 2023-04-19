//
//  Entities+Device.swift
//  
//
//  Created by TAE SU LEE on 2023/04/17.
//

import Foundation

public extension Entities {
    struct Device {
        public let uniqueAppInstanceID: String

        public init(uniqueAppInstanceID: String) {
            self.uniqueAppInstanceID = uniqueAppInstanceID
        }
    }
}
