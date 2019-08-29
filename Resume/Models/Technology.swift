//
//  Technology.swift
//  Resume
//
//  Created by Miguel Fernando Cuellar Gauna on 8/27/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import Foundation

class Technology: Decodable {

    var image: String?
    
    enum CodingKeys: String, CodingKey {
        case image = "image"
    }
    
    init(school: String, date: Date, description: String) {
        self.image = ""
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        image = try? values.decodeIfPresent(String.self, forKey: .image)
        
        
    }
    
}
