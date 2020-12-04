//
//  BrandsCollectionViewCell.swift
//  Shopify
//
//  Created by Jitendra Rajput on 04/12/20.
//

import UIKit

class BrandsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productsImageView: UIImageView!
    @IBOutlet weak var brandNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        roundTopCorner()
    }
    
    func populateBrands(data: String){
        brandNameLabel.text = data
    }

}
