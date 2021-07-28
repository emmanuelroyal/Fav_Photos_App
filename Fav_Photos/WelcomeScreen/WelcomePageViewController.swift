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
    
    @IBOutlet weak var signIN: UIButton!
    @IBOutlet weak var socialLogins: UIStackView!
    @IBOutlet weak var fbSignIn: FBLoginButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var signUp: UIButton!
    @IBOutlet weak var smallLabel: UILabel!
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.signIN.center.y += 5
        self.signUp.center.y += 5
        self.socialLogins.center.y += 5
        self.welcomeLabel.center.x -= 10
        self.smallLabel.center.x -= 10
        signIN.alpha = 0.2
        signUp.alpha = 0.2
        socialLogins.alpha = 0.0
        self.signIN.backgroundColor = .systemOrange
        self.signUp.backgroundColor = .systemOrange
    }

    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1.0 , delay: 0.5,
        usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [],
        animations: { [self] in
            self.welcomeLabel.center.x += 10
            self.smallLabel.center.x += 10
          self.signIN.center.y -= 5.0
          self.signIN.alpha = 1.0
            self.signUp.center.y -= 5.0
            self.signUp.alpha = 1.0
            self.socialLogins.center.y -= 5.0
            self.socialLogins.alpha = 1.0
            self.signIN.backgroundColor = .systemIndigo
            self.signUp.backgroundColor = .systemIndigo
        },
        completion: nil)
    }
    
    @IBAction func signInClicked(_ sender: Any) {
    
        guard let newViewController = storyboard?.instantiateViewController(identifier: "LoginStoryBoard") as? LoginViewController   else {
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
