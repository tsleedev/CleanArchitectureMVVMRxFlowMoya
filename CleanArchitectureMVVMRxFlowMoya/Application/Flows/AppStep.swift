//
//  AppStep.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2022/11/16.
//

import Presentation
import RxFlow

enum AppStep: Step {
    case mainIsRequired
    case webIsRequired(viewModel: WebItemViewModel, isRoot: Bool)
}
