//
//  String+Extension.swift
//  BizimToptanUIKit
//
//  Created by ozy on 1.07.2021.
//
import UIKit

extension String {
    func createAttributedText(with style: [NSAttributedString.Key : Any]?) -> NSAttributedString {
        NSAttributedString(string: self, attributes: style)
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttribute = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttribute)
        return size.width
    }
}
