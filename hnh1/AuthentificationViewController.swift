//
//  ViewController.swift
//  hnh1
//
//  Created by Юлия Руднева on 05.04.2022.
//

import UIKit

class AuthentificationViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var authLabel: UILabel!
    @IBOutlet weak var authTextLabel: UILabel!
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var authStackView: UIStackView!
    @IBOutlet weak var authScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        authScrollView.delegate = self
        
        let tap = UITapGestureRecognizer (target: self, action: #selector (endEditing))
        view.addGestureRecognizer(tap)
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 21.0)]
                        
        loginTextField.attributedPlaceholder = NSAttributedString(string: "    Login", attributes: attributes)
                        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "    Password", attributes: attributes)
        
        authStackView.setCustomSpacing(26, after: authLabel)
        authStackView.setCustomSpacing(76, after: authTextLabel)
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
        self.view.frame.origin.y = 0.0

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
        authScrollView.contentInset = .zero
    }
    
    @objc func keybrdDidChange(sender: Notification) {
        guard let timeAnimation: NSValue = sender.userInfo? [UIResponder.keyboardAnimationDurationUserInfoKey] as? NSValue
        else {
        return
        }
        print("Animation time of keyboard =", timeAnimation)

        guard let keybrdFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else {
        return
        }
        
        guard let activeField = activeField
        else {
        return
        }
        
        let keybrdRectangle = keybrdFrame.cgRectValue
        let keybrdHeight = keybrdRectangle.height
        let contentSize = UIScreen.main.bounds
        let contentHeight = contentSize.size.height
//        let textFieldFrame = activeField.convert(activeField.frame, from: authScrollView).minY
        let center = (contentHeight - keybrdHeight)/2
        let textFieldFrame = activeField.frame.origin.y

        authScrollView.contentInset = .init(top: 0, left: 0, bottom: keybrdHeight, right: 0)
        
        print("scrollView offset =", authScrollView.contentOffset)
        print("contentHeight", contentHeight)
        print("textFieldFrame", textFieldFrame)
        
        if textFieldFrame > center {
            UIView.animate(withDuration: 0.3, animations: {
                self.authScrollView.frame.origin.y = (textFieldFrame - center)
            })
        }
        else if textFieldFrame < center {
            UIView.animate(withDuration: 0.3, animations: {
                self.authScrollView.frame.origin.y = (center - textFieldFrame)
            })
        }
    }
    
    var activeField: UITextField?

    func textFieldDidBeginEditing(_ textField: UITextField) {
            activeField = textField
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
            activeField = nil
    }
}
