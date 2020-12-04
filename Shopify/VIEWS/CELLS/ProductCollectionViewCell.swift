//
//  ProductCollectionViewCell.swift
//  Shopify
//
//  Created by Jitendra Rajput on 04/12/20.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var edgeCornerUIView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        roundTopCorner()
        roundCustomView()
    }

    func roundCustomView(){
        edgeCornerUIView.layer.masksToBounds = true
        edgeCornerUIView.layer.cornerRadius = 20
        edgeCornerUIView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
    }
   
    
    func populateData(data: ProductsModel){
        productNameLabel.text = data.title
        productImageView.downloaded(from: data.imageSrc.replacingOccurrences(of: "\\", with: "/"), contentMode: .scaleAspectFit)
    }
}


