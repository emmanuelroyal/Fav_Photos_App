//
//  HomeViewModel.swift
//  Fav_Photos
//
//  Created by Decagon on 7/21/21.
//

import Foundation
class CollectionViewModel {
var data = [HomeModel(name: "PAUL", image: "https://picscelb.files.wordpress.com/2012/05/miley-cyrus-in-tight-jeans-at-her-boyfriends-house-in-los-angeles-pictures-photoshoot-2012-miley-cyrus-pics-imaes-8.jpg?w=550", date: "SAUL"), HomeModel(name: "hihhik", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTil0cC9-LbGf1HXlNow3q6s4ZnVt_qT5CGQ&usqp=CAU", date: "piihib"), HomeModel(name: "jhjbkb", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQnHnJ75_WfmUzDtfL5uX2QMsmnZlNcjmhYQ&usqp=CAU", date: "hkjbbj"), HomeModel(name: "PAUL", image: "https://picscelb.files.wordpress.com/2012/05/miley-cyrus-in-tight-jeans-at-her-boyfriends-house-in-los-angeles-pictures-photoshoot-2012-miley-cyrus-pics-imaes-8.jpg?w=550", date: "SAUL"), HomeModel(name: "hihhik", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTil0cC9-LbGf1HXlNow3q6s4ZnVt_qT5CGQ&usqp=CAU", date: "piihib"), HomeModel(name: "jhjbkb", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQnHnJ75_WfmUzDtfL5uX2QMsmnZlNcjmhYQ&usqp=CAU", date: "hkjbbj"), HomeModel(name: "PAUL", image: "https://picscelb.files.wordpress.com/2012/05/miley-cyrus-in-tight-jeans-at-her-boyfriends-house-in-los-angeles-pictures-photoshoot-2012-miley-cyrus-pics-imaes-8.jpg?w=550", date: "SAUL"), HomeModel(name: "hihhik", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTil0cC9-LbGf1HXlNow3q6s4ZnVt_qT5CGQ&usqp=CAU", date: "piihib"), HomeModel(name: "jhjbkb", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQnHnJ75_WfmUzDtfL5uX2QMsmnZlNcjmhYQ&usqp=CAU", date: "hkjbbj")]
    
    
    
    
    
    
    
    var completion: (()-> Void)?
    
    func delete(index: Int) {
        completion?()
    }
}
