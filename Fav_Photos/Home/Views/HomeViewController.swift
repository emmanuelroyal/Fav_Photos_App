//
//  HomeViewController.swift
//  Fav_Photos
//
//  Created by Decagon on 7/21/21.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource {
        @IBOutlet weak var Collection: UICollectionView!
    var viewModel = CollectionViewModel()
        override func viewDidLoad() {
            super.viewDidLoad()
            Collection.dataSource = self
        }
        
        override func viewWillAppear(_ animated: Bool) {
                DispatchQueue.main.async {
                    self.Collection.reloadData()
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            1
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell =
                    Collection.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? CollectionViewCell
            else { return UICollectionViewCell() }
            cell.setup(with: viewModel.data[indexPath.row])
            cell.delegate = self
            cell.tag = indexPath.row
            return cell
        }
    }

    extension HomeViewController: collectionViewCellDelegate {
        func didTapRemoveBtn(with index: Int) {
            self.viewModel.delete(index: index)
            viewModel.completion = {
                self.Collection.reloadData()
                }
            }
        }
           
