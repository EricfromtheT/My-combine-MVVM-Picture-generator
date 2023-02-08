//
//  PicViewController.swift
//  My combine AI picture
//
//  Created by 孔令傑 on 2023/2/8.
//

import UIKit
import Combine

class PicViewController: UIViewController {

    private let contentView = PictureView()
    private let picViewModel = PicViewModel()
    private var bindings = [AnyCancellable]()
        
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        setUpBindings()
        setUpTarget()
    }
    
    private func setUpTarget() {
        contentView.sendButton.addTarget(self,
                                         action: #selector(sendRequest),
                                         for: .touchUpInside)
    }
    
    private func setUpBindings() {
        // ViewModel 監聽 VC 的行為
        func bindViewToViewModel() {
            // 將使用者輸入的文字傳到 viewModel 的 login property 裏面
            contentView.promptTextField.textPublisher
                .receive(on: DispatchQueue.main)
                .assign(to: \.prompt, on: picViewModel)
                .store(in: &bindings)
        }
        
        // VC 監聽 ViewModel 的行為
        func bindViewModelToView() {
            picViewModel.$isValid
                .assign(to: \.isValid, on: contentView)
                .store(in: &bindings)
        
            picViewModel.urlResult
                .receive(on: DispatchQueue.main)
                .sink {
                    for index in 0...2 {
                        self.contentView.imageViews[index].loadImage($0[index])
                    }
                }
                .store(in: &bindings)
        }
        
        bindViewToViewModel()
        bindViewModelToView()
    }
    
    @objc private func sendRequest() {
        picViewModel.callAPI()
    }
}
