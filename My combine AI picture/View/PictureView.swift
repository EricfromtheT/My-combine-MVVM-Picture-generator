//
//  PictureView.swift
//  My combine AI picture
//
//  Created by 孔令傑 on 2023/2/8.
//

import UIKit

class PictureView: UIView {
    
    var promptTextField = UITextField()
    var sendButton = UIButton()
    var stackView = UIStackView()
    var imageViews = [UIImageView(), UIImageView(), UIImageView()]
    var isValid: Bool = false {
        didSet {
            if isValid { turnButtonToEnabled() } else { turnOff() }
        }
    }
    
    init() {
        super.init(frame: .zero)
        addSubViews()
        setConstraints()
        setUpLook()
    }
    
    required init?(coder: NSCoder) {
        fatalError("initializer didn't be call out correctly")
    }
    
    func addSubViews() {
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        imageViews.forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addSubview(promptTextField)
        promptTextField.translatesAutoresizingMaskIntoConstraints = false

        addSubview(sendButton)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            promptTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 120),
            promptTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            promptTextField.widthAnchor.constraint(equalToConstant: 250),
            promptTextField.heightAnchor.constraint(equalToConstant: 50),
            sendButton.topAnchor.constraint(equalTo: promptTextField.bottomAnchor, constant: 20),
            sendButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: sendButton.bottomAnchor, constant: 60)
        ])
        
        imageViews.forEach {
            $0.heightAnchor.constraint(equalToConstant: 150).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 150).isActive = true
            $0.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true
        }
    }
    
    func setUpLook() {
        backgroundColor = .gray
        promptTextField.backgroundColor = .systemBackground
        promptTextField.borderStyle = .roundedRect
        imageViews.forEach {
            $0.backgroundColor = .systemBackground
        }
        sendButton.backgroundColor = .label
        sendButton.setTitle("Send", for: .normal)
        sendButton.isEnabled = false
    }
    
    func turnButtonToEnabled() {
        sendButton.backgroundColor = .systemPink
        sendButton.isEnabled = true
    }
    
    func turnOff() {
        sendButton.backgroundColor = .label
        sendButton.isEnabled = false
    }
}
