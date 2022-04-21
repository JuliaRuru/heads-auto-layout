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
                
        loginTextField.attributedPlaceholder = NSAttributedString(string: "    Введите логин", attributes: attributes)
                
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "    Введите пароль", attributes: attributes)
        
        passwordConfirmTextField.attributedPlaceholder = NSAttributedString(string: "    Повторите пароль", attributes: attributes)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear (animated)
        NotificationCenter.default.addObserver(self,
                                                selector: #selector (keybrdDidChange),
                                                name: UIResponder.keyboardWillShowNotification,
                                                object: nil)
        NotificationCenter.default.addObserver(self,
                                                selector: #selector (keybrdDiDHide),
                                                name: UIResponder.keyboardWillHideNotification,
                                                object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear (animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keybrdDiDHide() {
        registrationScrollView.contentInset = .zero
    }

    @objc func keybrdDidChange(sender: Notification) {
        guard let keybrdFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else {
        return
        }
            
        let keybrdRectangle = keybrdFrame.cgRectValue
        let keybrdHeight = keybrdRectangle.height
        registrationScrollView.contentInset = .init(top: 0, left: 0, bottom: keybrdHeight, right: 0)
    }

}
