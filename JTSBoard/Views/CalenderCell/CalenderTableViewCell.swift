//
//  CalenderTableViewCell.swift
//  JTSBoard
//
//  Created by jts on 13/09/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit

class CalenderTableViewCell: UITableViewCell {

    @IBOutlet weak var lblJobName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblLastVisit: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblStaff: UILabel!
    @IBOutlet weak var lblOngoing: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
