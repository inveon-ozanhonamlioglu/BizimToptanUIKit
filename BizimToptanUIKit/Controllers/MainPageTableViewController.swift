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
    @IBOutlet weak var bannerSwiperCollectionView: UICollectionView!
    @IBOutlet weak var infinitySwiperCollectionView: UICollectionView!
    
    
    // MARK: - Managers
    let bannerSwiperService = BannerSwiperService()
    let infinitySwiperService = InfinitySwiperService()
    var bag = Set<AnyCancellable>()
    
    
    // MARK: - Variables
    var bannerSwiperImages: [String] = []
    var infinitySwiperImages: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        observers()
    }

    private func observers() {
        bannerSwiperService
            .fetchBanners()
            .sink { [unowned self] completion in
                
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    // self.setupUI()
                    self.bannerSwiperCollectionView.reloadData()
                }
                
            } receiveValue: { [unowned self] banner in
                self.bannerSwiperImages.append(banner.imageUrl)
            }
            .store(in: &bag)
        
        infinitySwiperService
            .fetchBanners()
            .sink { [unowned self] completion in
                
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    self.infinitySwiperCollectionView.reloadData()
                }
                
            } receiveValue: { [unowned self] banner in
                self.infinitySwiperImages.append(banner.imageUrl)
            }
            .store(in: &bag)

    }
    
    private func setupUI() {
        bannerSwiperCollectionView.dataSource = self
        bannerSwiperCollectionView.delegate = self
        
        infinitySwiperCollectionView.dataSource = self
        infinitySwiperCollectionView.delegate = self
        
        // register xibs.
        let cell = UINib(nibName: "ProductSwiperTableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "thirdRow")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "thirdRow", for: indexPath) as! ProductSwiperTableViewCell
            return cell
        }
        
        return super.tableView(tableView, cellForRowAt: indexPath)
    }
    
}


extension MainPageTableViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == bannerSwiperCollectionView) { // for the first section "BannerSwiper"
            return bannerSwiperImages.count
        } else if(collectionView == infinitySwiperCollectionView) {
            return infinitySwiperImages.count
        }

        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == bannerSwiperCollectionView) { // for the first section "BannerSwiper"
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerSwiperCell", for: indexPath) as! BannerSwiperCell
            
            let imageUrl = bannerSwiperImages[indexPath.row]
            cell.imageUrl = imageUrl
            // cell.contentView.backgroundColor = bannerService.randomColor
            
            return cell
            
        } else if(collectionView == infinitySwiperCollectionView) {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "infinitySwiperCell", for: indexPath) as! InfinitySwiperCell
            let imgUrl = infinitySwiperImages[indexPath.row]
            cell.imageUrl = imgUrl
            return cell
            
        }

        
        return UICollectionViewCell(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
    }
    
}


extension MainPageTableViewController: UICollectionViewDelegate {
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if (scrollView == bannerSwiperCollectionView) { // for the first section "BannerSwiper"
            let layout = self.bannerSwiperCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
            let cellWidthIncludingSpacing = UIScreen.main.bounds.width + layout.minimumLineSpacing
            
            var offset = targetContentOffset.pointee
            let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
            let roundedIndex = round(index)
            
            offset = CGPoint(x: (roundedIndex * cellWidthIncludingSpacing) - scrollView.contentInset.left, y: scrollView.contentInset.top)
            targetContentOffset.pointee = offset
        }
        
    }
    
}
