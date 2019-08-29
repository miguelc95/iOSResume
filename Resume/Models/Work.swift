//
//  Work.swift
//  Resume
//
//  Created by Miguel Fernando Cuellar Gauna on 8/27/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import Foundation

class Work: Decodable {
    var info: String?
    var experience: [Job]?
    
    enum CodingKeys: String, CodingKey {
        case info = "info"
        case experience = "experience"
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
        experience = try? values.decodeIfPresent([Job].self, forKey: .experience)
    }
    
}
