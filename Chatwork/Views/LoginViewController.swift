import UIKit

class LoginViewController: UIViewController {
    var message = "もえぞう"
    let apiToken: String = "6222c8e21f1c4f6905a0da78e5804ceb"
    @IBOutlet weak var tokenTextField: UITextField!

    @IBAction func LoginButtonTapped(_ sender: UIButton) {
        print(tokenTextField!)
        ChatworkAPIProvider.shared.api(.me(apiToken: apiToken)) { result in
            switch result {
            case .success(let data):
//                self?.data = data
                print("data: \(data)")
                let storyboard: UIStoryboard = UIStoryboard(name: "ChatList", bundle: nil)//遷移先のStoryboardを設定
                   let navigationController = storyboard.instantiateViewController(withIdentifier: "chatList") as! UINavigationController//遷移先のNavigationControllerを設定
                   self.present(navigationController, animated: true, completion: nil)//遷移する
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
