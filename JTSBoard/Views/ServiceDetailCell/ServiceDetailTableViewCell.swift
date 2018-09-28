//
//  ServiceDetailTableViewCell.swift
//  JTSBoard
//
//  Created by jts on 18/07/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit

class ServiceDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var backView:UIView!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblValue:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
