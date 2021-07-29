//
//  RecoverPasswordViewController.swift
//  Fav_Photos
//
//  Created by Decagon on 7/19/21.
//

import UIKit
import FirebaseAuth

class RecoverPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        
    }
    
    @IBAction func recoverPressed(_ sender: Any) {
        if emailTextField.text != nil {
        Auth.auth().sendPasswordReset(withEmail: emailTextField.text!) { error in
            if error != nil {
                debugPrint(error?.localizedDescription as Any)
               
            }
        }
    }
        navigationController?.popViewController(animated: true)
    
}
    
    @IBAction func backPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
