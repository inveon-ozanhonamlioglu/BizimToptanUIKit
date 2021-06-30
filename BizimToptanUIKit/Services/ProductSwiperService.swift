//
//  ProductSwiperService.swift
//  BizimToptanUIKit
//
//  Created by ozan honamlioglu on 18.06.2021.
//

import Foundation
import Combine

enum ProductSwiperTab: Int {
    case bestSeller, newProduct, chosenForYou
}

class ProductSwiperService {
    var bestSeller = CurrentValueSubject<MPopularProducts?, Never>(nil)
    var newProducts = CurrentValueSubject<MPopularProducts?, Never>(nil)
    var choosenForYou = CurrentValueSubject<MPopularProducts?, Never>(nil)
    
    func fetchProducts() {
        let urlString = baseURL + "/product/popularProducts"
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else { return }
            guard data != nil else { return }
            
            do {
                let jsonData = try JSONDecoder().decode([MPopularProducts].self, from: data!)
                _ = jsonData.map { products in
                    if (products.headerLabel == "ÇOK SATANLAR") {
                        DispatchQueue.main.async {
                            self.bestSeller.send(products)
                        }
                    } else if (products.headerLabel == "YENİ ÜRÜNLER") {
                        DispatchQueue.main.async {
                            self.newProducts.send(products)
                        }
                    } else if (products.headerLabel == "SİZİN İÇİN SEÇTİKLERİMİZ") {
                        DispatchQueue.main.async {
                            self.choosenForYou.send(products)
                        }
                    }
                }
                
            } catch (let err) {
                print(err.localizedDescription)
            }
            
        }.resume()
        
    }
    
}

let IProductSwiperService = ProductSwiperService()
