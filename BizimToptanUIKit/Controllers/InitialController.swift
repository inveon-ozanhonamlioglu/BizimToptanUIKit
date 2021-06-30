//
//  InitialController.swift
//  BizimToptanUIKit
//
//  Created by ozan honamlioglu on 30.06.2021.
//

import UIKit

class InitialController: UIViewController {
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redirect()
    }
    
    private func redirect() {
        loader.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 02) {
            self.performSegue(withIdentifier: "routeToFirstTab", sender: nil)
        }
        
        
    }
    
}
