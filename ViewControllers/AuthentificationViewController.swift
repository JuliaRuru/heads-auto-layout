//
//  ViewController.swift
//  hnh1
//
//  Created by Юлия Руднева on 05.04.2022.
//

import UIKit
import JGProgressHUD

class AuthentificationViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    let networkManager = ServiceLocator.authentificationNetworkManager()
    let storageManager = ServiceLocator.authentificationStorageManager()
    let progressHUD = JGProgressHUD()
    
    @IBOutlet weak var authLabel: UILabel!
    @IBOutlet weak var authTextLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var authStackView: UIStackView!
    @IBOutlet weak var authScrollView: UIScrollView!
    @IBAction func enterButtonClick(_ sender: Any) { checkForLogin() }
    @IBAction func registerButtonClick(_ sender: Any) { goToRegistration() }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressHUD.textLabel.text = "Loading"
        loginTextField.delegate = self
        passwordTextField.delegate = self
        authScrollView.delegate = self
        
        let tap = UITapGestureRecognizer (target: self, action: #selector (endEditing))
        view.addGestureRecognizer(tap)
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 21.0)]
                        
        loginTextField.attributedPlaceholder = NSAttributedString(string: "Login", attributes: attributes)
        leftStep(loginTextField)
                        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: attributes)
        leftStep(passwordTextField)
        
        authStackView.setCustomSpacing(26, after: authLabel)
        authStackView.setCustomSpacing(76, after: authTextLabel)
    }
    
    func checkForLogin() {
        progressHUD.show(in: self.view)
        networkManager.аuthentification(username: loginTextField.text ?? "", password: passwordTextField.text ?? "") { [ weak self ] (tokenResponse, error) in
            self?.progressHUD.dismiss()
            if let _ = error {
                AppSnackBar.showMessageSnackBar(in: self?.view, message: "Неверный логин или пароль")
            } else {
                guard let tokenResponse = tokenResponse
                    else {
                        AppSnackBar.showMessageSnackBar(in: self?.view, message: "Ошибка авторизации")
                        return
                    }
                self?.storageManager.saveToKeychain(tokenResponse.userId, key: .userId)
                self?.storageManager.saveToKeychain(tokenResponse.token, key: .token)
                self?.login()
            }
        }
    }

    func login() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarController")
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true)
    }

    func goToRegistration() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let registrationViewController = storyboard.instantiateViewController(identifier: "RegistrationViewController")
        registrationViewController.modalPresentationStyle = .fullScreen
        present(registrationViewController, animated: true)
    }
    
    func leftStep(_ textField: UITextField) {
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        }
        return true
    }
        
    @objc func endEditing() {
        view.endEditing(true)
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear (animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector (keyboardWillChange),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector (keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear (animated)
        NotificationCenter.default.removeObserver(self)
    }
        
    @objc func keyboardWillHide() {
        authScrollView.contentInset = .zero
    }
    
    @objc func keyboardWillChange(sender: Notification) {
        if let timeAnimation: NSValue = sender.userInfo? [UIResponder.keyboardAnimationDurationUserInfoKey] as? NSValue { print("Animation time of keyboard =", timeAnimation)
        }

        guard let keybrdFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let activeField = activeField
        else {
        return
        }
        
        let keybrdHeight = keybrdFrame.cgRectValue.height
        let activeFieldFrame = activeField.frame.origin.y
 
        authScrollView.contentInset = .init(top: 0, left: 0, bottom: keybrdHeight, right: 0)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.authScrollView.contentOffset = CGPoint(x: 0, y:  activeFieldFrame/2)
        })
    }
    
    var activeField: UITextField?

    func textFieldDidBeginEditing(_ textField: UITextField) {
            activeField = textField
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
            activeField = nil
    }
}
