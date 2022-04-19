//
//  ViewController.swift
//  hnh1
//
//  Created by Юлия Руднева on 05.04.2022.
//

import UIKit

class AuthentificationViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registrateButton: FlickeringButton!
    @IBOutlet weak var enterButton: FlickeringButton!
    @IBOutlet weak var authStackView: UIStackView!
    @IBOutlet weak var authScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer (target: self, action: #selector (endEditing))
        view.addGestureRecognizer(tap)
        loginTextField.delegate = self
        passwordTextField.delegate = self
        authScrollView.delegate = self
        
        let attributes = [ NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 21.0)]
                        
        loginTextField.attributedPlaceholder = NSAttributedString(string: "    Login", attributes: attributes)
                        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "    Password", attributes: attributes)
    }
    
//#Mark: return key for keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            passwordTextField.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        }
        return true
    }
        
//#Mark: for hiding keyboard with tap
    @objc func endEditing() {
        view.endEditing(true)
    }
        
//#Mark: tracking a keyboard for scroll
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
        
//#Mark: changing the placement of a scrollview for scroll
    @objc func keybrdDiDHide() {
        authScrollView.contentInset = .zero
    }

    @objc func keybrdDidChange(sender: Notification) {
        guard let keybrdFrame: NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else {
        return
        }
                
        let keybrdRectangle = keybrdFrame.cgRectValue
        let keybrdHeight = keybrdRectangle.height
        authScrollView.contentInset = .init(top: 0, left: 0, bottom: keybrdHeight, right: 0)
        


        
        
        
        
    }
}

