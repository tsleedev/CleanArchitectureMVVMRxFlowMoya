# Clean Architecture + MVVM + RxSwift + RxFlow + Moya

Clean Architecture + MVVM + RxSwift + RxFlow + Moya로 프로젝트를 구성하였습니다.

이 프로젝트를 참고해서 RxFlow 추가 및 Package 분리를 하였습니다.
[iOS-Clean-Architecture-MVVM-RxSwift](https://github.com/kwontaewan/iOS-Clean-Architecture-MVVM-RxSwift)


## 전체 Architecture 구성도
![Alt text](README_FILES/Action_configuration.png?raw=true "Modules Dependencie")


## 구현
* MVVM 패턴에서 Input, Output을 이용해서 RxSwift로 구현
* RxSwiftExt를 이용해서 TableView의 마지막까지 스크롤하게 될 경우 다음 페이지 로드 구현
* RxMoya를 통해 API Network 구현
* RxSwift로 테이블 구현
* Kingfisher를 이용해서 이미지 비동기 로드 및 TableViewCell이 재사용되면서 이전 이미지가 로드 될 수 있는 경우에 대해 처리
* SwiftLint를 이용해서 코드 컨벤션 유지


## Coordinator with RxFlow
Package로 Presentation, Domain, Data Layer가 분리되어 있어 Flow를 Presentation안에서 구현하기가 어려워 Application단으로 보낸 후 처리하도록 구현 (Domain에 Data를 주입해야되는데 Presentation안에서는 Data를 알 수 없기 때문)
ex) 리스트를 눌러서 자세히 보기 웹을 띄울때 아래와 같은 과정을 거치게 구현 SeachFlow(SearchStep.detail) > AppFlow(AppStep.webIsRequired) > AppFlow(WebStep.start) > WebFlow
(다양한 케이스를 추가해 검증 필요)


## Built With
- [RxSwift](https://github.com/ReactiveX/RxSwift) - Reactive Programming in Swift
- [RxCocoa](https://github.com/ReactiveX/RxSwift) - library allows us to use Cocoa APIs used in iOS and OS X with reactive technics.
- [RxSwiftExt](https://github.com/RxSwiftCommunity/RxSwiftExt) - A collection of Rx operators & tools not found in the core RxSwift distribution
- [Moya](https://github.com/Moya/Moya) - Network abstraction layer written in Swift.
- [Kingfisher](https://github.com/onevcat/Kingfisher) - A lightweight, pure-Swift library for downloading and caching images from the web.
- [SnapKit](https://github.com/SnapKit/SnapKit) - SnapKit is a DSL to make Auto Layout easy on both iOS and OS X.
- [SwiftLintPlugin](https://github.com/lukepistrol/SwiftLintPlugin) - A Swift Package Plugin for SwiftLint that will run SwiftLint on build time and show errors & warnings in Xcode.
- [Then](https://github.com/devxoul/Then) - ✨ Super sweet syntactic sugar for Swift initializers


## TO-DO
- 프로젝트 확장하며 RxFlow 안정화, 다양한 테스트 코드 추가
