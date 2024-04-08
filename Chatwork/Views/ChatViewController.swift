import UIKit
import Combine

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var roomId = 0
    var name = ""
    private var viewModel = ChatViewModel()
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTextField.delegate = self
        
        navigationItem.title = name
        // キーボード開閉のタイミングを取得
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(self.keyboardWillShow(_:)),
                                 name: UIResponder.keyboardWillShowNotification,
                                 object: nil)
        notification.addObserver(self, selector: #selector(self.keyboardWillHide(_:)),
                                 name: UIResponder.keyboardWillHideNotification,
                                 object: nil)
        
        // タップ認識するためのインスタンスを生成
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        // Viewに追加
        view.addGestureRecognizer(tapGesture)
        
        bindViewModel()
        viewModel.getMessages(roomId: roomId)
    }
    
    private func bindViewModel() {
           viewModel.$messages
               .receive(on: DispatchQueue.main)
               .sink { [weak self] _ in
                   self?.chatTableView.reloadData()
               }
               .store(in: &cancellables)
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        cell.create(name: viewModel.messages[indexPath.row].account.name, body: viewModel.messages[indexPath.row].body)
        return cell
    }
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        sendMessages()
    }
    
    private func getMessages() {
        guard let apiToken = UserDefaults.standard.string(forKey: "apiToken") else { return }
        ChatworkAPIProvider.shared.api(.messages(roomId: roomId, apiToken: apiToken, force: 1), modelType: [ReadMessagesModel].self) { result in
            switch result {
            case .success(let data):
                print("ReadMessages: \(data)")
                // ルームの配列を保持
                self.viewModel.messages = data
                // テーブルビューを更新
                DispatchQueue.main.async {
                    self.chatTableView.reloadData()
                }
            case .failure(let error):
                print("GetMessageError: \(error)")
            }
        }
    }

    private func sendMessages() {
        guard let apiToken = UserDefaults.standard.string(forKey: "apiToken") else { return }
        guard let message = messageTextField.text else { return }
        ChatworkAPIProvider.shared.api(.postMessages(roomId: roomId, apiToken: apiToken, postData: "self_unread=0&body=\(message)".data(using: .utf8)!), modelType: PostMessageModel.self ) { result in
            switch result {
            case .success(let data):
                print("PostMessages: \(data)")
                // ルームの配列を保持
//                self.messages = data
//                // テーブルビューを更新
//                DispatchQueue.main.async {
//                    self.chatTableView.reloadData()
//                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
}

extension ChatViewController: UITextFieldDelegate {
    @objc func keyboardWillShow(_ notification: Notification) {
        
        // キーボード、画面全体、textFieldのsizeを取得
        let rect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        guard let keyboardHeight = rect?.size.height else { return }
        let mainBoundsSize = UIScreen.main.bounds.size
        let textFieldHeight = bottomView.frame.height
        
        // ①
        let textFieldPositionY = bottomView.frame.origin.y + textFieldHeight + 10.0
        // ②
        let keyboardPositionY = mainBoundsSize.height - keyboardHeight
        
        // ③キーボードをずらす
        if keyboardPositionY <= textFieldPositionY {
            let duration: TimeInterval? = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
            UIView.animate(withDuration: duration!) {
                // viewをy座標方向にtransformする
                self.bottomView.transform = CGAffineTransform(translationX: 0, y: keyboardPositionY - textFieldPositionY)
//                self.chatTableView.transform = CGAffineTransform(translationX: 0, y: keyboardPositionY - textFieldPositionY)
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        let duration: TimeInterval? = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Double
        UIView.animate(withDuration: duration!) {
            self.bottomView.transform = CGAffineTransform.identity
//            self.chatTableView.transform = CGAffineTransform.identity
        }
    }
    
    
    // リターンがタップされた時にキーボードを閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // 画面をタップした時にキーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // キーボードと閉じる際の処理
    @objc public func dismissKeyboard() {
        view.endEditing(true)
    }
}
