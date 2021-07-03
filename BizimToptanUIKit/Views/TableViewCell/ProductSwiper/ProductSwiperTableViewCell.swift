//
//  ProductSwiperTableViewCell.swift
//  BizimToptanUIKit
//
//  Created by ozan honamlioglu on 16.06.2021.
//

import UIKit
import Combine

class ProductSwiperTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    var selectTab: ProductSwiperTab = .bestSeller
    
    var cvData: MPopularProducts? {
        willSet {
            collectionView.reloadData()
        }
    }
    
    var bestSeller: MPopularProducts?
    var newProducts: MPopularProducts?
    var choosenForYou: MPopularProducts?
    
    var bag = Set<AnyCancellable>()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setupUI()
        observers()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupUI() {
        loader.startAnimating()
        let cell = UINib(nibName: "ProductSwiperCollectionViewCell", bundle: nil)
        collectionView.register(cell, forCellWithReuseIdentifier: "productSwiperReuseableCell")
    }
    
    private func observers() {
        IProductSwiperService.bestSeller.sink(receiveValue: { [weak self] products in
            if(products != nil) {
                self?.loader.stopAnimating()
                self?.loader.isHidden = true
                
                if(self?.selectTab == .bestSeller) {
                    self?.cvData = products
                }
                
                self?.bestSeller = products
            }
        })
        .store(in: &bag)
        
        IProductSwiperService.newProducts.sink(receiveValue: { [weak self] products in
            if(products != nil) {
                self?.loader.stopAnimating()
                self?.loader.isHidden = true
                
                if(self?.selectTab == .newProduct) {
                    self?.cvData = products
                }
                
                self?.newProducts = products
            }
        })
        .store(in: &bag)
        
        IProductSwiperService.choosenForYou.sink(receiveValue: { [weak self] products in
            if(products != nil) {
                self?.loader.stopAnimating()
                self?.loader.isHidden = true
                
                if(self?.selectTab == .chosenForYou) {
                    self?.cvData = products
                }
                
                self?.choosenForYou = products
            }
        })
        .store(in: &bag)
        
    }
    
    func removeSegment() {
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.isHidden = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    @IBAction func tabController(_ sender: UISegmentedControl) {
        let selectedIndex = ProductSwiperTab(rawValue: sender.selectedSegmentIndex as Int) ?? .bestSeller
        
        switch selectedIndex {
        case .bestSeller:
            selectTab = .bestSeller
            cvData = bestSeller
            break
            
        case .newProduct:
            selectTab = .newProduct
            cvData = newProducts
            break
            
        case .chosenForYou:
            selectTab = .chosenForYou
            cvData = choosenForYou
            break
        }
        
    }
    
    
}

extension ProductSwiperTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cvData?.data.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productSwiperReuseableCell", for: indexPath) as! ProductSwiperCollectionViewCell
        cell.imgUrl = cvData?.data[indexPath.row].imgUrl ?? ""
        cell.productLabel.text = cvData?.data[indexPath.row].name ?? ""
        cell.currentPrice.text = cvData?.data[indexPath.row].price ?? ""
        
        let oldPrice = cvData?.data[indexPath.row].oldPrice ?? ""
        cell.oldPrice.attributedText = oldPrice.createAttributedText(with: [.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        return cell
    }
    
    
}
