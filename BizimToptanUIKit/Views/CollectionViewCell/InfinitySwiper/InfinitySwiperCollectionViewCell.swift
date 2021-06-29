//
//  InfinitySwiperCollectionViewCell.swift
//  BizimToptanUIKit
//
//  Created by ozan honamlioglu on 29.06.2021.
//

import UIKit
import Kingfisher

class InfinitySwiperCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    var imageUrl: String? {
        willSet {
            let url = URL(string: newValue ?? "")
            imageView.kf.setImage(with: url, placeholder: UIImage(named: "nature"), options: .none) { result, error in
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
