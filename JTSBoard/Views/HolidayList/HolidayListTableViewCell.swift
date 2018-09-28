//
//  HolidayListTableViewCell.swift
//  JTSBoard
//
//  Created by jts on 27/08/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit

class HolidayListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblHolidayTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
