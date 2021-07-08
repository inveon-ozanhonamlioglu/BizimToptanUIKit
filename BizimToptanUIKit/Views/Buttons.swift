//
//  Buttons.swift
//  BizimToptanUIKit
//
//  Created by ozan honamlioglu on 8.07.2021.
//

import Foundation
import UIKit

func createButtonWithText(labelString: String, systemImageString: String) -> UIButton {

    var btn: UIButton {
        let labelWidth = labelString.widthOfString(usingFont: UIFont(name: "Helvetica", size: 10)!)
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: labelWidth, height: 40))
        
        button.setTitle(labelString, for: .normal)
        button.titleLabel?.font = UIFont(descriptor: UIFontDescriptor(fontAttributes: [UIFontDescriptor.AttributeName.name: "Helvetica"]), size: 10)
        button.setTitleColor(.darkGray, for: .normal)
        button.setImage(UIImage(systemName: systemImageString), for: .normal)
        button.tintColor = .darkGray
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: (labelWidth / 2), bottom: 17, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 25, left: -20, bottom: 0, right: 0)

        return button
    }
    
    func xx() {
        
    }
    
    return btn
}
