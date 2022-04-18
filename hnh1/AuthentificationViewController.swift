//
//  AuthentificationViewController.swift
//  hnh1
//
//  Created by Юлия Руднева on 14.04.2022.
//  CustomButton1.swift

import UIKit

class AuthentificationViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer (target: self, action: #selector (endEditing))
        view.addGestureRecognizer(tap)
        loginTextField.delegate = self
        passwordTextField.delegate = self
        passwordConfirmTextField.delegate = self
    }
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var doneButton: MyButton!
    
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
}

class MyButton: UIButton {
    override open var isHighlighted: Bool {
            didSet {
                self.backgroundColor = isHighlighted ? .green : .orange
            }
        }
}
