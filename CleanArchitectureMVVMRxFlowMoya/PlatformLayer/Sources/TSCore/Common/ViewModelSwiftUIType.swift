//
//  ViewModelSwiftUIType.swift
//  
//
//  Created by TAE SU LEE on 2023/03/22.
//

import RxSwift

public protocol ViewModelSwiftUIType {
    associatedtype Input
    
    var disposeBag: DisposeBag { get set }
    
    func transform(input: Input)
}
