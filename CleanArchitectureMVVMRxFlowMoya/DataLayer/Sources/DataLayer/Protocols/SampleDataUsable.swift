//
//  SampleDataUsable.swift
//  
//
//  Created by TAE SU LEE on 2023/06/10.
//

import Foundation

protocol SampleDataUsable {
    func getSampleData(_ jsonLoader: JSONLoader?) -> Data?
}

extension SampleDataUsable {
    func getSampleData(_ jsonLoader: JSONLoader?) -> Data? {
        guard let jsonLoader = jsonLoader else { return nil }
        return jsonLoader.load(jsonLoader)
    }
}
