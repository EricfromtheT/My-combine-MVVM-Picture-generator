//
//  PictureView.swift
//  My combine AI picture
//
//  Created by 孔令傑 on 2023/2/8.
//

import UIKit

final class ChatRoomBaseView: UIView {
    let promptTextView = UITextView()
    let senderBackView = UIView()
    let sendButton = UIButton()
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
            chatTableView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    
    func setUpLook() {
        backgroundColor = .gray
        promptTextView.backgroundColor = .systemBackground
        promptTextView.layer.cornerRadius = 18
        promptTextView.font = UIFont.systemFont(ofSize: 21)
        senderBackView.backgroundColor = .black
        sendButton.backgroundColor = .label
        sendButton.setTitle("Send", for: .normal)
        sendButton.isEnabled = false
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
    
    func renewView(numOfRow: Int) {
        chatTableView.scrollToRow(at: IndexPath(row: numOfRow-1, section: 0), at: .bottom, animated: true)
    }
}
