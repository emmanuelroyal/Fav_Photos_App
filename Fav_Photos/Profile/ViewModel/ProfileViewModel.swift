//
//  ProfileViewModel.swift
//  Fav_Photos
//
//  Created by Decagon on 7/19/21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import UIKit

struct ProfileModel {
    var address = ""
    var phoneNumber = ""
}

extension ProfileModel: RequestParameter {
    
    var asParameter: Parameter {
        return ["address": address, "phoneNumber": phoneNumber]
    }
}

class ProfileViewModel {
    var fullName = ""
    var email = ""
    var photo = ""
    var notificationCompletion: (() -> Void)?
    
    func getProfileDetails() {
        self.fullName = ""
        self.email = ""
        self.photo = ""
        let docId = Auth.auth().currentUser?.uid
        let docRef = Firestore.firestore().collection("/users").document("\(docId!)")
        docRef.getDocument {(document, error) in
            if let document = document, document.exists {
                let docData = document.data()
                if let email = docData!["email"] as? String, let userName = docData!["fullName"] as? String, let userPhoto = docData!["photo"] as? String {
                self.email.append(email)
                    self.fullName.append(userName)
                    self.photo.append(userPhoto)
            }
            }else {
                print( error?.localizedDescription as Any )
            }
            self.notificationCompletion?()
        }
    }
    
    func updateProfile(view: UIViewController,
                       _ image: String) {
        
        let docId = Auth.auth().currentUser?.uid
        Firestore.firestore().collection("users").document(docId!).setData(
            ["photo": image]) { (error) in
            if error != nil {
                AlertController.showAlert(view,
                                          title: "Error",
                                          message: "There was an error saving your profile picture. Please try again.")
            } else {
                AlertController.showAlert(view, title: "Done", message: "Profile picture update successful!")
                
            }
        }
    }
    
}

