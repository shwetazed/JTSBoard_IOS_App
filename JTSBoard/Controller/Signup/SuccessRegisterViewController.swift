//
//  SuccessRegisterViewController.swift
//  JTSBoard
//
//  Created by jts on 12/07/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit

class SuccessRegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "ログイン", style: UIBarButtonItemStyle.done, target: self, action: #selector(btnLoginAction))

        // Do any additional setup after loading the view.
    }
    @objc func btnLoginAction()
    {
        self.navigationController?.popToRootViewController(animated: true)
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
