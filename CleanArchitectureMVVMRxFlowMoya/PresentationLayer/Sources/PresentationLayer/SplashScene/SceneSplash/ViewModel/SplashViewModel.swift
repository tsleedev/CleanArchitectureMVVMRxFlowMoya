//  
//  SplashViewModel.swift
//  
//
//  Created by TAE SU LEE on 2023/03/20.
//

import TSCore
import Foundation
import RxSwift
import RxCocoa
import RxFlow

public final class SplashViewModel: DetectDeinit, Stepper, ObservableObject {
    public let steps = PublishRelay<Step>()
    
    func close() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.steps.accept(SplashStep.mainIsComplete)
        }
    }
}
