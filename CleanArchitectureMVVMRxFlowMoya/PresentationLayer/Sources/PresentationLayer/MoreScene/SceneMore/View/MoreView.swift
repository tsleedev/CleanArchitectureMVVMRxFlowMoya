//  
//  MoreView.swift
//  
//
//  Created by TAE SU LEE on 2023/03/17.
//

import DILayer // For Preview
import TSCoreUI
import SwiftUI

struct MoreView: View {
    @ObservedObject var viewModel: MoreViewModel
    
    let input: MoreViewModel.Input
    
    init(viewModel: MoreViewModel) {
        self.viewModel = viewModel
        input = MoreViewModel.Input()
        viewModel.transform(input: input)
    }
    
    var body: some View {
        List(viewModel.items) { item in
            Button {
                input.didSelect.onNext(item)
            } label: {
                Text(item.title)
            }
        }
        .onAppear {
            input.trigger.onNext(())
        }
    }
}

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        let appConfiguration = AppConfiguration(mode: .useSampleData, target: .dev)
        let diContainer = AppDIContainer(configuration: appConfiguration).makeSceneDIContainer()
        let viewModel = MoreViewModel(useCase: diContainer.makeMoreSceneDIContainer().makeUseCase())
        return MoreView(viewModel: viewModel)
    }
}
