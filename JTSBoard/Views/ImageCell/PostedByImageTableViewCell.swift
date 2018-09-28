//
//  PostedByImageTableViewCell.swift
//  JTSBoard
//
//  Created by jts on 12/09/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit

class PostedByImageTableViewCell: UITableViewCell {

    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPostedBy: UILabel!
    
    @IBOutlet weak var imgNoteView: UIImageView!
    
    @IBOutlet weak var imageNoteHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imgUser.layer.cornerRadius = 5
        self.imgUser.clipsToBounds = true
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
