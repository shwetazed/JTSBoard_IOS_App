











//
//  TopNavigationView.swift
//  VoyllaSwift
//
//  Created by Voylla Mac on 05/04/16.
//  Copyright © 2016 Voylla Mac. All rights reserved.
//

import UIKit
import CoreGraphics
import Foundation

@objc protocol TopNavigationViewDelegate
{
    //@objc optional func leftBarButtonDidClicked(_ sender:AnyObject)
    //@objc optional func rightBarButtonDidClicked(_ sender:AnyObject)
    
}

class TopNavigationView: UIView {
    
    @IBOutlet weak var btnDone: UIButton!
    
    var objNavController: UINavigationController?
    var mView: UIView!
    var view: UIView?
    @IBOutlet weak var backNavigationImgView: UIImageView?

    var cMgr: ConfigManager? = ConfigManager()
    
    @IBOutlet weak var btnMap: UIButton!
    @IBOutlet weak var menuButton: UIButton?
    @IBOutlet weak var lblTitle: UILabel?
    @IBOutlet weak var btnTV: UIButton!
    @IBAction func btnTVAction(_ sender: UIButton) {
    }
    
    var delegate: TopNavigationViewDelegate?
   
    
    
    init(frame: CGRect, withRef ref: Any, navController nController: UINavigationController, vController: UIView) {
    
        super.init(frame: frame)
        
        xibSetup()
        
        self.objNavController = nController;
        self.mView = vController;
        
    }
    
    class func instanceFromNib() -> UIView {
        
        return UINib(nibName: "TopNavigationView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        
        //  fatalError("init(coder:) has not been implemented")
    }
    
    func xibSetup() {
        
        view = loadViewFromNib()
        view?.frame = bounds
        view?.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view!)
        lblTitle?.textColor = UIColor.white
        addSubview(view!)
        view?.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
       
              
       

    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "TopNavigationView", bundle: bundle)
        let cView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        return cView;
    }
    
}
