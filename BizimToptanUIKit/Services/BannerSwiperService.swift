//
//  BannerSwiperService.swift
//  BizimToptanUIKit
//
//  Created by ozan honamlioglu on 10.06.2021.
//

import UIKit
import Combine

// this service has no model actually, so we will implement it here quickly

struct BannerSwiperModel {
    var imageUrl: String
}

class BannerSwiperService {
    
    func fetchBanners() -> AnyPublisher<BannerSwiperModel, Never> {
        let images = [
            BannerSwiperModel(imageUrl: "https://img-bizimtoptan.mncdn.com/Content/Images/Thumbs/0445027.jpeg"),
            BannerSwiperModel(imageUrl: "https://img-bizimtoptan.mncdn.com/Content/Images/Thumbs/0433854.jpeg"),
            BannerSwiperModel(imageUrl: "https://img-bizimtoptan.mncdn.com/Content/Images/Thumbs/0439454.jpeg"),
            BannerSwiperModel(imageUrl: "https://img-bizimtoptan.mncdn.com/Content/Images/Thumbs/0422658.jpeg"),
            BannerSwiperModel(imageUrl: "https://img-bizimtoptan.mncdn.com/Content/Images/Thumbs/0434062.jpeg")
        ]
        
        return images.map { $0 }.publisher.eraseToAnyPublisher()
    }
    
    var randomColor: UIColor {
        [UIColor.red, UIColor.green, UIColor.blue].randomElement()!
    }
    
}
