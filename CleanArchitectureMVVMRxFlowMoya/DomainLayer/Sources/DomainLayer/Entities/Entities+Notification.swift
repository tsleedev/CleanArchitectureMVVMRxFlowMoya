//  
//  Entities+Notification.swift
//  
//
//  Created by TAE SU LEE on 2023/04/27.
//

import Foundation

public extension Entities {
    struct Notification {
        public let title: String?
        public let body: String?
        public let imageUrl: String?
        public let targets: String?

        public init(title: String?, body: String?, imageUrl: String?, targets: String?) {
            self.title = title
            self.body = body
            self.imageUrl = imageUrl
            self.targets = targets
        }
    }
}
