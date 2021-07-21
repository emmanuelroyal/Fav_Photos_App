//
//  LoginViewController.swift
//  Fav_Photos
//
//  Created by Decagon on 7/19/21.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController, LoginButtonDelegate {
    
    
    @IBOutlet weak var fbSignIn: FBLoginButton!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var SecureButton: UIButton!
    var viewModel = LoginViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        fbSignIn.delegate = self
        if let token = AccessToken.current,
           !token.isExpired {
        }
        else { fbSignIn.permissions = ["public_profile", "email"]
        }
    }
    
    @IBAction func SignInPressed(_ sender: Any) {
        
        if let email = emailTextfield.text, let pass = PasswordTextField.text {
            
            if email.isEmpty == true ||  pass.isEmpty == true {
                self.showAlert(alertText: "Incomplete details", alertMessage: "Please, enter your email and password.")
            }
            else {
                HUD.show(status: "Welcome Back")
                viewModel.loginUser(with: email, password: pass) { [weak self] success in
                    HUD.hide()
                    success ? self?.navigateToHome() : self?
                        .showAlert(alertText: "OOPS...Incorrect Details",
                                   alertMessage: "Incorrect email or password. Please check your details and try again.")
                }
            }
        }
        
    }
    
    @IBAction func forgotPasswordPressed(_ sender: Any) {
        navigateToRecoverPassword()
    }
    
    @IBAction func googleIconPressed(_ sender: Any) {
       googleSignIn(inView: self)
    }

    @IBAction func facebookIconPressed(_ sender: Any) {
        Fav_Photos.fbSignIn(inView: self)
    }
    
    @IBAction func skipPressed(_ sender: Any) {
        navigateToWelcome()
    }
    
    @IBAction func eyeIconPressed(_ sender: Any) {
        viewModel.toggle(passField: PasswordTextField, secureButton: SecureButton)
    }
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        Fav_Photos.fbSignIn(inView: self)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
    
}
