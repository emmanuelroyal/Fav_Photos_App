//
//  Tasks.swift
//  Fav_Photos
//
//  Created by Decagon on 7/19/21.
//

import Foundation

enum Tasks {
    case read
    case qread(type: String )
    case delete(type: String)
    case create(documentData: Parameter)
    case update(documentData: Parameter)
}
