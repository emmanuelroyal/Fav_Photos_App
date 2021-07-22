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
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var Collection: UICollectionView!
    var viewModel = CollectionViewModel()
        override func viewDidLoad() {
            super.viewDidLoad()
            viewModel.getUserPhoto()
            viewModel.getUserName()
            Collection.dataSource = self
            viewModel.usernameHandler = { [weak self] in
                self?.welcomeLabel.text = self?.viewModel.greetings
                self?.welcomeLabel.font = UIFont(name: "Helvetica", size: 20.0)
                self?.welcomeLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
                self?.userPhoto.kf.setImage(with: self?.viewModel.photo.asUrl)
            }
        }
        
        override func viewWillAppear(_ animated: Bool) {
                DispatchQueue.main.async {
                    self.Collection.reloadData()
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
           
