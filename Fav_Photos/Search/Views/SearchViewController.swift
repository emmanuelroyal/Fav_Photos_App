//
//  SearchViewController.swift
//  Fav_Photos
//
//  Created by Decagon on 7/21/21.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDataSource {
    
    
    @IBOutlet weak var collection: UICollectionView!
    
    var viewModel = SearchViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewWillAppear(_ animated: Bool) {
            DispatchQueue.main.async {
                self.collection.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =
                        collection.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? SearchCollectionViewCell
                else { return UICollectionViewCell() }
                cell.setup(with: viewModel.datas[indexPath.row])
                cell.delegate = self
                cell.tag = indexPath.row
                return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        viewModel.datas.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell =
//                collection.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? SearchCollectionViewCell
//        else { return UICollectionViewCell() }
//        cell.setup(with: viewModel.datas[indexPath.row])
//        cell.delegate = self
//        cell.tag = indexPath.row
//        return cell
//    }
}
//
extension SearchViewController: collectionViewCellDelegate {
    func didTapRemoveBtn(with index: Int) {
        self.viewModel.delete(index: index)
        viewModel.completion = {
            self.collection.reloadData()
            }
        }
    }
       
