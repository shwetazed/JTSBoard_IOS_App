//
//  TermPolicyView.swift
//  JTSBoard
//
//  Created by jts on 31/08/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit

class TermPolicyView: UIView {

    @IBOutlet weak var btnAgree: UIButton!
    @IBOutlet var view:UIView!
    @IBOutlet weak var txtView: UITextView!
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        
       // if UIApplication.shared.statusBarOrientation.isPortrait == true
       // {
            Bundle.main.loadNibNamed("TermPolicyView", owner: self, options: nil)

      /*  }
        else
        {
            Bundle.main.loadNibNamed("TermPolicy~ipad", owner: self, options: nil)

        }*/
        
        self.view.layer.cornerRadius = 5.0
        self.view.clipsToBounds = true
        
        self.btnSubmit.layer.cornerRadius = 5.0
        self.btnSubmit.clipsToBounds = true
        
        self.btnCancel.layer.cornerRadius = 5.0
        self.btnCancel.clipsToBounds = true
        
        self.view.frame = frame
        self.addSubview(self.view)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
