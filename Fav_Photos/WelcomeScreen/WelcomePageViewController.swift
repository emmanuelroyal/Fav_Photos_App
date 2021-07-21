//
//  WelcomePageViewController.swift
//  Fav_Photos
//
//  Created by Decagon on 7/19/21.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

class WelcomePageViewController: UIViewController, LoginButtonDelegate {
    
    @IBOutlet weak var fbSignIn: FBLoginButton!
    
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
    
    @IBAction func signInClicked(_ sender: Any) {
    
        guard let newViewController = storyboard?.instantiateViewController(identifier: "Login") as? LoginViewController   else {
            return
        }
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        guard let newViewController = storyboard?.instantiateViewController(identifier: "SignUpStoryBoard") as? SignUpViewController   else {
            return
        }
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @IBAction func googleIconPressed(_ sender: Any) {
        googleSignIn(inView: self)
    }
    
    @IBAction func facebookIconPressed(_ sender: Any) {
    
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        Fav_Photos.fbSignIn(inView: self)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
}
