//  
//  SplashView.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2023/03/20.
//

import TSCoreUI
import SwiftUI

public struct SplashView: View {
    @ObservedObject var viewModel: SplashViewModel
    
    public init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        Text("Splash Screen")
            .font(.largeTitle)
            .onAppear {
                viewModel.close()
            }
    }
}

// MARK: - Previews
struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = SplashViewModel()
        return SplashView(viewModel: viewModel)
    }
}
