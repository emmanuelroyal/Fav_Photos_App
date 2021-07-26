//
//  Collection.swift
//  Fav_Photos
//
//  Created by Decagon on 7/19/21.
//

import Foundation

enum Collection {
    case users
    case userProfile
    case userPhotos
    
    var identifier: String {
        switch self {
        case .users :
            return "users"
        case .userProfile:
            return "user_profile"
        case .userPhotos:
            return "UserPhotos"
        }
    }
}
