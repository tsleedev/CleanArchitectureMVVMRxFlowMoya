//
//  ViewModelType.swift
//  
//
//  Created by TAE SU LEE on 2022/11/15.
//

import RxSwift

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set }
    
    func transform(input: Input) -> Output
}
