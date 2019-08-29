//
//  Job.swift
//  Resume
//
//  Created by Miguel Fernando Cuellar Gauna on 8/27/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import Foundation


class Job: Decodable {
    var startDate: Date?
    var endDate: Date?
    var description: String?
    var logo: String?
    var technologies: [Technology]?
    
    enum CodingKeys: String, CodingKey {
        case startDate = "startDate"
        case endDate = "endDate"
        case logo = "logo"
        case description = "description"
        case technologies = "technologies"
    }
    
    init() {
        self.description = ""
        self.logo = ""
    }
    
    init(school: String, startDate: Date, endDate: Date, description: String, logo: String) {
        self.startDate = startDate
        self.endDate = endDate
        self.description = description
        self.logo = logo
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        startDate = try? values.decodeIfPresent(Date.self, forKey: .startDate)
        endDate = try? values.decodeIfPresent(Date.self, forKey: .endDate)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        logo = try? values.decodeIfPresent(String.self, forKey: .logo)
        technologies = try? values.decodeIfPresent([Technology].self, forKey: .technologies)
    }
    
}
