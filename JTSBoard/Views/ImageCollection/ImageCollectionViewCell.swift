//
//  ImageCollectionViewCell.swift
//  JTSBoard
//
//  Created by jts on 11/09/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPostedByDate: UILabel!
    
    @IBOutlet weak var imgNoteView: UIImageView!
    
    @IBOutlet weak var imageNoteHeight: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imgNoteView.layer.cornerRadius = 5.0
        self.imgNoteView.clipsToBounds = true
        
        self.imgUser.layer.cornerRadius = 5
        self.imgUser.clipsToBounds = true
        
        // Initialization code
    }

}
