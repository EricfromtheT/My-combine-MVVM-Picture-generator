//
//  PictureView.swift
//  My combine AI picture
//
//  Created by 孔令傑 on 2023/2/8.
//

import UIKit
import Combine

final class ChatRoomBaseView: UIView {
    let promptTextView = UITextView()
    let senderBackView = UIView()
    let sendButton = UIButton()
    let chatTableView = ChatRoomTableView()
    let senderStack = UIStackView()
    private var sendSectionButtomConstraint: NSLayoutConstraint = NSLayoutConstraint()
    private var tableViewButtomConstraint: NSLayoutConstraint = NSLayoutConstraint()
    
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
        
        senderBackView.addSubview(senderStack)
        senderStack.translatesAutoresizingMaskIntoConstraints = false
        
        senderStack.addArrangedSubview(promptTextView)
        promptTextView.translatesAutoresizingMaskIntoConstraints = false

        senderStack.addArrangedSubview(sendButton)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints() {
        sendSectionButtomConstraint = senderBackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        tableViewButtomConstraint = chatTableView.bottomAnchor.constraint(equalTo: senderBackView.topAnchor)
        
        NSLayoutConstraint.activate([
            sendSectionButtomConstraint,
            senderBackView.heightAnchor.constraint(equalToConstant: 60),
            senderBackView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            
            senderStack.centerXAnchor.constraint(equalTo: senderBackView.centerXAnchor),
            senderStack.centerYAnchor.constraint(equalTo: senderBackView.centerYAnchor),
            promptTextView.widthAnchor.constraint(equalTo: senderBackView.widthAnchor, multiplier: 0.7),
            
            chatTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableViewButtomConstraint,
            chatTableView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    
    func setUpLook() {
        backgroundColor = .gray
        senderStack.spacing = 15
        senderStack.axis = .horizontal
        promptTextView.backgroundColor = .systemBackground
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
        if numOfRow > 0 {
            chatTableView.scrollToRow(at: IndexPath(row: numOfRow-1, section: 0), at: .top, animated: true)
        }
    }
    
    func renewButtonPosition(yOffset: CGFloat) {
        sendSectionButtomConstraint.isActive = false
        sendSectionButtomConstraint = senderBackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: yOffset)
        sendSectionButtomConstraint.isActive = true
    }
}
