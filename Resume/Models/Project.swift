//
//  Project.swift
//  Resume
//
//  Created by Miguel Fernando Cuellar Gauna on 8/28/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import Foundation


class Project: Decodable {
    var title: String?
    var date: Date?
    var image: String?
    var description: String?

    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case date = "date"
        case image = "image"
        case description = "description"
    }
    
    init(title: String) {
        self.title = title
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try? values.decodeIfPresent(String.self, forKey: .title)
        date = try? values.decodeIfPresent(Date.self, forKey: .date)
        image = try? values.decodeIfPresent(String.self, forKey: .image)
        description = try? values.decodeIfPresent(String.self, forKey: .description)

    }
    
}
