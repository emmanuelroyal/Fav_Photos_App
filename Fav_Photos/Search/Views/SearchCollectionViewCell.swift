//
//  SearchCollectionViewCell.swift
//  Fav_Photos
//
//  Created by Decagon on 7/21/21.
//


import UIKit
import Kingfisher

class SearchCollectionViewCell: UICollectionViewCell {
        static let identifier = "CollectionViewCell"
        weak var delegate: collectionViewCellDelegate?

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
    
    
    func setup(with Model: SearchModel) {
        self.image.kf.setImage(with: Model.image.asUrl)
        self.name.text = Model.name
        self.time.text = Model.date
    }
    
}
    
    
    
    
    
    

