//
//  JSONLoader.swift
//  
//
//  Created by TAE SU LEE on 2023/03/24.
//

import TSLogger
import Foundation

public enum JSONFile {
    case deviceRegist(Int)
    case deviceUpdate(Int)
    case deviceDeviceToken(Int)
    case home(Int)
    case more(Int)
    case search(Int)
    case searchNoItems
    case settings(Int)
}

extension JSONFile {
    var resource: String? {
        switch self {
        case .deviceRegist(let statusCode):
            switch statusCode {
            case 200:   return "DeviceRegistSampleDataStatusCode200"
            default:    return nil
            }
        case .deviceUpdate(let statusCode):
            switch statusCode {
            case 200:   return "DeviceUpdateSampleDataStatusCode200"
            default:    return nil
            }
        case .deviceDeviceToken(let statusCode):
            switch statusCode {
            case 200:   return "DeviceDeviceTokenSampleDataStatusCode200"
            default:    return nil
            }
        case .home(let statusCode):
            switch statusCode {
            case 200:   return "HomeSampleDataStatusCode200"
            case 403:   return "HomeSampleDataStatusCode403"
            default:    return nil
            }
        case .more(let statusCode):
            switch statusCode {
            case 200:   return "MoreSampleDataStatusCode200"
            case 403:   return "MoreSampleDataStatusCode403"
            default:    return nil
            }
        case .search(let statusCode):
            switch statusCode {
            case 200:   return "SearchSampleDataStatusCode200"
            case 403:   return "SearchSampleDataStatusCode403"
            default:    return nil
            }
        case .searchNoItems:
            return "SearchSampleDataNoItemsStatusCode200"
        case .settings(let statusCode):
            switch statusCode {
            case 200:   return "SettingsSampleDataStatusCode200"
            case 403:   return "SettingsSampleDataStatusCode403"
            default:    return nil
            }
        }
    }
}

struct JSONLoader {
    static func loadJSONFile(_ jsonFile: JSONFile) -> Data? {
        // 1. Locate the JSON file.
        guard let fileURL = Bundle.module.url(forResource: jsonFile.resource, withExtension: "json") else {
            TSLogger.error("Unable to find the JSON file: \(jsonFile.resource ?? "").json")
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
