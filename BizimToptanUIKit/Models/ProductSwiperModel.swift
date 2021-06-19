//
//  ProductSwiperModel.swift
//  BizimToptanUIKit
//
//  Created by ozan honamlioglu on 18.06.2021.
//

import Foundation

struct MPopularProducts: Decodable, Hashable {
    let headerLabel: String
    let data: [MPopularProductsData]
}

struct MPopularProductsData: Decodable, Hashable {
    let name: String
    let brand: String
    let description: String
    let imgUrl: String
    let price: String
    let id: Int
}
