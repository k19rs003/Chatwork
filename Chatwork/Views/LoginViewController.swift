import UIKit

class LoginViewController: UIViewController {
    
//    let apiToken: String = "ba742aa3fb5857250e4f0cfe89824150"
    @IBOutlet weak var tokenTextField: UITextField!

    @IBAction func LoginButtonTapped(_ sender: UIButton) {
        print(tokenTextField!)
        guard let apiToken = tokenTextField.text else {
            return
        }
        
        ChatworkAPIProvider.shared.api(.me(apiToken: apiToken)) { result in
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
    

    override func viewDidLoad() {
        super.viewDidLoad()

//        ChatworkAPIProvider.shared.sendMessage(message: message)
        
        tokenTextField.delegate = self
        setDismissKeyboard()
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

//extension LoginViewController: UIViewController {
//    func hideKeyboardWhenTappedAround() {
//            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.hideKeyboard))
//            tap.cancelsTouchesInView = false
//            view.addGestureRecognizer(tap)
//        }
//
//        @objc func hideKeyboard() {
//            view.endEditing(true)
//        }
//}
