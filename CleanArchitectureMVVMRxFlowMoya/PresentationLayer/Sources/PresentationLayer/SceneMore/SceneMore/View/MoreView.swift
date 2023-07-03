//  
//  MoreView.swift
//  
//
//  Created by TAE SU LEE on 2023/03/17.
//

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
        VStack {
            List(viewModel.items) { item in
                Button {
                    input.didSelect.onNext(item)
                } label: {
                    Text(item.title)
                }
            }
            Button(action: {
                input.restartApp.onNext(())
            }, label: {
                Text("RESTART APP")
            })
        }
        .onAppear {
            input.trigger.onNext(())
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import DILayer

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        let mockData = [JSONFile.More.readItems200.fileName: JSONFile.More.readItems200.sampleData]
        let appConfiguration = AppConfiguration(forPreviewWithTarget: .dev, mockData: mockData)
        let diContainer = AppDIContainer(configuration: appConfiguration).makeSceneDIContainer()
        let viewModel = MoreViewModel(useCase: diContainer.makeMoreSceneDIContainer().makeUseCase())
        return MoreView(viewModel: viewModel)
    }
}
#endif
