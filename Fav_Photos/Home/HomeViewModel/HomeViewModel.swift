//
//  HomeViewModel.swift
//  Fav_Photos
//
//  Created by Decagon on 7/21/21.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class CollectionViewModel {
    var data = [HomeModel]()
    
    var photo = ""
    var firstWord = ""
    var greetings = ""
    var usernameHandler: (() -> Void)?
    var notifyCompletion: (() -> Void)?
    
    init() {
        greetings = gettime()
    }
    
    var completion: (()-> Void)?
    
    func delete(index: Int) {
        let selected = data[index].imageId
        let delete = HomeImagesService()
        delete.deleteImage(type: selected) {(result) in
            print(selected)
            switch result {
            case .failure(let error):
                debugPrint(error)
            case .success(_):
                debugPrint("deleted")
            }
            self.completion?()
        }
        
    }
    
    
    func getUserName() {
        let docId = Auth.auth().currentUser?.uid
        let docRef = Firestore.firestore().collection("/users").document("\(docId!)")
        docRef.getDocument {(document, error) in
            if let document = document, document.exists {
                let docData = document.data()
                let status = docData!["fullName"] as? String ?? ""
                let firstWord = status.components(separatedBy: " ").first
                self.greetings = "A Beautiful \(self.gettime()) to You \(firstWord!)"
                self.usernameHandler?()
            } else {
                debugPrint(error as Any)
            }
        }
    }
    
    func getUserPhoto() {
        let docId = Auth.auth().currentUser?.uid
        let docRef = Firestore.firestore().collection("/users").document("\(docId!)")
        docRef.getDocument {(document, error) in
            if let document = document, document.exists {
                let docData = document.data()
                let status = docData!["photo"] as? String ?? ""
                self.photo = status
                self.usernameHandler?()
            } else {
                debugPrint(error as Any)
            }
        }
    }
    
    
    
    
    func gettime() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 1..<12 :
            return(NSLocalizedString(" Morning", comment: "Morning"))
        case 12..<17 :
            return (NSLocalizedString("Afternoon", comment: "Afternoon"))
        default:
            return (NSLocalizedString("Evening", comment: "Evening"))
        }
    }
    
    
    
    func get() {
        self.data.removeAll()
        let getImages = HomeImagesService()
        getImages.getImages {(result) in
            switch result {
            case .failure(let error):
                debugPrint(error)
            case .success(let result):
                result?.documents.forEach({ (doc) in
                    let data = doc.data()
                    if let image = data["imageUrl"] as? String, let date = data["date"] as? String {
                        let image = HomeModel(name: "Memory \(self.data.count + 1)", image: image, date: date, imageId: doc.documentID)
                        self.data.append(image)
                    }
                })
                self.notifyCompletion?()
            }
        }
    }
}
