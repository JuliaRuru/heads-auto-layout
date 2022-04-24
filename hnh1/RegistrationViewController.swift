//
//  AuthentificationViewController.swift
//  hnh1
//
//  Created by Юлия Руднева on 14.04.2022.
//  CustomButton1.swift

import UIKit

class RegistrationViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer (target: self, action: #selector (endEditing))
        view.addGestureRecognizer(tap)
        loginTextField.delegate = self
        passwordTextField.delegate = self
        passwordConfirmTextField.delegate = self
        registrationScrollView.delegate = self
        
        let attributes = [ NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 21.0)]
                
        loginTextField.attributedPlaceholder = NSAttributedString(string: "Введите логин", attributes: attributes)
        leftStep(loginTextField)
                
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Введите пароль", attributes: attributes)
        leftStep(passwordTextField)
        
        passwordConfirmTextField.attributedPlaceholder = NSAttributedString(string: "Повторите пароль", attributes: attributes)
        leftStep(passwordConfirmTextField)
    }
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var doneButton: FlickeringButton!
    @IBOutlet weak var registrationScrollView: UIScrollView!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
        }
        else if textField == passwordTextField {
            passwordConfirmTextField.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    @objc func endEditing() {
        view.endEditing(true)
    }
    
    func leftStep(_ textField: UITextField) {
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
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
        registrationScrollView.contentInset = .zero
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
        registrationScrollView.contentInset = .init(top: 0, left: 0, bottom: keybrdHeight, right: 0)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.registrationScrollView.contentOffset = CGPoint(x: 0, y:  activeFieldFrame/2)
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
