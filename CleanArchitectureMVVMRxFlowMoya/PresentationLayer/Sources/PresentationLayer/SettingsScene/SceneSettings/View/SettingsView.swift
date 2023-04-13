//  
//  SettingsView.swift
//  
//
//  Created by TAE SU LEE on 2023/03/20.
//

import DILayer // For Preview
import TSCoreUI
import SwiftUI

struct SettingsView: View {
    @ObservedObject private var viewModel: SettingsViewModel
    
    let input: SettingsViewModel.Input
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        input = SettingsViewModel.Input()
        viewModel.transform(input: input)
    }
    
    var body: some View {
        List(viewModel.items) { item in
            Text(item.title)
        }
        .onAppear {
            input.trigger.onNext(())
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let appConfiguration = AppConfiguration(mode: .useSampleData, target: .dev)
        let diContainer = AppDIContainer(configuration: appConfiguration)
        let viewModel = SettingsViewModel(useCase: diContainer.makeSettingsSceneDIContainer().makeUseCase())
        return SettingsView(viewModel: viewModel)
    }
}
