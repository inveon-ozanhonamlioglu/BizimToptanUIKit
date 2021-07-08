//
//  NavigationBar+Extension.swift
//  BizimToptanUIKit
//
//  Created by ozan honamlioglu on 4.07.2021.
//

import UIKit

extension UIViewController {
    
    // We will set up our custom navigation bars programmatically in here
    func setHomeHeader() {
        
        guard let navigationBar = self.navigationController?.navigationBar else { return }

        // MARK: - LEFT
        let image = UIImage(named: "header_logo")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
        imageView.image = image
        imageView.contentMode = .scaleAspectFit

        // MARK: - RIGHT
        navigationBar.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: navigationBar.leftAnchor)
        ])
        
        // let login = UIBarButtonItem(customView: createButtonWithText())
        // let deliveryType = UIBarButtonItem(customView: createButtonWithText())
        // let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        
        let login = createButtonWithText(labelString: "Giriş Yap", systemImageString: "person.circle")
        let deliveryType = createButtonWithText(labelString: "Kargo ile Teslimat", systemImageString: "bus.fill")
        let rightBtnsView = UIStackView(arrangedSubviews: [deliveryType, login])
        rightBtnsView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtnsView)
    }
    
}
