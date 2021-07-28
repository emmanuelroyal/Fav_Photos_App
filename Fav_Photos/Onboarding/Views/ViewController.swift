//
//  ViewController.swift
//  Fav_Photos
//
//  Created by Decagon on 7/18/21.
//

import UIKit
import ShimmerSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var skip: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    private let viewModel = OnboardingViewModel()
    private let viewModelss = AlamofireReq()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        collectionView.dataSource = self
        setNavBar()
        viewModelss.completion = {
            print(self.viewModelss.networkData)
        }
        pageControl.numberOfPages = viewModel.slides.count
        viewModel.updateButton = { [weak self] title, currentPage, btnTitle in
            self?.pageControl.currentPage = currentPage
            self?.nextButton.setTitle(title, for: .normal)
            self?.skip.setTitle(btnTitle, for: .normal)
           
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.nextButton.center.y += 5
        nextButton.alpha = 0.3
        nextButton.backgroundColor = .systemIndigo
    }

    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 1.0 , delay: 0.5,
        usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [],
        animations: { [self] in
          self.nextButton.center.y -= 5.0
          self.nextButton.alpha = 1.0
            nextButton.backgroundColor = .systemGray6
            nextButton.layer.cornerRadius = 15
        },
        completion: nil)
    }
    

    @IBAction func skipPressed(_ sender: Any) {
        skippedToWelcomePage()
    }
    @IBAction func nextPressed(_ sender: UIButton) {
        if viewModel.currentPage == viewModel.slides.count - 1 {
            skippedToWelcomePage()
        } else {
            viewModel.currentPage += 1
            let indexPath = IndexPath(item: viewModel.currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
        }
    }
    
    private func skippedToWelcomePage() {
        guard let newViewController = storyboard?.instantiateViewController(identifier: "WelcomePageStoryBoard") as?  WelcomePageViewController  else {
            return
        }
        navigationController?.pushViewController(newViewController, animated: true)
    }
}

extension ViewController: UICollectionViewDelegate,
                                    UICollectionViewDataSource,
                                    UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as?
                OnboardingCollectionViewCell else {
                    return UICollectionViewCell()
                }
        cell.setUp(viewModel.slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        viewModel.currentPage = Int(scrollView.contentOffset.x/width)
    }
}

