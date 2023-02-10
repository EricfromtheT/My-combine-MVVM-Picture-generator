//
//  PictureView.swift
//  My combine AI picture
//
//  Created by 孔令傑 on 2023/2/8.
//

import UIKit

final class PictureView: UIView {
    let promptTextView = UITextView()
    let senderBackView = UIView()
    let sendButton = UIButton()
    let stackView = UIStackView()
    let imageViews = [UIImageView(), UIImageView(), UIImageView()]
    let chatTableView = ChatRoomTableView()
    var isValid: Bool = false {
        didSet {
            switchButtonStatus(canBeOpend: isValid)
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
        imageViews.forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        chatTableView.addSubview(stackView)
        
        addSubview(senderBackView)
        senderBackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(chatTableView)
        chatTableView.translatesAutoresizingMaskIntoConstraints = false
        
        senderBackView.addSubview(promptTextView)
        promptTextView.translatesAutoresizingMaskIntoConstraints = false

        senderBackView.addSubview(sendButton)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints() {
        guard let textViewSuper = promptTextView.superview else { return print("wrong with finding promptTextView super view") }
        NSLayoutConstraint.activate([
            senderBackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            senderBackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50),
            senderBackView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            promptTextView.topAnchor.constraint(equalTo: textViewSuper.topAnchor, constant: 10),
            promptTextView.leadingAnchor.constraint(equalTo: textViewSuper.leadingAnchor, constant: 20),
            promptTextView.widthAnchor.constraint(equalTo: textViewSuper.widthAnchor, multiplier: 0.78),
            promptTextView.heightAnchor.constraint(equalToConstant: 40),
            sendButton.leadingAnchor.constraint(equalTo: promptTextView.trailingAnchor, constant: 10),
            sendButton.centerYAnchor.constraint(equalTo: promptTextView.centerYAnchor),
            chatTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            chatTableView.bottomAnchor.constraint(equalTo: senderBackView.topAnchor),
            chatTableView.widthAnchor.constraint(equalTo: self.widthAnchor),
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
        
        imageViews.forEach {
            $0.heightAnchor.constraint(equalToConstant: 150).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 150).isActive = true
            $0.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true
        }
    }
    
    func setUpLook() {
        backgroundColor = .gray
        promptTextView.backgroundColor = .systemBackground
        promptTextView.layer.cornerRadius = 18
        promptTextView.font = UIFont.systemFont(ofSize: 21)
        senderBackView.backgroundColor = .black
        imageViews.forEach {
            $0.backgroundColor = .systemBackground
        }
        sendButton.backgroundColor = .label
        sendButton.setTitle("Send", for: .normal)
        sendButton.isEnabled = false
        chatTableView.backgroundColor = .systemGray5
    }
    
    func switchButtonStatus(canBeOpend: Bool) {
        if canBeOpend {
            sendButton.backgroundColor = .systemPink
            sendButton.isEnabled = true
        } else {
            sendButton.backgroundColor = .label
            sendButton.isEnabled = false
        }
    }
}
