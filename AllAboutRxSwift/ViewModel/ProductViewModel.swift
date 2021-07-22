//
//  ProductViewModel.swift
//  AllAboutRxSwift
//
//  Created by Sanjay Mali on 21/07/21.
//

import Foundation
import RxSwift
import RxCocoa
struct ProductViewModel {
    var items = PublishSubject<[Product]>()
    func fetchItems() {
        let product = [
            Product(imageName: "house", title: "Home"),
            Product(imageName: "gear", title: "Settings"),
            Product(imageName: "person", title: "Profile"),
            Product(imageName: "airplane", title: "Flights"),
        ]
        items.onNext(product)
        items.onCompleted()
    }
}
