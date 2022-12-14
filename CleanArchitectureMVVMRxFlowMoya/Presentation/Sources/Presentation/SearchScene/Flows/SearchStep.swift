//
//  SearchStep.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2022/11/16.
//

import RxFlow

public enum SearchStep: Step {
    case start
    case detail(viewModel: SearchItemViewModel)
}
