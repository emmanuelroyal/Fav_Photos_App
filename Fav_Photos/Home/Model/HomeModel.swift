//
//  HomeModel.swift
//  Fav_Photos
//
//  Created by Decagon on 7/21/21.
//

import Foundation
class HomeModel {
        var name, date, image: String
        
        init(name: String, image: String, date: String) {
            self.name = name
            self.image = image
            self.date = date
        }
    }

    extension HomeModel: Hashable {
        static func == (lhs: HomeModel, rhs: HomeModel) -> Bool {
            return lhs.image == rhs.image
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(image)
        }
    }


