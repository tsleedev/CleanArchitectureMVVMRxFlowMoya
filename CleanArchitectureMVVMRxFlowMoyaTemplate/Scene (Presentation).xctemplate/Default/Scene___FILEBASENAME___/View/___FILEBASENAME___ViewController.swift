//  ___FILEHEADER___

import TSCore
import TSCoreUI
import UIKit
import RxSwift
import SnapKit
import Then

class ___VARIABLE_productName:identifier___ViewController: BaseViewController {
    // MARK: - IBOutlet
    
    // MARK: - Views
    
    // MARK: - Properties
    private var input: ___VARIABLE_productName:identifier___ViewModel.Input?
    
    // MARK: - Initialize with ViewModel
    private let viewModel: ___VARIABLE_productName:identifier___ViewModel
    
    init(viewModel: ___VARIABLE_productName:identifier___ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: Bundle.module)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        configureUI()
        bindViewModel()
    }
    
    /*
    // Necessary when the main scene closes (if not used, the flow won't be deinitialized)
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if isMovingFromParent {
            input?.flowCompleted.onNext(())
        }
    }
     */
}

// MARK: - Setup
private extension ___VARIABLE_productName:identifier___ViewController {
    func setupViews() {
        // Add subviews to the main view here
    }
    
    func setupConstraints() {
        // Define and activate the Auto Layout constraints for subviews here
    }
    
    func configureUI() {
        // Set initial values for other UI elements
        
        // Set localization for UI elements
    }
    
    func bindViewModel() {
        let input = ___VARIABLE_productName:identifier___ViewModel.Input()
        self.input = input
        
        let output = viewModel.transform(input: input)
        // Bind the UI elements to the ViewModel using RxSwift here
    }
}

#if canImport(SwiftUI) && DEBUG
import DILayer
import SwiftUI

struct ___VARIABLE_productName:identifier___View_Previews: PreviewProvider {
    static var previews: some View {
//        let mockData = [JSONFile.___VARIABLE_productName:identifier___.data.fileName: JSONFile.___VARIABLE_productName:identifier___.data.sampleData]
//        let appConfiguration = AppConfiguration(forPreviewWithTarget: .dev, mockData: mockData)
        let appConfiguration = AppConfiguration(forPreviewWithTarget: .dev, mockData: nil)
        let diContainer = AppDIContainer(configuration: appConfiguration).makeSceneDIContainer()
        let viewModel = ___VARIABLE_productName:identifier___ViewModel(useCase: diContainer.make___VARIABLE_productName:identifier___SceneDIContainer().makeUseCase())
        return ___VARIABLE_productName:identifier___View(viewModel: viewModel)
    }
}
#endif
