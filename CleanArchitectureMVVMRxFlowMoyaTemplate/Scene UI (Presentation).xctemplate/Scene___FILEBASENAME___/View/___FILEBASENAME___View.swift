//  ___FILEHEADER___

import DILayer // For Preview
import TSCoreUI
import SwiftUI

struct ___VARIABLE_productName:identifier___View: View {
    @ObservedObject var viewModel: ___VARIABLE_productName:identifier___ViewModel
    
    let input: ___VARIABLE_productName:identifier___ViewModel.Input
    
    init(viewModel: ___VARIABLE_productName:identifier___ViewModel) {
        self.viewModel = viewModel
        input = ___VARIABLE_productName:identifier___ViewModel.Input()
        viewModel.transform(input: input)
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

// MARK: - Previews
struct ___VARIABLE_productName:identifier___View_Previews: PreviewProvider {
    static var previews: some View {
        let appConfiguration = AppConfiguration(mode: .useSampleData, target: .dev)
        let diContainer = AppDIContainer(configuration: appConfiguration).makeSceneDIContainer()
        let viewModel = ___VARIABLE_productName:identifier___ViewModel(useCase: diContainer.make___VARIABLE_productName:identifier___SceneDIContainer().makeUseCase())
        return ___VARIABLE_productName:identifier___View(viewModel: viewModel)
    }
}
