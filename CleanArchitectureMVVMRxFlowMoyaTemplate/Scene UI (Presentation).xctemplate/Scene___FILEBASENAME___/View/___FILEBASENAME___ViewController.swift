//  ___FILEHEADER___

import TSCoreUI
import UIKit
import SwiftUI
import RxSwift
import SnapKit

class ___VARIABLE_productName:identifier___ViewController: BaseViewController {
    // MARK: - Views
    private lazy var hostingView: UIView = {
        addChild(hostingController)
        return hostingController.view
    }()
    
    // MARK: - Properties
    private let hostingController: UIHostingController<AnyView>
    private let rootView: ___VARIABLE_productName:identifier___View
    
    // MARK: - Initialize with ViewModel
    init(viewModel: ___VARIABLE_productName:identifier___ViewModel) {
        self.rootView = ___VARIABLE_productName:identifier___View(viewModel: viewModel)
        self.hostingController = UIHostingController(rootView: AnyView(rootView))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Necessary when the main scene closes (if not used, the flow won't be deinitialized)
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if isMovingFromParent {
            rootView.input.close.onNext(())
        }
    }
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        bindViewModel()
    }
}

// MARK: - Setup
private extension ___VARIABLE_productName:identifier___ViewController {
    func setupViews() {
        view.addSubview(hostingView)
        // Add subviews to the main view here
    }
    
    func setupConstraints() {
        hostingView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        // Define and activate the Auto Layout constraints for subviews here
    }
    
    func configureUI() {
        // Set values for other UI elements
    }
    
    func bindViewModel() {
        // Bind the UI elements to the ViewModel using RxSwift here
    }
}
