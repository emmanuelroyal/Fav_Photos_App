//
//  ViewModel.swift
//  Fav_Photos
//
//  Created by Decagon on 7/19/21.
//

import UIKit
import FirebaseAuth

class SignupViewModel {
    
    func signupUser(with email: String, password: String, completion: @escaping ((Bool) -> Void)) {
        
    }
    
    func validateTextField(inView: UIViewController, fullName: String, email: String, password: String) {
        if !fullName.hasWhiteSpace {
            inView.showAlert(alertText: "Oops", alertMessage: "Please, enter your firstname and lastname")
        }
        
        if fullName == "" {
            inView.showAlert(alertText: "Oops", alertMessage: "Please, enter your full name")
        }
        
        if email == "" {
            inView.showAlert(alertText: "Oops", alertMessage: "Please, enter your email")
        }
        
        if email  == "" && email.isValidEmail == false {
            inView.showAlert(alertText: "Invalid Email", alertMessage: "Please, enter a valid email")
        }
        
        if password == "" {
            inView.showAlert(alertText: "Oops", alertMessage: "Please enter your password")
        }
        
        if password != "" && password.isValidPassword == false {
            inView.showAlert(alertText: "Oops",
                             alertMessage: "Password must be alphanumeric and must be greater than 8 characters")
        }
    }
    
    func toggle(passField: UITextField, secureButton: UIButton){
        passField.isSecureTextEntry.toggle()
        let imageName = passField.isSecureTextEntry ? "eye" : "eye.slash"
        secureButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    func loginUser(with email: String, password: String, completion: @escaping ((Bool) -> Void)) {
        let manager = AuthManager()
        manager.validateLogin(with: email, password: password) { success in
            completion(success)
        }
    }
    

}
