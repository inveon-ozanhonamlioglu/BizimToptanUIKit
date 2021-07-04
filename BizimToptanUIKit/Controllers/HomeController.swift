//
//  ViewController.swift
//  BizimToptanUIKit
//
//  Created by ozan honamlioglu on 9.06.2021.
//

import UIKit
import Combine
import Kingfisher

class HomeController: UITableViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var bannerSwiperCollectionView: UICollectionView!
    @IBOutlet weak var infinitySwiperCollectionView: UICollectionView!
    @IBOutlet weak var infinitySwiperSecondCollectionView: UICollectionView!
    @IBOutlet weak var infinitySwiperBlockCollectionView: UICollectionView!
    
    
    // MARK: - Managers
    let bannerSwiperService = BannerSwiperService()
    let infinitySwiperService = InfinitySwiperService()
    var bag = Set<AnyCancellable>()
    
    
    // MARK: - Variables
    var bannerSwiperImages: [String] = []
    var infinitySwiperImages: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set header
        self.homeHeader()
        
        IProductSwiperService.fetchProducts() // we want to fetch all swiper products when the app initializes
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
        
        infinitySwiperSecondCollectionView.dataSource = self
        infinitySwiperSecondCollectionView.delegate = self
        
        infinitySwiperBlockCollectionView.dataSource = self
        infinitySwiperBlockCollectionView.delegate = self
        
        // register xibs.
        let pstvc = UINib(nibName: "ProductSwiperTableViewCell", bundle: nil)
        tableView.register(pstvc, forCellReuseIdentifier: "thirdRow")
        tableView.register(pstvc, forCellReuseIdentifier: "fifthRow")
        
        let iscvc = UINib(nibName: "InfinitySwiperCollectionViewCell", bundle: nil)
        infinitySwiperCollectionView.register(iscvc, forCellWithReuseIdentifier: "infinitySwiperCollectionViewCell")
        infinitySwiperSecondCollectionView.register(iscvc, forCellWithReuseIdentifier: "infinitySwiperCollectionViewCell")
        infinitySwiperBlockCollectionView.register(iscvc, forCellWithReuseIdentifier: "infinitySwiperCollectionViewCell")
        
        let bscvc = UINib(nibName: "BannerSwiperCollectionViewCell", bundle: nil)
        bannerSwiperCollectionView.register(bscvc, forCellWithReuseIdentifier: "bannerSwiperCollectionViewCell")
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 4) {
            return 320
        } else if(indexPath.row == 5) {
            let height = (infinitySwiperImages.count / 2) * 140
            return CGFloat(height)
        }

        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "thirdRow", for: indexPath) as! ProductSwiperTableViewCell
            return cell
        } else if(indexPath.row == 4) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "thirdRow", for: indexPath) as! ProductSwiperTableViewCell
            cell.removeSegment()
            cell.selectTab = .chosenForYou
            cell.loader.startAnimating()
            return cell
        }
        
        return super.tableView(tableView, cellForRowAt: indexPath)
    }
    
}


extension HomeController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == bannerSwiperCollectionView) { // for the first section "BannerSwiper"
            return bannerSwiperImages.count
        } else if(collectionView == infinitySwiperCollectionView) {
            return infinitySwiperImages.count
        } else if(collectionView == infinitySwiperSecondCollectionView) {
            return infinitySwiperImages.count
        } else if(collectionView == infinitySwiperBlockCollectionView) {
            return infinitySwiperImages.count
        }

        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == bannerSwiperCollectionView) { // for the first section "BannerSwiper"
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerSwiperCollectionViewCell", for: indexPath) as! BannerSwiperCollectionViewCell
            
            let imageUrl = bannerSwiperImages[indexPath.row]
            cell.imageUrl = imageUrl
            return cell
            
        } else if(collectionView == infinitySwiperCollectionView) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "infinitySwiperCollectionViewCell", for: indexPath) as! InfinitySwiperCollectionViewCell
            let imgUrl = infinitySwiperImages[indexPath.row]
            cell.imageUrl = imgUrl
            return cell
        } else if(collectionView == infinitySwiperSecondCollectionView) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "infinitySwiperCollectionViewCell", for: indexPath) as! InfinitySwiperCollectionViewCell
            let imgUrl = infinitySwiperImages[indexPath.row]
            cell.imageUrl = imgUrl
            return cell
        } else if(collectionView == infinitySwiperBlockCollectionView) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "infinitySwiperCollectionViewCell", for: indexPath) as! InfinitySwiperCollectionViewCell
            let imgUrl = infinitySwiperImages[indexPath.row]
            cell.imageUrl = imgUrl
            return cell
        }
        
        
        return UICollectionViewCell(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if(collectionView == infinitySwiperBlockCollectionView) {
            return CGSize(width: UIScreen.main.bounds.width / 2.3, height: 120)
        }

        return CGSize(width: 150, height: 100)
    }
    
}


extension HomeController: UICollectionViewDelegate {
    
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
