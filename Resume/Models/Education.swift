//
//  Education.swift
//  Resume
//
//  Created by Miguel Fernando Cuellar Gauna on 8/26/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import Foundation


class Education: Decodable {
    var school: String?
    var date: Date?
    var description: String?
    var image: String?
    
    enum CodingKeys: String, CodingKey {
        case school = "school"
        case date = "date"
        case image = "image"
        case description = "description"
    }
    
    init(school: String, date: Date, description: String) {
        self.school = school
        self.date = date
        self.description = description
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        school = try? values.decodeIfPresent(String.self, forKey: .school)
        
        description = try values.decodeIfPresent(String.self, forKey: .description)
        image = try? values.decodeIfPresent(String.self, forKey: .image)
        date = try? values.decodeIfPresent(Date.self, forKey: .date)


    }
    
}
