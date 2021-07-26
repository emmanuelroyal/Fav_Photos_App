//
//  AddPhotosViewController.swift
//  Fav_Photos
//
//  Created by Decagon on 7/21/21.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

import Kingfisher

class AddPhotosViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var viewModel = AddPhotosViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true

        
    }
    

    @IBAction func CameraBtnTapped(_ sender: Any) {
        showImagePickerController(sourceType: .camera)
    }
    
    @IBAction func PhotoLibraryBtnTapped(_ sender: Any) {
        showImagePickerController(sourceType: .photoLibrary)
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.image.image = UIImage(systemName: "photo.on.rectangle")
    }
    
    @IBAction func uploadTapped(_ sender: Any) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
               
               guard let image = image.image,
                   let data = image.jpegData(compressionQuality: 1.0) else {
                   presentAlert(title: "Error", message: "Something went wrong")
                   return
               }
               
               let imageName = UUID().uuidString
               
               let imageReference = Storage.storage().reference()
                   .child(MyKeys.imagesFolder)
                   .child(imageName)
               
               imageReference.putData(data, metadata: nil) { (metadata, err) in
                   if let err = err {
                       self.presentAlert(title: "Error", message: err.localizedDescription)
                       return
                   }
                   
                   imageReference.downloadURL(completion: { (url, err) in
                       if let err = err {
                           self.presentAlert(title: "Error", message: err.localizedDescription)
                           return
                       }
                       
                       guard let url = url else {
                           self.presentAlert(title: "Error", message: "Something went wrong")
                           return
                       }
                    let docId = Auth.auth().currentUser?.uid
                    let dataReference = Firestore.firestore().collection("/users").document("\(docId!)").collection("UserPhotos").document()
                       let documentUid = dataReference.documentID
                       
                       let urlString = url.absoluteString
                       
                       let data = [
                           MyKeys.uid: documentUid,
                           MyKeys.imageUrl: urlString,
                           MyKeys.date: self.viewModel.getCurrentTime()
                       ]
                       
                       dataReference.setData(data, completion: { (err) in
                           if let err = err {
                               self.presentAlert(title: "Error", message: err.localizedDescription)
                               return
                           }
                           
                           UserDefaults.standard.set(documentUid, forKey: MyKeys.uid)
                           self.image.image = UIImage()
                           self.presentAlert(title: "Success", message: "Successfully save image to database")
                        self.image.image = UIImage(systemName: "plus")
                        self.image.backgroundColor = .white
                        self.image.tintColor = .systemIndigo
                        self.activityIndicator.isHidden = true
                       })
                       
                   })
               }
           }

        
    }

extension AddPhotosViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.image.image = editedImage.withRenderingMode(.alwaysOriginal)
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.image.image = originalImage.withRenderingMode(.alwaysOriginal)
        }
        dismiss(animated: true, completion: nil)
    }
    func presentAlert(title: String, message: String) {
            activityIndicator.stopAnimating()
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
}
