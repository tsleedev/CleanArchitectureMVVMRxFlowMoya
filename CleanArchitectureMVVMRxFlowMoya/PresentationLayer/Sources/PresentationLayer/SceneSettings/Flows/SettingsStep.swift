//  
//  SettingsStep.swift
//  
//
//  Created by TAE SU LEE on 2023/03/20.
//

import RxFlow

public enum SettingsStep: Step {
    case mainIsRequired
    case mainIsComplete
    case mainIsCompleteModal
    case flowCompleted
}
