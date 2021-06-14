//
//  BannerSwiperCell.swift
//  BizimToptanUIKit
//
//  Created by ozan honamlioglu on 10.06.2021.
//

import UIKit
import Kingfisher

class BannerSwiperCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var imageUrl: String! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let url = URL(string: imageUrl)
        backgroundImageView.kf.setImage(with: url)
        backgroundImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        backgroundImageView.contentMode = .scaleAspectFill
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        contentView.contentMode = .scaleAspectFill
    }
    
}
