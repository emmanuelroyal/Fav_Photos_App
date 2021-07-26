//
//  SearchViewModel.swift
//  Fav_Photos
//
//  Created by Decagon on 7/21/21.
//

import Foundation

class SearchViewModel {
    
    var filteredData = [SearchModel]()
    var datas = [SearchModel]()
    var completion: (()-> Void)?
    var notifyCompletion: (() -> Void)?
    
    func delete(index: Int) {
        completion?()
    }
    func get() {
        self.datas.removeAll()
        let getImages = HomeImagesService()
        getImages.getImages {(result) in
            switch result {
            case .failure(let error):
                debugPrint(error)
            case .success(let result):
                result?.documents.forEach({ (doc) in
                    let data = doc.data()
                    if let image = data["imageUrl"] as? String, let date = data["date"] as? String{
                        let image = SearchModel(name: "Memory", image: image, date: date)
                        self.datas.append(image)
                    }
                })
                self.notifyCompletion?()
                self.filteredData = self.datas
            }
        }
    }
    func filterBySearchtext(searchText: String) {
        filteredData = []
        if searchText == "" {
            filteredData = datas
        }
        
        for imageSearched in datas {
            let searchByDate = imageSearched.date.lowercased()
            let searchByName = imageSearched.name.lowercased()
            if searchByName.contains(searchText.lowercased()) || searchByDate.contains(searchText.lowercased()) {
                filteredData.append(imageSearched)
            }
        }
        self.notifyCompletion?()
    }
    
}
