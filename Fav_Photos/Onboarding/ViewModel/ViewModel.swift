//
//  ViewModel.swift
//  Fav_Photos
//
//  Created by Decagon on 7/18/21.
//

import UIKit

class OnboardingViewModel {
    var slides: [OnboardingSlide] = []
    var updateButton: ((String, Int, String) -> Void)?
    var currentPage = 0 {
        didSet {
            if currentPage == slides.count - 1 {
                updateButton?("Get Started ", currentPage, "")
            } else {
                updateButton?(" Next ", currentPage, "Skip")
            }
        }
    }
    
    init() {
        slides = [
            OnboardingSlide(title: "Save Great Memories", description: "Memories saved in digital pictures can last forever and remain a reminder of events of the past.", image: #imageLiteral(resourceName: "photo-1529156069898-49953e39b3ac")), OnboardingSlide(title: "Enjoy You Holidays", description: "Taking and saving group pictures are a sure way of increasing the holiday fun.", image: #imageLiteral(resourceName: "94106618-beautiful-couple-taking-photos-with-camera-on-street-happy-smiling-people-taking-selfie-photo-outdoo")), OnboardingSlide(title: "Free Cloud Backup", description: "Enjoy unlimited free cloud backup for all your memories in photos, memes and screenshots..", image: #imageLiteral(resourceName: "photographer-battleface"))
        ]
    }

}
