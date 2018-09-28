//
//  AddServiceTableViewCell.swift
//  JTSBoard
//
//  Created by jts on 02/08/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit

class AddServiceTableViewCell: UITableViewCell {

    @IBOutlet weak var txtServiceName: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var txtPaymentType: UITextField!
    @IBOutlet weak var btnFormHeight: NSLayoutConstraint!
    
    @IBOutlet weak var btnForm: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
