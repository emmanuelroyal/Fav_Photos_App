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
var data = [HomeModel(name: "PAUL", image: "https://picscelb.files.wordpress.com/2012/05/miley-cyrus-in-tight-jeans-at-her-boyfriends-house-in-los-angeles-pictures-photoshoot-2012-miley-cyrus-pics-imaes-8.jpg?w=550", date: "SAUL"), HomeModel(name: "hihhik", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTil0cC9-LbGf1HXlNow3q6s4ZnVt_qT5CGQ&usqp=CAU", date: "piihib"), HomeModel(name: "jhjbkb", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQnHnJ75_WfmUzDtfL5uX2QMsmnZlNcjmhYQ&usqp=CAU", date: "hkjbbj"), HomeModel(name: "PAUL", image: "https://picscelb.files.wordpress.com/2012/05/miley-cyrus-in-tight-jeans-at-her-boyfriends-house-in-los-angeles-pictures-photoshoot-2012-miley-cyrus-pics-imaes-8.jpg?w=550", date: "SAUL"), HomeModel(name: "hihhik", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTil0cC9-LbGf1HXlNow3q6s4ZnVt_qT5CGQ&usqp=CAU", date: "piihib"), HomeModel(name: "jhjbkb", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQnHnJ75_WfmUzDtfL5uX2QMsmnZlNcjmhYQ&usqp=CAU", date: "hkjbbj"), HomeModel(name: "PAUL", image: "https://picscelb.files.wordpress.com/2012/05/miley-cyrus-in-tight-jeans-at-her-boyfriends-house-in-los-angeles-pictures-photoshoot-2012-miley-cyrus-pics-imaes-8.jpg?w=550", date: "SAUL"), HomeModel(name: "hihhik", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTil0cC9-LbGf1HXlNow3q6s4ZnVt_qT5CGQ&usqp=CAU", date: "piihib"), HomeModel(name: "jhjbkb", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQnHnJ75_WfmUzDtfL5uX2QMsmnZlNcjmhYQ&usqp=CAU", date: "hkjbbj")]
    
    var photo = ""
    var firstWord = ""
    var greetings = ""
    var usernameHandler: (() -> Void)?
    
    init() {
        greetings = gettime()
    }
    
    
    
    
    var completion: (()-> Void)?
    
    func delete(index: Int) {
        completion?()
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
    
}
