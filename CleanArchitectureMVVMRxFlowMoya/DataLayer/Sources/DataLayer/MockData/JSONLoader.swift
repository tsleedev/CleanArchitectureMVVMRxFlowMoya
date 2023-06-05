//
//  JSONLoader.swift
//  
//
//  Created by TAE SU LEE on 2023/03/24.
//

import TSLogger
import Foundation

public protocol JSONLoader {
    var resource: String { get }
}

extension JSONLoader {
    func load(_ jsonLoader: JSONLoader) -> Data? {
        // 1. Locate the JSON file.
        guard let fileURL = Bundle.module.url(forResource: jsonLoader.resource, withExtension: "json") else {
            TSLogger.error("Unable to find the JSON file: \(jsonLoader.resource).json")
            return nil
        }

        // 2. Create a URL object using the file path.
        // 3. Create a Data object using the URL object.
        do {
            let data = try Data(contentsOf: fileURL)
            return data
        } catch {
            TSLogger.error("Error occurred while loading the JSON file: \(error)")
            return nil
        }
    }
}
