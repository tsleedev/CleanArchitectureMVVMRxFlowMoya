//  
//  MoreStep.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2023/03/17.
//

import RxFlow

public enum MoreStep: Step {
    case mainIsRequired
    case mainIsComplete
    case flowCompleted
    case detailIsRequired
    case settingsAreRequired
}
