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
}
