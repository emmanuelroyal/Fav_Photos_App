//
//  HomeImagesService.swift
//  Fav_Photos
//
//  Created by Decagon on 7/23/21.
//

import Foundation
struct HomeImagesService {
    let router = Router<HomeImagesApi>()
    
    func getImages(completion: @escaping NetworkRouterCompletion) {
        router.request(.getImages, completion: completion)
    }
}
