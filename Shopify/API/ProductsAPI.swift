//
//  ProductsAPI.swift
//  Shopify
//
//  Created by Jitendra Rajput on 04/12/20.
//

import Foundation

class ProductsAPI{
    func getProuctsList(completion:@escaping(_ data: [ProductsModel],_ brandsList:[String]) -> Void){
        let username: String = "33119f58aa822ed242bca3c5a217df6e"
        let password: String = "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"
        
        let _ = Services.shared.requestData(method: .GET,url: "https://\(username):\(password)@fashionrevolt.myshopify.com/admin/api/2020-10/products.json") { (data, error) in
            guard let responseData = data else { completion([],[]); return }
            do{
                let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as! [String:Any]
                var productsList: [ProductsModel] = []
                for val in (jsonData["products"] as? [AnyObject] ?? []){
                    let products = ProductsModel(object: val as! [String:Any])
                    productsList.append(products)
                }
                let productType = productsList.map{ $0.productType }
                let brandsList = Array(Set(productType))
                completion(productsList,brandsList)
            }catch{
                completion([],[])
            }
        }
    }
}

