//
//  ImageView+Exension.swift
//  PersonalRecipe
//
//  Created by Aswani G on 3/5/21.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func setImage(urlstring: String, placeholder: UIImage? = nil) {
        guard let url = URL(string: urlstring) else {
            return
        }
        image = placeholder
        if let imageFromCache = imageCache.object(forKey: urlstring as NSString) {
            self.image = imageFromCache
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil, let data = data else {
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                if let imageToCache = UIImage(data: data) {
                    imageCache.setObject(imageToCache, forKey: urlstring as NSString)
                    self.image = imageToCache
                }
            }
        }.resume()
    }
}
