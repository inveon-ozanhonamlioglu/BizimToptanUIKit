//
//  ProductSwiperCollectionViewCell.swift
//  BizimToptanUIKit
//
//  Created by ozan honamlioglu on 16.06.2021.
//

import UIKit
import Kingfisher

class ProductSwiperCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var addButton: UIStackView!
    @IBOutlet weak var counter: UITextField!
    @IBOutlet weak var initialAddButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var currentPrice: UILabel!
    @IBOutlet weak var oldPrice: UILabel!
    
    // in variables
    var initialAddOccured = false
    var imgUrl: String = "" {
        willSet {
            let url = URL(string: newValue)
            imageView.kf.setImage(with: url, placeholder: UIImage(named: "nature"), options: .none) { result, error in
                
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        setupUI()
    }
    
    private func setupUI() {
        addButton.layer.cornerRadius = 5
        initialAddButton.layer.cornerRadius = 5
    }

    
    // MARK: - Actions
    @IBAction func decreaseCounter(_ sender: UIButton) {
        if let str = counter.text {
            guard let int = Int(str) else { return }
            if(int > 0) {
                counter.text = String(int - 1)
            }
        }
    }
    
    
    @IBAction func increaseCounter(_ sender: UIButton) {
        if let str = counter.text {
            guard let int = Int(str) else { return }
            counter.text = String(int + 1)
        }
    }
    
    @IBAction func firstAdd(_ sender: UIButton) {
        initialAddButton.isHidden = true
    }
    
    
}
