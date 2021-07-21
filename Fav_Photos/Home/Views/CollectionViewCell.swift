//
//  CollectionViewCell.swift
//  Fav_Photos
//
//  Created by Decagon on 7/21/21.
//

import UIKit
import Kingfisher

    protocol collectionViewCellDelegate: AnyObject {
        func didTapRemoveBtn(with index: Int)
    }

    class CollectionViewCell: UICollectionViewCell {
        static let identifier = "CollectionViewCell"
        weak var delegate: collectionViewCellDelegate?
        
        @IBOutlet weak var PhotoImage: UIImageView!
        @IBOutlet weak var Name: UILabel!
        @IBOutlet weak var Date: UILabel!
        
        
            
        
        func setup(with Model: HomeModel) {
            self.PhotoImage.kf.setImage(with: Model.image.asUrl)
            self.Name.text = Model.name
            self.Date.text = Model.date
        }}
