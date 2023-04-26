//
//  Encodable+Ext.swift
//  
//
//  Created by TAE SU LEE on 2023/03/14.
//

import TSLogger
import Foundation

public extension Encodable {
    func toDictionary() -> [String: Any] {
        do {
            let data = try JSONEncoder().encode(self)
            let jsonData = try JSONSerialization.jsonObject(with: data)
            return (jsonData as? [String: Any]) ?? [:]
        } catch {
            TSLogger.error("error: ", error)
            return [:]
        }
    }
}
