//
//  JSONLoader.swift
//  
//
//  Created by TAE SU LEE on 2023/03/24.
//

import TSLogger
import Foundation

class JSONLoader {
    static func load(_ fileName: String) -> Data? {
        guard let fileURL = Bundle.module.url(forResource: fileName, withExtension: "json") else {
            fatalError("Unable to find the JSON file: \(fileName).json")
        }

        do {
            let data = try Data(contentsOf: fileURL)
            return data
        } catch {
            fatalError("Error occurred while loading the JSON file: \(error)")
        }
    }
}
