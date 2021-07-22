//
//  SearchViewModel.swift
//  Fav_Photos
//
//  Created by Decagon on 7/21/21.
//

import Foundation
class SearchModel {
        var name, date, image: String
        
        init(name: String, image: String, date: String) {
            self.name = name
            self.image = image
            self.date = date
        }
    }

    extension SearchModel: Hashable {
        static func == (lhs: SearchModel, rhs: SearchModel) -> Bool {
            return lhs.image == rhs.image
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(image)
        }
    }


