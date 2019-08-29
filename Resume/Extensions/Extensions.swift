//
//  Extensions.swift
//  Resume
//
//  Created by Miguel Fernando Cuellar Gauna on 8/26/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import UIKit

extension Date {
    func dateMonthYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        return formatter.string(from: self)
    }
}

//ALERT extension gotten from stack overflow by Ryan Bobrowski
//https://stackoverflow.com/users/918065/ryan-bobrowski
extension UIViewController {
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}

//HELP for the image cache extension gotten from Tim Beals

    extension UIImage {
        static let imageCache = NSCache<AnyObject, AnyObject>()
        static func cacheImage(from endPoint: String, completion: @escaping (UIImage?) -> ()) {
            if let url = URL.init(string: endPoint) {
                Network.getData(from: url) { data, response, error in
                    
                    guard error == nil else {
                        print(error!.localizedDescription)
                        completion(nil)
                        return
                    }
                    
                    guard let currData = data else {
                        completion(nil)
                        return
                    }
                    
                    guard let image = UIImage(data: currData) else {
                        completion(nil)
                        return
                    }
                    
                    DispatchQueue.main.async {
                        imageCache.setObject(image, forKey: endPoint as AnyObject)
                    }
                    
                    completion(image)
                }
            }
            
        }
    }

extension UIImageView {
    func downloadFrom(endpoint: String){
        UIImage.cacheImage(from: endpoint) { (image) in
            guard let imageFromCache = image else {
                return
            }
            DispatchQueue.main.async {
                self.image = imageFromCache
            }
        }
    }
}

