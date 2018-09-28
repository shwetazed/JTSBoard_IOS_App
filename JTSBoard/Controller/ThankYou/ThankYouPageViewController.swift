//
//  ThankYouPageViewController.swift
//  JTSBoard
//
//  Created by jts on 11/07/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit

class ThankYouPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let backbutton = UIButton(type: .custom)
        backbutton.setImage(UIImage(named: "back_icon"), for: .normal) // Image can be downloaded from here below link
        backbutton.setTitle("Back", for: .normal)
        backbutton.addTarget(self, action: #selector(TermsViewController.btnBackAction), for: .touchUpInside)
        backbutton.setTitleColor(UIColor.black, for: .normal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
        
        // Do any additional setup after loading the view.
    }
    @objc func btnBackAction()
    {
        if ConfigManager.isFromNote == true {
            
            let controllers = self.navigationController?.viewControllers
            for vc in controllers! {
                if vc is AddNoteViewController {
                    _ = self.navigationController?.popToViewController(vc as! AddNoteViewController, animated: true)
                }
            }
        }
        else
        {
            self.navigationController?.popToRootViewController(animated: true)

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
