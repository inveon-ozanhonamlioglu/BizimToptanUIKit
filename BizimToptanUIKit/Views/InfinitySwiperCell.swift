//
//  InfinitySwiperCell.swift
//  BizimToptanUIKit
//
//  Created by ozan honamlioglu on 14.06.2021.
//

import UIKit
import Kingfisher

class InfinitySwiperCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    
    var imageUrl: String! {
        didSet {
            self.updateUI()
        }
    }
    
    private func updateUI() {
        let url = URL(string: imageUrl)
        image.kf.setImage(with: url)
    }
    
}
