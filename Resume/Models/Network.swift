//
//  Network.swift
//  Resume
//
//  Created by Miguel Fernando Cuellar Gauna on 8/26/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import UIKit


class Network {
    static func getExternalData<T: Decodable>(fileLocation: String, completionHandler: @escaping (T?, Error?) -> Void){
        if let request = URL(string: fileLocation) {
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 200
                
                if error != nil {
                    completionHandler(nil, error)
                }
                
                if statusCode != 200 {
                    completionHandler(nil, error)
                }
                
                do {
                    if let jsonData = data {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .custom { (decoder) -> Date in
                            let value = try decoder.singleValueContainer().decode(String.self)
                            
                            let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy-MM-dd"
                            
                            if let date = formatter.date(from: value) {
                                return date
                            }
                            return Date()
                        }
                        let typedObject: T? = try decoder.decode(T.self, from: jsonData)
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                            completionHandler(typedObject, nil)
                        }
                    }
                } catch {
                    completionHandler(nil, error)
                }
            }
            
            task.resume()
        } else {
            completionHandler(nil, NSError(domain: "Url does not exist", code: 1001, userInfo: nil))
        }
        
    }
    
    static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
}
