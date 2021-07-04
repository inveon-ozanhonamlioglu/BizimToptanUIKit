//
//  NavigationBar+Extension.swift
//  BizimToptanUIKit
//
//  Created by ozan honamlioglu on 4.07.2021.
//

import UIKit

extension UIViewController {
    
    // We will set up our custom navigation bars programmatically in here
    func homeHeader() {
        
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
        
        // let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        let BUTTON_SIZE = 50

        var loginBtn: UIButton {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 25, height: BUTTON_SIZE))
            button.backgroundColor = .red
            
            button.setTitle("Giriş yap", for: .normal)
            button.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(fontAttributes: [UIFontDescriptor.AttributeName.name: "Helvetica"]), size: 10)
            button.setTitleColor(.darkGray, for: .normal)

            button.setImage(UIImage(systemName: "person.circle"), for: .normal)
            button.tintColor = .darkGray
            button.imageEdgeInsets = UIEdgeInsets(top: 8, left: 20, bottom: 17, right: 0)
            button.titleEdgeInsets = UIEdgeInsets(top: 25, left: -15, bottom: 0, right: 0)

            return button
        }
        
        let login = UIBarButtonItem(customView: loginBtn)

        navigationItem.rightBarButtonItems = [
            login
        ]

    }
    
}
