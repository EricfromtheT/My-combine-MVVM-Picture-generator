//
//  PicViewController.swift
//  My combine AI picture
//
//  Created by 孔令傑 on 2023/2/8.
//

import UIKit
import Combine

class ChatRoomViewController: UIViewController {
    
    private let contentView = ChatRoomBaseView()
    private let picViewModel = PicViewModel()
    private var bindings = [AnyCancellable]()
    private let uuidGenerator = UUID()
    
    typealias DataSource = UITableViewDiffableDataSource<Int, ContentInfo>
    typealias SnapShot = NSDiffableDataSourceSnapshot<Int, ContentInfo>
    
    private lazy var dataSource = createDataSource()
    private var contents: [ContentInfo] = [] {
        didSet {
            configureSnapshot()
        }
    }
    private var sentText = ""

    // MARK: Life Cycle
    override func loadView() {
        self.view = contentView
    }
    
    override func viewDidLoad() {
        setUpBindings()
        setUpTarget()
        dismissKeyboardByTouch()
    }
    
    private func setUpTarget() {
        contentView.sendButton.addTarget(self,
                                         action: #selector(sendRequest),
                                         for: .touchUpInside)
    }
    
    private func createDataSource() -> DataSource {
        return DataSource(tableView: contentView.chatTableView) {
            tableView, indexPath, data in
            let type = data.type
            guard let cell = tableView.dequeueReusableCell(withIdentifier: type.cellIdentifier, for: indexPath) as? ChatCell else {
                fatalError("error of dequeuing ChatCell")
            }
            cell.configure(data: self.contents[indexPath.row])
            return cell
        }
    }
    
    private func configureSnapshot() {
        var snapShot = SnapShot()
        snapShot.appendSections([0])
        snapShot.appendItems(contents)
        dataSource.apply(snapShot, animatingDifferences: true)
        contentView.renewView(numOfRow: contents.count)
    }
    
    private func setUpBindings() {
        // ViewModel 監聽 VC 的行為
        func bindViewToViewModel() {
            // 將使用者輸入的文字傳到 viewModel 的 login property 裏面
            contentView.promptTextView.textViewPublisher
                .receive(on: DispatchQueue.main)
                .assign(to: \.prompt, on: picViewModel)
                .store(in: &bindings)
            
            contentView.promptTextView.textViewPublisher
                .receive(on: DispatchQueue.main)
                .sink { [weak self] prompt in
                    guard let self = self else { return }
                    self.sentText = prompt
                }
                .store(in: &bindings)
        }
        
        // VC 監聽 ViewModel 的行為
        func bindViewModelToView() {
            picViewModel.isValid
                .assign(to: \.isValid, on: contentView)
                .store(in: &bindings)
        
            picViewModel.urlResult
                .receive(on: DispatchQueue.main)
                .sink { [weak self] urls in
                    guard let self = self else { return }
                    urls.forEach {
                        let info = ContentInfo(type: .imageType,
                                               data: $0)
                        self.contents.append(info)
                    }
                    self.configureSnapshot()
                }
                .store(in: &bindings)
        }
        
        bindViewToViewModel()
        bindViewModelToView()
    }
    
    @objc private func sendRequest() {
        picViewModel.callAPI()
        sendPrompt()
    }
    
    private func sendPrompt() {
        let info = ContentInfo(type: .textType,
                               data: sentText)
        contents.append(info)
        configureSnapshot()
    }
    
    private func dismissKeyboardByTouch() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(touch))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func touch() {
        view.endEditing(true)
    }
}
