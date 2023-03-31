//
//  XCTestCase+Helpers.swift
//  
//
//  Created by TAE SU LEE on 2023/03/29.
//

import XCTest

public extension XCTestCase {
    func printError(msg: String, expectedEvent: Any, actualEvent: Any, file: String = #file, function: String = #function, line: Int = #line) -> String {
        let fileName = (file as NSString).lastPathComponent
        return """
        \n
        ❤️ ERROR (file: \(fileName), function: \(function), line: \(line)):
        Mismatch in \(msg)
        Expected: \(expectedEvent)
        Actual: \(actualEvent)
        
        """
    }
    
    func printError(index: Int, expectedEvent: Any, actualEvent: Any, file: String = #file, function: String = #function, line: Int = #line) -> String {
        let fileName = (file as NSString).lastPathComponent
        return """
        \n
        ❤️ ERROR (file: \(fileName), function: \(function), line: \(line)):
        Mismatch at index \(index)
        Expected: \(expectedEvent)
        Actual: \(actualEvent)

        """
    }
}
