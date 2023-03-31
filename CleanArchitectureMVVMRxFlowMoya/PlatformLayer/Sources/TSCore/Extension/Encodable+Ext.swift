//
//  Encodable+Ext.swift
//  
//
//  Created by TAE SU LEE on 2023/03/14.
//

import Foundation

public extension Encodable {
    func toDictionary() -> [String: Any] {
        do {
            let data = try JSONEncoder().encode(self)
            let jsonData = try JSONSerialization.jsonObject(with: data)
            return (jsonData as? [String: Any]) ?? [:]
        } catch {
            print("error: ", error)
            return [:]
        }
    }
}
