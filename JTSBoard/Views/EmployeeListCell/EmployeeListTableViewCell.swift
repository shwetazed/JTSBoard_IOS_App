//
//  EmployeeListTableViewCell.swift
//  JTSBoard
//
//  Created by jts on 09/08/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit

class EmployeeListTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var lblPhoneNumber: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imgView.layer.cornerRadius = 10.0
        self.imgView.clipsToBounds = true
        
      
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
