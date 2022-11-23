//
//  WebViewController.swift
//  CleanArchitectureMVVMRxFlowMoya
//
//  Created by TAE SU LEE on 2022/11/16.
//

import UIKit
import Platform
import WebKit
import SnapKit
import Then

class WebViewController: BaseViewController {
    
    private lazy var webView = WKWebView().then {
        $0.uiDelegate = self
    }
    
    private var didSetupConstraints = false
    
    private let viewModel: WebViewModel
    
    init(viewModel: WebViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        bindViewModel()
    }
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            webView.snp.makeConstraints { make in
                make.top.equalTo((view.safeAreaLayoutGuide))
                make.leading.trailing.bottom.equalToSuperview()
            }
            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
}

// MARK: - Setup
private extension WebViewController {
    func initView() {
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.setNeedsUpdateConstraints()
    }
    
    func bindViewModel() {
        let input = WebViewModel.Input()
        
        let output = viewModel.transform(input: input)
        
        title = output.title
        loadWebView(output.startUrl)
    }
    
    func loadWebView(_ urlString: String?) {
        guard
            let urlString = urlString,
            let url = URL(string: urlString)
        else { return }
        let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 35.0)
        webView.load(request)
    }
}

// MARK: - WKUIDelegate
extension WebViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alertController.addAction(
            UIAlertAction(title: "확인", style: .cancel, handler: { _ in
                completionHandler()
            })
        )
        alertController.modalPresentationStyle = .fullScreen
        present(alertController, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alertController.addAction(
            UIAlertAction(title: "확인", style: .cancel, handler: { _ in
                completionHandler(true)
            })
        )
        alertController.addAction(
            UIAlertAction(title: "취소", style: .default, handler: { _ in
                completionHandler(false)
            })
        )
        alertController.modalPresentationStyle = .fullScreen
        present(alertController, animated: true, completion: nil)
    }
}
