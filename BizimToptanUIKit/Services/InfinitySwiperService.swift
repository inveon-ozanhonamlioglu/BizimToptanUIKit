//
//  InfinitySwiperService.swift
//  BizimToptanUIKit
//
//  Created by ozan honamlioglu on 14.06.2021.
//

import Foundation
import Combine
// this service has no model actually, so we will implement it here quickly

struct InfinitySwiperModel {
    var imageUrl: String
}

class InfinitySwiperService {
    
    func fetchBanners() -> AnyPublisher<InfinitySwiperModel, Never> {
        let images = [
            InfinitySwiperModel(imageUrl: "https://img-bizimtoptan.mncdn.com/mnresize/980/980/Content/Images/Originals/0144125_0.jpeg"),
            InfinitySwiperModel(imageUrl: "https://img-bizimtoptan.mncdn.com/mnresize/980/980/Content/Images/Originals/0133492_0.jpeg"),
            InfinitySwiperModel(imageUrl: "https://img-bizimtoptan.mncdn.com/mnresize/980/980/Content/Images/Originals/0144124_0.jpeg"),
            InfinitySwiperModel(imageUrl: "https://img-bizimtoptan.mncdn.com/mnresize/980/980/Content/Images/Originals/0133470_0.jpeg")
        ]
        
        return images.map { $0 }.publisher.eraseToAnyPublisher()
    }
    
}
