//
//  ServiceListTableViewCell.swift
//  JTSBoard
//
//  Created by jts on 31/08/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit

class ServiceListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblServiceDate: UILabel!
    @IBOutlet weak var lblServiceName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
