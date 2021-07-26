//
//  SignUpViewController.swift
//  Fav_Photos
//
//  Created by Decagon on 7/19/21.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import GoogleSignIn
import FBSDKLoginKit

class SignUpViewController: UIViewController {
    

    @IBOutlet weak var FullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var SecureButton: UIButton!
    @IBOutlet weak var fbSignIn: FBLoginButton!
    
    var viewModel = SignupViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        fbSignIn.delegate = self
        setNavBar()
        if let token = AccessToken.current,
           !token.isExpired {
        }
        else { fbSignIn.permissions = ["public_profile", "email"]
        }
    }
    
    
    @IBAction func eyeIconPressed(_ sender: Any) {
        viewModel.toggle(passField: passwordTextField, secureButton: SecureButton)
    }
    
    @IBAction func SignUpPressed(_ sender: Any) {
        viewModel.validateTextField(inView: self, fullName: FullNameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!)
        
        if emailTextField.text?.isEmpty == false && FullNameTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false {
            HUD.show(status: "Signing you in")
            if let email = emailTextField.text, let password = passwordTextField.text, let fullName = FullNameTextField.text {
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let error = error, authResult != nil {
                        print(error.localizedDescription)
                        HUD.hide()
                    } else {
                        let docId = Auth.auth().currentUser?.uid
                        Firestore.firestore().collection("users").document(docId!).setData(
                            ["email": email, "fullName": fullName, "photo": "" ]) { (error) in
                            if error != nil {
                                HUD.hide()
                                self.showAlert(alertText: "Error",
                                               alertMessage: "There was an error creating account, please try again.")
                            } else {
                                HUD.hide()
                                let alertController =
                                    UIAlertController(title: "Done",
                                                      message: "Account created successfully!", preferredStyle: .alert)
                                let acceptAction = UIAlertAction(title: "Accept", style: .default) { (_) -> Void in
                                    self.navigateToHome()
                                }
                                alertController.addAction(acceptAction)
                                self.present(alertController, animated: true, completion: nil)
                                
                            }
                        }
                    }
                }
            }
        }
        else {
            return
        }
    }
    
    
    @IBAction func googleIconPressed(_ sender: Any) {
        googleSignIn(inView: self)
    }
    
    @IBAction func facebookIconPressed(_ sender: Any) {
        
    }
    
    @IBAction func skipPressed(_ sender: Any) {
        navigateToWelcome()
    }
}
    extension SignUpViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        Fav_Photos.fbSignIn(inView: self)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
}
