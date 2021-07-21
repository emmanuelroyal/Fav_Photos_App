//
//  Request.swift
//  Fav_Photos
//
//  Created by Decagon on 7/19/21.
//

import Foundation
import FirebaseFirestore

protocol FirestoreRequest {
    var tasks: Tasks { get }
    var documentReference: DocumentReference? { get }
    var collectionReference: CollectionReference? { get }
    var baseCollectionReference: DocumentReference? { get }
    var collectionReferences: Query? { get }
}
