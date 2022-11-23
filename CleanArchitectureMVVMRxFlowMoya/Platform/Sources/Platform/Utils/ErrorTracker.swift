//
//  ErrorTracker.swift
//  CleanArchitectureRxSwift_Gunter
//
//  Created by Gunter on 2020/05/05.
//  Copyright © 2020 Gunter. All rights reserved.
//
//  https://github.com/sergdort/CleanArchitectureRxSwift/blob/master/CleanArchitectureRxSwift/Utility/ErrorTracker.swift
//

import Foundation
import RxSwift
import RxCocoa

final public class ErrorTracker: SharedSequenceConvertibleType {
    public typealias SharingStrategy = DriverSharingStrategy
    private let _subject = PublishSubject<Error>()
    
    public init() { }

    fileprivate func trackError<O: ObservableConvertibleType>(from source: O) -> Observable<O.Element> {
        return source.asObservable().do(onError: onError)
    }

    public func asSharedSequence() -> SharedSequence<SharingStrategy, Error> {
        return _subject.asObservable().asDriver(onErrorRecover: { _ in Driver.empty() })
    }

    public func asObservable() -> Observable<Error> {
        return _subject.asObservable()
    }

    private func onError(_ error: Error) {
        _subject.onNext(error)
    }
    
    deinit {
        _subject.onCompleted()
    }
}

extension ObservableConvertibleType {
    public func trackError(_ errorTracker: ErrorTracker) -> Observable<Element> {
        return errorTracker.trackError(from: self)
    }
}
