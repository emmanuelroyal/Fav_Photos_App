//
//  LoginViewModel.swift
//  Fav_Photos
//
//  Created by Decagon on 7/19/21.
//

import UIKit
import FirebaseAuth

class LoginViewModel {
    func loginUser(with email: String, password: String, completion: @escaping ((Bool) -> Void)) {
        let manager = AuthManager()
        manager.validateLogin(with: email, password: password) { success in
            completion(success)
        }
    }
    
    func toggle(passField: UITextField, secureButton: UIButton){
        passField.isSecureTextEntry.toggle()
        let imageName = passField.isSecureTextEntry ? "eye" : "eye.slash"
        secureButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
}

