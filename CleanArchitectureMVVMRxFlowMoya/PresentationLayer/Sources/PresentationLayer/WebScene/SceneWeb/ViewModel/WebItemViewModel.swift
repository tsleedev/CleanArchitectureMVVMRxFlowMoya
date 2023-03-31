//
//  WebItemViewModel.swift
//  
//
//  Created by TAE SU LEE on 2022/11/20.
//

import Foundation

public struct WebItemViewModel {
    public let title: String?
    public let startUrl: String?
    
    public init(title: String?, startUrl: String?) {
        self.title = title
        self.startUrl = startUrl
    }
}
