//
//  TargetType+Ext.swift
//  
//
//  Created by TAE SU LEE on 2023/03/24.
//

import Foundation
import Moya

public protocol StatusCodeSampleDataTargetType: TargetType {
    func sampleData(statusCode: Int, mockFile: JSONFile?) -> Data
}
