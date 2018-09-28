//
//  CalenderHeaderView.swift
//  JTSBoard
//
//  Created by jts on 13/09/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit

class CalenderHeaderView: UIView {
   
    @IBOutlet var view:UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        
        
        Bundle.main.loadNibNamed("CalenderHeaderView", owner: self, options: nil)
        
        self.view.frame = frame
        self.addSubview(self.view)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}
