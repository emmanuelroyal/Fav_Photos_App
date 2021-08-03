//
//  ProfileViewController.swift
//  Fav_Photos
//
//  Created by Decagon on 7/21/21.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import Kingfisher
import FirebaseAuth


class ProfileViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var uploadedImageNumber: UILabel!
    @IBOutlet weak var downLoadedImage: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let viewModel = ProfileViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        viewModel.getProfileDetails()
        activityIndicator.isHidden = false
        
        
        viewModel.notificationCompletion = { [weak self] in
            DispatchQueue.main.async {
                self?.image.kf.setImage(with: self?.viewModel.photo.asUrl)
                self?.email.text = self?.viewModel.email
                self?.name.text = self?.viewModel.fullName
                self?.activityIndicator.isHidden = true
            }
            
        }
      
    }
    
    @IBAction func adminPressed(_ sender: Any) {
        
    }
    
    @IBAction func changeTapped(_ sender: Any) {
        showChooseSourceTypeAlertController()
    }

    
    @IBAction func LogOutPressed(_ sender: Any) {
        HUD.show(status: "Logging out...")
        do {
            try Auth.auth().signOut()
        } catch {
            self.showAlert(alertText: "Error",
                           alertMessage: "There was an error logging you out. Please try again.")
        }
        HUD.hide()
        guard let newViewController = storyboard?.instantiateViewController(identifier: "LoginStoryBoard") as? LoginViewController   else {
            return
        }
        navigationController?.pushViewController(newViewController, animated: true)
        
    }
}
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func showChooseSourceTypeAlertController() {
        let photoLibraryAction = UIAlertAction(title: "Choose a Photo", style: .default) { (action) in
            self.showImagePickerController(sourceType: .photoLibrary)
        }
        let cameraAction = UIAlertAction(title: "Take a New Photo", style: .default) { (action) in
            self.showImagePickerController(sourceType: .camera)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        AlertService.showAlert(self, style: .actionSheet, title: nil, message: nil, actions: [photoLibraryAction, cameraAction, cancelAction], completion: nil)
    }
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        HUD.show(status: "Updating Profile Picture")
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.image.image = editedImage.withRenderingMode(.alwaysOriginal)
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.image.image = originalImage.withRenderingMode(.alwaysOriginal)
        }
        guard let image = image.image,
            let data = image.jpegData(compressionQuality: 1.0) else {
            HUD.hide()
         AlertController.showAlert(self, title: "Error", message: "Something went wrong")
            return
        }
        let imageName = UUID().uuidString
        
        let imageReference = Storage.storage().reference()
            .child(MyKeys.imagesFolder)
            .child(imageName)
        
        imageReference.putData(data, metadata: nil) { (metadata, err) in
            if let err = err {
                HUD.hide()
                AlertController.showAlert(self, title: "Error", message: err.localizedDescription)
                return
            }
            
            imageReference.downloadURL(completion: { (url, err) in
                if let err = err {
                    HUD.hide()
                    AlertController.showAlert(self, title: "Error", message: err.localizedDescription)
                    return
                }
                
                guard let url = url else {
                    HUD.hide()
                 AlertController.showAlert(self, title: "Error", message: "Something went wrong")
                    return
                }
                HUD.hide()
             self.viewModel.updateProfile(view: self, url.absoluteString)
               
                })
        }
        
        dismiss(animated: true, completion: nil)
    }
}

