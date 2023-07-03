//  
//  SettingsView.swift
//  
//
//  Created by TAE SU LEE on 2023/03/20.
//

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
        VStack {
            List(viewModel.items) { item in
                Text(item.title)
            }
            Button(action: {
                input.popViewController.onNext(())
            }, label: {
                Text("POP")
            })
        }
        .onAppear {
            input.trigger.onNext(())
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import DILayer

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let appConfiguration = AppConfiguration(mode: .useSampleData, target: .dev)
        let diContainer = AppDIContainer(configuration: appConfiguration).makeSceneDIContainer()
        let viewModel = SettingsViewModel(useCase: diContainer.makeSettingsSceneDIContainer().makeUseCase())
        return SettingsView(viewModel: viewModel)
    }
}
#endif
