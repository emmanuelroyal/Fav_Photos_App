//
//  HomeImagesApi.swift
//  Fav_Photos
//
//  Created by Decagon on 7/23/21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

enum HomeImagesApi {
    case getImages
    case delete(type: String)
}

extension HomeImagesApi: FirestoreRequest {
    
    var collectionReference: CollectionReference? {
        switch self {
        case .getImages:
            guard let userID = Auth.auth().currentUser?.uid else { return nil }
            return Firestore.firestore().collection(Collection.users.identifier).document("\(userID)").collection(Collection.userPhotos.identifier)
        case .delete:
            guard let userID = Auth.auth().currentUser?.uid else { return nil }
            return Firestore.firestore().collection(Collection.users.identifier).document("\(userID)").collection(Collection.userPhotos.identifier)
        }
    }
    
    var baseCollectionReference: DocumentReference? {
        return Firestore.firestore().collection(Collection.userProfile.identifier).document()
    }
    
    var tasks: Tasks {
        switch self {
        case .getImages:
            return .read
        case .delete(let type):
            return .delete(type: type)
        }
    }
    var documentReference: DocumentReference? {
        switch self {
        case .getImages:
            return baseCollectionReference
        case .delete(let type):
            guard let userID = Auth.auth().currentUser?.uid else { return nil }
            return Firestore.firestore().collection(Collection.users.identifier).document("\(userID)").collection(Collection.userPhotos.identifier).document(type)
        }
    }
    var collectionReferences: Query? {
        return Firestore.firestore().collection(Collection.userProfile.identifier).whereField("capital", isEqualTo: true)
    }
}

