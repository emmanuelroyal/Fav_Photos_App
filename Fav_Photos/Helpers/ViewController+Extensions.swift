//
//  ViewController+Extensions.swift
//  Fav_Photos
//
//  Created by Decagon on 7/19/21.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import GoogleSignIn
import FBSDKLoginKit
import FirebaseCore

extension UIViewController {
    
    func showAlert (alertText: String, alertMessage: String) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func setNavBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationItem.backButtonTitle = " "
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = .systemBlue
    }
    
    
    func navigateToHome() {
    guard let newViewController = storyboard?.instantiateViewController(identifier: "TabBar") as?  UITabBarController   else {
        return
    }
    navigationController?.pushViewController(newViewController, animated: true)
}
    func navigateToWelcome() {
    guard let newViewController = storyboard?.instantiateViewController(identifier: "WelcomePageStoryBoard") as? WelcomePageViewController   else {
        return
    }
    navigationController?.pushViewController(newViewController, animated: true)
}
    func navigateToRecoverPassword() {
    guard let newViewController = storyboard?.instantiateViewController(identifier: "RecoverPasswordStoryBoard") as?  RecoverPasswordViewController   else {
    return
}
navigationController?.pushViewController(newViewController, animated: true)
}

    
}

class AlertController {
    static func showAlert(_ inViewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        inViewController.present(alert, animated: true, completion: nil)
    }
}
class AlertService {
    static func showAlert(_ inViewController: UIViewController, style: UIAlertController.Style, title: String?, message: String?, actions: [UIAlertAction] = [UIAlertAction(title: "Ok", style: .cancel, handler: nil)], completion: (() -> Swift.Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for action in actions {
            alert.addAction(action)
        }
        inViewController.present(alert, animated: true, completion: nil)
    }
    
}

func googleSignIn(inView: UIViewController) {
    guard let clientID = FirebaseApp.app()?.options.clientID else { return }
    let config = GIDConfiguration(clientID: clientID)
    GIDSignIn.sharedInstance.signIn(with: config, presenting: inView) { [weak inView] user, error in
        if let error = error {
            debugPrint(error)
            return
        }
        guard
            let authentication = user?.authentication,
            let idToken = authentication.idToken,
            let email = user?.profile?.email,
            let fullname = user?.profile?.name,
            let image = user?.profile?.imageURL(withDimension: UInt(round(100 * UIScreen.main.scale)))
        else {
            return
        }
        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { authResult, error in
            HUD.show(status: "Signing you In")
            if let error = error {
                let authError = error as NSError
                if authError.code == AuthErrorCode.secondFactorRequired.rawValue {
                    let resolver = authError
                        .userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
                    var displayNameString = ""
                    for tmpFactorInfo in resolver.hints {
                        displayNameString += tmpFactorInfo.displayName ?? ""
                        displayNameString += " "
                    }
                    let alertController =
                        UIAlertController(title: "Type Email",
                                          message: "Select factor to sign in\n\(displayNameString)", preferredStyle: .alert)
                    alertController.addTextField { (textField) in
                        textField.placeholder = "Email"
                        var selectedHint: PhoneMultiFactorInfo?
                        for tmpFactorInfo in resolver.hints {
                            if textField.text == tmpFactorInfo.displayName {
                                selectedHint = tmpFactorInfo as? PhoneMultiFactorInfo
                            }
                            PhoneAuthProvider.provider()
                                .verifyPhoneNumber(with: selectedHint!, uiDelegate: nil,
                                                   multiFactorSession: resolver
                                                    .session) { verificationID, error in
                                    if error != nil {
                                        print(
                                            "Multi factor start sign in failed. Error: \(error.debugDescription)"
                                        )
                                        inView!.present(alertController, animated: true, completion: nil)
                                    } else {
                                        let alertController =
                                            UIAlertController(title: "Type Email",
                                                              message: "Verification code for \(selectedHint?.displayName ?? "")", preferredStyle: .alert)
                                        alertController.addTextField { (textField) in
                                            textField.placeholder = "Verification code"
                                            let credential: PhoneAuthCredential? = PhoneAuthProvider.provider()
                                                .credential(withVerificationID: verificationID!,
                                                            verificationCode: textField.text!)
                                            let assertion: MultiFactorAssertion? = PhoneMultiFactorGenerator
                                                .assertion(with: credential!)
                                            resolver.resolveSignIn(with: assertion!) { authResult, error in
                                                if error != nil {
                                                    print(
                                                        "Multi factor finanlize sign in failed. Error: \(error.debugDescription)"
                                                    )
                                                    inView!.present(alertController, animated: true, completion: nil)
                                                } else {
                                                    let alertController =
                                                        UIAlertController(title: "Type Email",
                                                                          message: "\(error!.localizedDescription)", preferredStyle: .alert)
                                                    inView!.present(alertController, animated: true, completion: nil)
                                                    return
                                                }
                                            }
                                        }
                                    }
                                }
                        }
                    }
                }
            }
            let docId = Auth.auth().currentUser?.uid
            Firestore.firestore().collection("users").document(docId!).setData(
                ["email": email, "fullName": fullname, "photo": image.absoluteString]) { (error) in
                if error != nil {
                    HUD.hide()
                    inView!.showAlert(alertText: "Error",
                                      alertMessage: "There was an error creating account, please try again.")
                } else {
                    HUD.hide()
                    let alertController =
                        UIAlertController(title: "Done",
                                          message: "Sign in successful!", preferredStyle: .alert)
                    let acceptAction = UIAlertAction(title: "Accept", style: .default) { (_) -> Void in
                        inView!.navigateToHome()
                    }
                    alertController.addAction(acceptAction)
                    inView!.present(alertController, animated: true, completion: nil)
                    
                }
            }
        }
    }
}
func fbSignIn (inView: UIViewController) {
    guard let token = AccessToken.current?.tokenString else { return }
let credential = FacebookAuthProvider
    .credential(withAccessToken: token)

Auth.auth().signIn(with: credential) { authResult, error in
    if let error = error {
        let authError = error as NSError
        if authError.code == AuthErrorCode.secondFactorRequired.rawValue {
            let resolver = authError
                .userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
            var displayNameString = ""
            for tmpFactorInfo in resolver.hints {
                displayNameString += tmpFactorInfo.displayName ?? ""
                displayNameString += " "
            }
            let alertController =
                UIAlertController(title: "Type Email",
                                  message: "Select factor to sign in\n\(displayNameString)", preferredStyle: .alert)
            alertController.addTextField { (textField) in
                textField.placeholder = "Email"
                var selectedHint: PhoneMultiFactorInfo?
                for tmpFactorInfo in resolver.hints {
                    if textField.text == tmpFactorInfo.displayName {
                        selectedHint = tmpFactorInfo as? PhoneMultiFactorInfo
                    }
                    PhoneAuthProvider.provider()
                        .verifyPhoneNumber(with: selectedHint!, uiDelegate: nil,
                                           multiFactorSession: resolver
                                            .session) { verificationID, error in
                            if error != nil {
                                print(
                                    "Multi factor start sign in failed. Error: \(error.debugDescription)"
                                )
                                inView.present(alertController, animated: true, completion: nil)
                            } else {
                                let alertController =
                                    UIAlertController(title: "Type Email",
                                                      message: "Verification code for \(selectedHint?.displayName ?? "")", preferredStyle: .alert)
                                alertController.addTextField { (textField) in
                                    textField.placeholder = "Verification code"
                                    let credential: PhoneAuthCredential? = PhoneAuthProvider.provider()
                                        .credential(withVerificationID: verificationID!,
                                                    verificationCode: textField.text!)
                                    let assertion: MultiFactorAssertion? = PhoneMultiFactorGenerator
                                        .assertion(with: credential!)
                                    resolver.resolveSignIn(with: assertion!) { authResult, error in
                                        if error != nil {
                                            print(
                                                "Multi factor finanlize sign in failed. Error: \(error.debugDescription)"
                                            )
                                            inView.present(alertController, animated: true, completion: nil)
                                        } else {
                                            let alertController =
                                                UIAlertController(title: "Type Email",
                                                                  message: "\(error!.localizedDescription)", preferredStyle: .alert)
                                            inView.present(alertController, animated: true, completion: nil)
                                            return
                                        }
                                    }
                                }
                            }
                        }
                }
            }
        }
    }
    let info = authResult?.user
    let email = info?.email
    let fullname = info?.displayName
    let image = info?.photoURL
    
    HUD.show(status: "Signing you In")
    let docId = Auth.auth().currentUser?.uid
    Firestore.firestore().collection("users").document(docId!).setData(
        ["email": email as Any, "fullName": fullname as Any, "photo": image?.absoluteString as Any ]) { (error) in
        if error != nil {
            HUD.hide()
            inView.showAlert(alertText: "Error",
                           alertMessage: "There was an error creating account, please try again.")
        } else {
            HUD.hide()
            let alertController =
                UIAlertController(title: "Done",
                                  message: "Sign in successful!", preferredStyle: .alert)
            let acceptAction = UIAlertAction(title: "Accept", style: .default) { (_) -> Void in
                inView.navigateToHome()
            }
            alertController.addAction(acceptAction)
            inView.present(alertController, animated: true, completion: nil)
            
        }
    }
}

}


