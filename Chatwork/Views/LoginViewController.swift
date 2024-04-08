import UIKit
import Combine

class LoginViewController: UIViewController {
    @IBOutlet weak var tokenTextField: UITextField! {
        didSet {
            tokenTextField.delegate = self
        }
    }
    
    private var viewModel = LoginViewModel()
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
    }
    
    private func bindViewModel() {
            viewModel.$isLoggedIn
                .receive(on: DispatchQueue.main)
                .sink { [weak self] isLoggedIn in
                    if isLoggedIn {
                        print("Logged in!")
                        let storyboard: UIStoryboard = UIStoryboard(name: "ChatList", bundle: nil)
                        let navigationController = storyboard.instantiateViewController(withIdentifier: "chatList") as! UINavigationController
                        self?.present(navigationController, animated: true, completion: nil)
                    }
                }
                .store(in: &cancellables)
        }

    override func viewDidAppear(_ animated: Bool) {
        if let _ = UserDefaults.standard.string(forKey: "apiToken") {
            print("Logged in!")
            //遷移先のStoryboardを設定
            let storyboard: UIStoryboard = UIStoryboard(name: "ChatList", bundle: nil)
            //遷移先のNavigationControllerを設定
            let navigationController = storyboard.instantiateViewController(withIdentifier: "chatList") as! UINavigationController
            self.present(navigationController, animated: true, completion: nil)
        }
        setDismissKeyboard()
    }

    @IBAction func LoginButtonTapped(_ sender: UIButton) {
        print(tokenTextField!)
        guard let apiToken = tokenTextField.text else {
            return
        }
        viewModel.login(apiToken: apiToken)
    }
    

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func setDismissKeyboard() {
          let tapGR: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
          tapGR.cancelsTouchesInView = false
          self.view.addGestureRecognizer(tapGR)
      }

      @objc func dismissKeyboard() {
          self.view.endEditing(true)
      }
}
