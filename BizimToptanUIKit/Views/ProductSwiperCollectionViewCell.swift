//
//  ProductSwiperCollectionViewCell.swift
//  BizimToptanUIKit
//
//  Created by ozan honamlioglu on 16.06.2021.
//

import UIKit

class ProductSwiperCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var addButton: UIStackView!
    @IBOutlet weak var counter: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        setupUI()
    }

    private func setupUI() {
        addButton.layer.cornerRadius = 5
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
    
}
