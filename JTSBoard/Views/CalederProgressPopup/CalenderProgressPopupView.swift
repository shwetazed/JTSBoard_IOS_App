//
//  CalenderProgressPopupView.swift
//  JTSBoard
//
//  Created by jts on 14/09/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit
import UICircularProgressRing

class CalenderProgressPopupView: UIView {

    @IBOutlet var view:UIView!
    @IBOutlet var btnCross:UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        
        Bundle.main.loadNibNamed("CalenderProgressPopupView", owner: self, options: nil)
        
        self.view.frame = frame
        self.addSubview(self.view)
        
        let progressRing = UICircularProgressRing(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        progressRing.maxValue = 50
        progressRing.innerRingColor = UIColor.blue
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}
