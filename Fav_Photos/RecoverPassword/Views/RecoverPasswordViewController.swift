//
//  RecoverPasswordViewController.swift
//  Fav_Photos
//
//  Created by Decagon on 7/19/21.
//

import UIKit

class RecoverPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
setNavBar()
        
    }
    
    @IBAction func recoverPressed(_ sender: Any) {
        let newStoryboard = UIStoryboard(name: "LoginStoryBoard", bundle: nil)
        let newController = newStoryboard
            .instantiateViewController(identifier: "LoginStoryBoard") as LoginViewController
        newController.modalTransitionStyle = .crossDissolve
        newController.modalPresentationStyle = .fullScreen
        present(newController, animated: true, completion: nil)
    }
    
    

}
