//
//  SampleData.swift
//  
//
//  Created by TAE SU LEE on 2022/11/19.
//

import Foundation

struct SampleData {
    let searchRepos = Data(
    """
        {
          "total_count": 6125,
          "incomplete_results": false,
          "items": [
            {
              "full_name": "ReactiveX/RxSwift",
              "owner": {
                "avatar_url": "https://avatars.githubusercontent.com/u/6407041?v=4"
              },
              "html_url": "https://github.com/ReactiveX/RxSwift",
              "description": "Reactive Programming in Swift"
            },
            {
              "full_name": "fimuxd/RxSwift",
              "owner": {
                "avatar_url": "https://avatars.githubusercontent.com/u/27915244?v=4"
              },
              "html_url": "https://github.com/fimuxd/RxSwift",
              "description": "RxSwift를 스터디하는 공간"
            },
            {
              "full_name": "beeth0ven/RxSwift-Chinese-Documentation",
              "owner": {
                "avatar_url": "https://avatars.githubusercontent.com/u/5554127?v=4"
              },
              "html_url": "https://github.com/beeth0ven/RxSwift-Chinese-Documentation",
              "description": "RxSwift 中文文档"
            },
            {
              "full_name": "DroidsOnRoids/RxSwiftExamples",
              "owner": {
                "avatar_url": "https://avatars.githubusercontent.com/u/2815187?v=4"
              },
              "html_url": "https://github.com/DroidsOnRoids/RxSwiftExamples",
              "description": "Examples and resources for RxSwift."
            },
            {
              "full_name": "CombineCommunity/rxswift-to-combine-cheatsheet",
              "owner": {
                "avatar_url": "https://avatars.githubusercontent.com/u/53597243?v=4"
              },
              "html_url": "https://github.com/CombineCommunity/rxswift-to-combine-cheatsheet",
              "description": "RxSwift to Apple’s Combine Cheat Sheet"
            },
            {
              "full_name": "sergdort/CleanArchitectureRxSwift",
              "owner": {
                "avatar_url": "https://avatars.githubusercontent.com/u/4622322?v=4"
              },
              "html_url": "https://github.com/sergdort/CleanArchitectureRxSwift",
              "description": "Example of Clean Architecture of iOS app using RxSwift"
            },
            {
              "full_name": "khoren93/SwiftHub",
              "owner": {
                "avatar_url": "https://avatars.githubusercontent.com/u/11523360?v=4"
              },
              "html_url": "https://github.com/khoren93/SwiftHub",
              "description": "GitHub iOS client in RxSwift and MVVM-C clean architecture"
            },
            {
              "full_name": "RxSwiftCommunity/RxRealm",
              "owner": {
                "avatar_url": "https://avatars.githubusercontent.com/u/15903991?v=4"
              },
              "html_url": "https://github.com/RxSwiftCommunity/RxRealm",
              "description": "RxSwift extension for RealmSwift's types"
            },
            {
              "full_name": "RxSwiftCommunity/RxGesture",
              "owner": {
                "avatar_url": "https://avatars.githubusercontent.com/u/15903991?v=4"
              },
              "html_url": "https://github.com/RxSwiftCommunity/RxGesture",
              "description": "RxSwift reactive wrapper for view gestures"
            },
            {
              "full_name": "devxoul/RxTodo",
              "owner": {
                "avatar_url": "https://avatars.githubusercontent.com/u/931655?v=4"
              },
              "html_url": "https://github.com/devxoul/RxTodo",
              "description": "iOS Todo Application using RxSwift and ReactorKit"
            },
            {
              "full_name": "RxSwiftCommunity/RxReachability",
              "owner": {
                "avatar_url": "https://avatars.githubusercontent.com/u/15903991?v=4"
              },
              "html_url": "https://github.com/RxSwiftCommunity/RxReachability",
              "description": "RxSwift bindings for Reachability"
            },
            {
              "full_name": "jspahrsummers/RxSwift",
              "owner": {
                "avatar_url": "https://avatars.githubusercontent.com/u/432536?v=4"
              },
              "html_url": "https://github.com/jspahrsummers/RxSwift",
              "description": "Proof-of-concept for implementing Rx primitives in Swift"
            },
            {
              "full_name": "RxSwiftCommunity/Action",
              "owner": {
                "avatar_url": "https://avatars.githubusercontent.com/u/15903991?v=4"
              },
              "html_url": "https://github.com/RxSwiftCommunity/Action",
              "description": "Abstracts actions to be performed in RxSwift."
            },
            {
              "full_name": "bmoliveira/Moya-ObjectMapper",
              "owner": {
                "avatar_url": "https://avatars.githubusercontent.com/u/1921410?v=4"
              },
              "html_url": "https://github.com/bmoliveira/Moya-ObjectMapper",
              "description": "ObjectMapper bindings for Moya and RxSwift"
            },
            {
              "full_name": "RxSwiftCommunity/RxFirebase",
              "owner": {
                "avatar_url": "https://avatars.githubusercontent.com/u/15903991?v=4"
              },
              "html_url": "https://github.com/RxSwiftCommunity/RxFirebase",
              "description": "RxSwift extensions for Firebase"
            },
            {
              "full_name": "kLike/ZhiHu-RxSwift",
              "owner": {
                "avatar_url": "https://avatars.githubusercontent.com/u/16699975?v=4"
              },
              "html_url": "https://github.com/kLike/ZhiHu-RxSwift",
              "description": "知乎日报  with RxSwift"
            }
          ]
        }
    """.utf8)
    
    let error = Data(
    """
        {
          "message": "API rate limit exceeded for 211.104.174.168. (But here's the good news: Authenticated requests get a higher rate limit. Check out the documentation for more details.)",
          "documentation_url": "https://docs.github.com/rest/overview/resources-in-the-rest-api#rate-limiting"
        }
    """.utf8)
}
