//
//  NewPasswordViewController.swift
//  Fav_Photos
//
//  Created by Decagon on 7/19/21.
//

import UIKit

class NewPasswordViewController: UIViewController {
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
       
    }
    
    @IBAction func updatePasswordPressed(_ sender: Any) {
    }
    
   

}
