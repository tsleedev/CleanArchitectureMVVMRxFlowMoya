//
//  TSLogger.swift
//
//
//  Created by TAE SU LEE on 2022/11/15.
//

import Foundation
import os

private enum LogFilter {
    case debug
    case error
    case flow
    case api
    case warning
}

private extension LogFilter {
    var icon: String {
        switch self {
        case .debug:    return "💚"
        case .error:    return "❤️"
        case .flow:     return "💙"
        case .api:      return "💜"
        case .warning:  return "🧡"
        }
    }
    
    var name: String {
        switch self {
        case .debug:    return "DEBUG"
        case .error:    return "ERROR"
        case .flow:     return "FLOW"
        case .api:      return "API"
        case .warning:  return "WARNING"
        }
    }
    
    var type: OSLogType {
        switch self {
        case .debug:    return .default
        case .error:    return .error
        case .flow:     return .default
        case .api:      return .default
        case .warning:  return .default
        }
    }
    
    var osLog: OSLog {
        return OSLog(subsystem: Bundle.main.bundleIdentifier!, category: name)
    }
    
    @available(iOS 14.0, *)
    var logger: Logger {
        return Logger(subsystem: Bundle.main.bundleIdentifier!, category: name)
    }
}

public struct TSLogger {
    public static func debug(_ items: Any...,
                             separator: String = " ",
                             terminator: String = "\n",
                             _ file: String = #fileID,
                             _ function: String = #function,
                             _ line: UInt = #line) {
        log(filter: .debug, items: items, separator: separator, terminator: terminator, file, function, line)
    }
    
    public static func error(_ items: Any...,
                             separator: String = " ",
                             terminator: String = "\n",
                             _ file: String = #fileID,
                             _ function: String = #function,
                             _ line: UInt = #line) {
        log(filter: .error, items: items, separator: separator, terminator: terminator, file, function, line)
    }
    
    public static func flow(_ items: Any...,
                            separator: String = " ",
                            terminator: String = "\n",
                            _ file: String = #fileID,
                            _ function: String = #function,
                            _ line: UInt = #line) {
        log(filter: .flow, items: items, separator: separator, terminator: terminator, file, function, line)
    }
    
    public static func api(_ items: Any...,
                           separator: String = " ",
                           terminator: String = "\n",
                           _ file: String = #fileID,
                           _ function: String = #function,
                           _ line: UInt = #line) {
        log(filter: .api, items: items, separator: separator, terminator: terminator, file, function, line)
    }
    
    public static func warning(_ items: Any...,
                               separator: String = " ",
                               terminator: String = "\n",
                               _ file: String = #fileID,
                               _ function: String = #function,
                               _ line: UInt = #line) {
        log(filter: .warning, items: items, separator: separator, terminator: terminator, file, function, line)
    }
    
    private static func log(filter: LogFilter,
                            items: Any...,
                            separator: String = " ",
                            terminator: String = "\n",
                            _ file: String = #fileID,
                            _ function: String = #function,
                            _ line: UInt = #line) {
#if DEBUG
        //        let fileName = file.components(separatedBy: "/").last?.components(separatedBy: ".").first ?? ""
        //        let prefix = "\(filter.icon) \(filter.name) (\(fileName) \(function) \(line)) :"
        //        let output = items.map { "\($0)" }.joined(separator: separator)
        //
        //        if #available(iOS 14.0, *) {
        //            filter.logger.log(level: filter.type, "\(prefix) \(output)")
        //        } else {
        //            let message = "\(prefix) \(output)"
        //            os_log(filter.type, log: filter.osLog, "%@", message)
        //        }
                
        // MARK: - For Previews
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss:SSS"
        let fileName = file.components(separatedBy: "/").last?.components(separatedBy: ".").first ?? ""
        let prefix = "\(filter.icon) \(filter.name)(\(dateFormatter.string(from: Date())) \(fileName) \(function) \(line)) :"
        let output = items.map { "\($0)" }.joined(separator: separator)
        print("\(prefix) \(output)")
#endif
    }
}
