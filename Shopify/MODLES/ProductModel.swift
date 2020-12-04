//
//  ProductModel.swift
//  Shopify
//
//  Created by Jitendra Rajput on 04/12/20.
//

import Foundation

class ProductsModel{
    var id: String = ""
    var title: String = ""
    var productType: String = ""
    var imageSrc: String = ""
    
    init(object:[String: Any]) {
        self.id = Helper.checkNullAndPassValue(stringPassed: object["id"])
        self.title = Helper.checkNullAndPassValue(stringPassed: object["title"])
        self.productType = Helper.checkNullAndPassValue(stringPassed: object["product_type"])
        self.imageSrc = Helper.checkNullAndPassValue(stringPassed: (object["image"] as? [String: Any] ?? [:])["src"])
    }
}
