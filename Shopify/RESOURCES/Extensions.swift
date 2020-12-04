//
//  Extensions.swift
//  Shopify
//
//  Created by Jitendra Rajput on 04/12/20.
//

import UIKit


//MARK: UIImageView Download Image
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

//MARK: UICollectionViewCell Round Corner with Shadow
extension UICollectionViewCell{
    func roundTopCorner(){
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 1.0
        layer.masksToBounds = false
        contentView.layer.shadowPath = UIBezierPath(roundedRect:bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        contentView.layer.cornerRadius = 10
    }
}

//MARK: Move Search bar to right Side
extension UISearchBar{
    func moveSearchIconToRightSide()
    {
        self.setImage(UIImage(), for: .search, state: .normal)
    }
   
}
