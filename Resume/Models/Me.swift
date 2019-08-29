//
//  Me.swift
//  Resume
//
//  Created by Miguel Fernando Cuellar Gauna on 8/26/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import Foundation


class Me: Decodable {
    var info: String
    var image: String
    var education: [Education]?
    
    enum CodingKeys: String, CodingKey {
        case info = "info"
        case image = "image"
        case education = "education"
    }
    
    init() {
        info = ""
        image = ""
    }
    
    init(info: String, image: String) {
        self.info = info
        self.image = image
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        education = try? values.decodeIfPresent([Education].self, forKey: .education)
        info = try values.decodeIfPresent(String.self, forKey: .info) ?? ""
        image = try values.decodeIfPresent(String.self, forKey: .image) ?? ""
    }
}
