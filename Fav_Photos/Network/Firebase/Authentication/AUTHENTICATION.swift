//
//  AUTHENTICATION.swift
//  Fav_Photos
//
//  Created by Decagon on 7/19/21.
//

import Foundation
import FirebaseAuth

class AuthManager {
    
    func validateLogin(with email: String, password: String, completion: @escaping ((Bool) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) {_, error in
            guard error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
    
}

