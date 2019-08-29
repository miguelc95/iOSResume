//
//  EducationTableViewCell.swift
//  Resume
//
//  Created by Miguel Fernando Cuellar Gauna on 8/26/19.
//  Copyright © 2019 Miguel Fernando Cuellar Gauna. All rights reserved.
//

import UIKit

class EducationTableViewCell: UITableViewCell {

    @IBOutlet weak var EducationImage: UIImageView!
    @IBOutlet weak var school: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
