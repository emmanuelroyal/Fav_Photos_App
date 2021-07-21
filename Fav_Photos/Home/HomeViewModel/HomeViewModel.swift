//
//  HomeViewModel.swift
//  Fav_Photos
//
//  Created by Decagon on 7/21/21.
//

import Foundation
class CollectionViewModel {
var data = [HomeModel]()
    
    
    
    var completion: (()-> Void)?
    
    func delete(index: Int) {
        completion?()
    }
}
