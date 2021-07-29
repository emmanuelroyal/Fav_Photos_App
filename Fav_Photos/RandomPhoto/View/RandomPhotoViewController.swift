//
//  RandomPhotoViewController.swift
//  Fav_Photos
//
//  Created by Decagon on 7/21/21.
//

import UIKit
import Kingfisher

class RandomPhotoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var Search: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var prompt: UILabel!
    
    
    var searchText = ""
    
    let viewModelss = AlamofireReq()
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        collectionView.dataSource = self
        setNavBar()
        Search.delegate = self
        viewModelss.completion = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                if self.viewModelss.networkData.isEmpty == true {
                self.prompt.isHidden = false
                self.Search.prompt = "there were no images with that search word"
                    self.prompt.text = "Oops"
                }
                else {
                    self.prompt.isHidden = true
                    self.Search.prompt = "swipe left to see more images"
                }
                
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModelss.networkData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: RandomCollectionViewCell.identifier, for: indexPath) as?
                RandomCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.image.kf.setImage(with: viewModelss.networkData[indexPath.row].urls.full.asUrl)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
}

extension RandomPhotoViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = ""
        self.searchText = searchText
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if searchText != "" {
            let search = searchText.filter {!$0.isWhitespace}
            viewModelss.getMethod(search: search)
        }
    }
}


