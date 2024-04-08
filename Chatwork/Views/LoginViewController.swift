import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var tokenTextField: UITextField! {
        didSet {
            tokenTextField.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

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
        ChatworkAPIProvider.shared.api(.me(apiToken: apiToken), modelType: MeModel.self) { result in
            switch result {
            case .success(let data):
                print("data: \(data)")
                UserDefaults.standard.set(apiToken, forKey: "apiToken")
                
                //遷移先のStoryboardを設定
                let storyboard: UIStoryboard = UIStoryboard(name: "ChatList", bundle: nil)
                //遷移先のNavigationControllerを設定
                let navigationController = storyboard.instantiateViewController(withIdentifier: "chatList") as! UINavigationController
                self.present(navigationController, animated: true, completion: nil)
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
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
