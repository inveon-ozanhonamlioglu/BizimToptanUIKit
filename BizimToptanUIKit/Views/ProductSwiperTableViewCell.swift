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
    
    var loading: Bool = true {
        willSet {
            
        }
    }
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
        let cell = UINib(nibName: "ProductSwiperCollectionViewCell", bundle: nil)
        collectionView.register(cell, forCellWithReuseIdentifier: "productSwiperReuseableCell")
    }
    
    private func observers() {
        IProductSwiperService.bestSeller.compactMap{$0}.sink(receiveValue: { products in
            print(products)
        })
        .store(in: &bag)
    }
    
}

extension ProductSwiperTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productSwiperReuseableCell", for: indexPath) as! ProductSwiperCollectionViewCell
        return cell
    }
    
    
}
