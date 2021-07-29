//
//  NewPasswordViewController.swift
//  Fav_Photos
//
//  Created by Decagon on 7/19/21.
//

import UIKit
import FirebaseAuth

class NewPasswordViewController: UIViewController {
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
       
    }
    
    @IBAction func updatePasswordPressed(_ sender: Any) {
        if newPasswordTextField.text == confirmPasswordTextField.text {
            Auth.auth().currentUser?.updatePassword(to: confirmPasswordTextField.text!) { error in
                if error != nil {
                    debugPrint(error?.localizedDescription as Any)
                }
            AlertController.showAlert(self, title: "Success", message: "Password changed")
    }
        }
        else {
            AlertController.showAlert(self, title: "Error", message: "Both passwords do not match try again")
        }
        navigationController?.popViewController(animated: true)
}
    
    @IBAction func backPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
}
