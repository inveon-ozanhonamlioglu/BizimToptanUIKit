//
//  ViewController.swift
//  BizimToptanUIKit
//
//  Created by ozan honamlioglu on 9.06.2021.
//

import UIKit
import Combine

class MainPageTableViewController: UITableViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK: - Managers
    let bannerService = BannerSwiperService()
    var bag = Set<AnyCancellable>()
    
    
    // MARK: - Variables
    var bannerSwiperImages: [String] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        observeBanners()
    }

    private func observeBanners() {
        bannerService
            .fetchBanners()
            .sink { [unowned self] completion in
                
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    // self.setupUI()
                    self.collectionView.reloadData()
                }
                
            } receiveValue: { [unowned self] banner in
                self.bannerSwiperImages.append(banner.imageUrl)
            }
            .store(in: &bag)
    }
    
    private func setupUI() {}

}


extension MainPageTableViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerSwiperImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerSwiperCell", for: indexPath) as! BannerSwiperCell
        
        let imageUrl = bannerSwiperImages[indexPath.row]
        cell.imageUrl = imageUrl
        // cell.contentView.backgroundColor = bannerService.randomColor
        
        return cell
    }
    
}


extension MainPageTableViewController: UICollectionViewDelegate {
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = UIScreen.main.bounds.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: (roundedIndex * cellWidthIncludingSpacing) - scrollView.contentInset.left, y: scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
    
}
