//
//  UnsplashModel.swift
//  Fav_Photos
//
//  Created by Decagon on 7/27/21.
//

import Foundation
struct UnsplashApiResponseModel: Codable {
    let total, total_pages: Int
    let results: [result]
}

struct  result: Codable {
    let id: String
    let urls: URLS
}

struct URLS: Codable {
    let full: String
}

    enum CodingKeys: String, CodingKey {
        case result = "Result"
        case total
        case total_Pages
    }

