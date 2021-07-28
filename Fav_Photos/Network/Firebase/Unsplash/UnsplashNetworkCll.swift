//
//  UnsplashNetworkCll.swift
//  Fav_Photos
//
//  Created by Decagon on 7/27/21.
//

import Foundation
import Alamofire

class AlamofireReq {

    var networkData: [result] = []
    var itemNames = [String]()
    var completion: (() -> Void)?
    var currentPage = 0
    
    func getMethod(search : String) {
        HUD.show(status: "Searching")
        self.networkData.removeAll()
        let string = "https://api.unsplash.com/search/photos?page=1&per_page=50&query=\(search)&client_id=-c2wC5MRt2BzMJkz14Po3DbZqpenaqO4R2-BuRxlTww"
        AF.request(string, parameters: nil, headers: nil ).validate(statusCode: 200 ..< 299).responseJSON { AFdata  in
            let datas =  AFdata.data
            if let data = datas {
                var imageJson: UnsplashApiResponseModel?
                do {
                    imageJson = try JSONDecoder().decode(UnsplashApiResponseModel.self, from: data)
                } catch {
                    debugPrint(error)
                }
                guard let images = imageJson else { return }
                self.networkData.append(contentsOf: images.results)
                HUD.hide()
                self.completion?()
            }
        }
    }
    
    
    
    
    
}
