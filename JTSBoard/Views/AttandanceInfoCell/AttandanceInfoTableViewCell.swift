//
//  AttandanceInfoTableViewCell.swift
//  JTSBoard
//
//  Created by jts on 14/08/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit

class AttandanceInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCheckInTime: UILabel!
    @IBOutlet weak var lblCheckoutTime: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var lblLunchHours: UILabel!
    @IBOutlet weak var lblWorkingHours: UILabel!
    @IBOutlet weak var lblTotalHours: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
