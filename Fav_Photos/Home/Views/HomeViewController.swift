//
//  HomeViewController.swift
//  Fav_Photos
//
//  Created by Decagon on 7/21/21.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController, UICollectionViewDataSource {
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var Collection: UICollectionView!
    var viewModel = CollectionViewModel()
        override func viewDidLoad() {
            super.viewDidLoad()
            viewModel.get()
            viewModel.getUserPhoto()
            viewModel.getUserName()
            Collection.dataSource = self
            viewModel.notifyCompletion = { [weak self] in
                DispatchQueue.main.async {
                    self?.Collection.reloadData()
                }
            }
        }
        
        override func viewWillAppear(_ animated: Bool) {
            viewModel.getUserPhoto()
                DispatchQueue.main.async {
                    self.Collection.reloadData()
                    self.viewModel.usernameHandler = { [weak self] in
                        self?.welcomeLabel.text = self?.viewModel.greetings
                        self?.userPhoto.kf.setImage(with: self?.viewModel.photo.asUrl)
                    }
            }
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            viewModel.data.count
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
           
