//
//  Personal.swift
//  Resume
//
//  Created by Miguel Fernando Cuellar Gauna on 8/28/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import Foundation

class Personal: Decodable {
    var info: String?
    var projects: [Project]?
    
    enum CodingKeys: String, CodingKey {
        case info = "info"
        case projects = "projects"
    }
    
    init() {
        info = ""
    }
    
    init(school: String, startDate: Date) {
        self.info = school
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        info = try? values.decodeIfPresent(String.self, forKey: .info)
        projects = try? values.decodeIfPresent([Project].self, forKey: .projects)
    }
    
}
