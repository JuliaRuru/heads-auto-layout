//
//  AuthentificationViewController.swift
//  hnh1
//
//  Created by Юлия Руднева on 14.04.2022.
//  CustomButton1.swift

import UIKit

class RegistrationViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer (target: self, action: #selector (endEditing))
        view.addGestureRecognizer(tap)
        loginTextField.delegate = self
        passwordTextField.delegate = self
        passwordConfirmTextField.delegate = self
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
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
}
