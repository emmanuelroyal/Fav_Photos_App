//
//  OnboardingCollectionViewCell.swift
//  Fav_Photos
//
//  Created by Decagon on 7/18/21.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "OnboardingCollectionViewCell"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    func setUp(_ slide: OnboardingSlide){
        imageView.image = slide.image
        titleLbl.text = slide.title
        descLbl.text = slide.description
    }
    
}
