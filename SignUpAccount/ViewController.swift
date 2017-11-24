//
//  ViewController.swift
//  SignUpAccount
//
//  Created by Safhone Oung on 11/24/17.
//  Copyright © 2017 Safhone Oung. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    private var codePhoneNumberForCambodiaTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldMakeDelegateAndRoundAtTheEdge(textFields: userNameTextField, passwordTextField, phoneNumberTextField, emailTextField)
        
        codePhoneNumberForCambodiaTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 68, height: passwordTextField.frame.height))
        codePhoneNumberForCambodiaTextField.font = phoneNumberTextField.font
        codePhoneNumberForCambodiaTextField.placeholder = "(+855)"
        codePhoneNumberForCambodiaTextField.textAlignment = .right
        codePhoneNumberForCambodiaTextField.delegate = self
        phoneNumberTextField.leftView = codePhoneNumberForCambodiaTextField
        phoneNumberTextField.leftViewMode = .always
        phoneNumberTextField.addTarget(self, action: #selector(formatPhoneNumber(textField:)), for: .editingChanged)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "successSignUpIdentifier" {
            let signUpSuccess: SignUpSuccessViewController = segue.destination as! SignUpSuccessViewController
            signUpSuccess.userName = userNameTextField.text
        }
    }
    
    private func textFieldMakeDelegateAndRoundAtTheEdge(textFields: UITextField...) {
        for eachTextField in textFields {
            eachTextField.borderStyle = .roundedRect
            eachTextField.delegate = self
        }
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        userNameTextField.text = nil
        passwordTextField.text = nil
        phoneNumberTextField.text = nil
        emailTextField.text = nil
        codePhoneNumberForCambodiaTextField.text = nil
    }
    
    @objc private func formatPhoneNumber(textField: UITextField) {
        let cleanPhoneNumber = textField.text!.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "XXX-XXX-XXXX"
        var result = ""
        var index = cleanPhoneNumber.startIndex
        
        for ch in mask {
            if index == cleanPhoneNumber.endIndex {
                break
            }
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        
        textField.text = result
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        switch textField {
        case userNameTextField: passwordTextField.becomeFirstResponder()
        case passwordTextField: phoneNumberTextField.becomeFirstResponder()
        default: break
        }
        
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case phoneNumberTextField: codePhoneNumberForCambodiaTextField.text = "(+855)"
        case codePhoneNumberForCambodiaTextField where !phoneNumberTextField.isFirstResponder:
            phoneNumberTextField.becomeFirstResponder()
            return false
        default: codePhoneNumberForCambodiaTextField.text = phoneNumberTextField.text == "" || phoneNumberTextField.text == nil ? "" : "(+855)"
        }
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case phoneNumberTextField where isEqual("") || isEqual(nil): codePhoneNumberForCambodiaTextField.text = ""
        default: break
        }
        
        return true
    }
}
