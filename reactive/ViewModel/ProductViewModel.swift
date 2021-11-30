//
//  ProductViewModel.swift
//  reactive
//
//  Created by Nirav Zalavadia on 30/11/21.
//

import Foundation
import RxSwift

struct ProductViewModel
{
    let items = PublishSubject<[Product]>()
    
    func fetchItem()
    {
        let products = [
            Product(imagename: "house", title: "House"),
            Product(imagename: "gear", title: "Gear"),
            Product(imagename: "person.circle", title: "Home")
        ]
        items.onNext(products)
        items.onCompleted()
    }
   
}
