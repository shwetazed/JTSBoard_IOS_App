//
//  JTSStaffDashboardViewController.swift
//  JTSBoard
//
//  Created by jts on 07/09/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit
import SideMenu

class JTSStaffDashboardViewController: UIViewController {

    @IBOutlet weak var btnCustomerList: UIButton!
    
    var objCustomerListViewController:CustomerListViewController!
    var objAddEmployeeViewController:AddEmployeeViewController!
    var objSideMenuViewController: SideMenuViewController?
    var objJTSStaffCalenderViewController: JTSStaffCalenderViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
        
        self.btnCustomerList.layer.cornerRadius = 10.0
        self.btnCustomerList.clipsToBounds = true
        
        self.setupSideMenu()
        
        let menuButton = UIButton(type: .custom)
        menuButton.setImage(UIImage(named: "menu"), for: .normal) // Image can be downloaded from here below link
        menuButton.setTitle("", for: .normal)
        menuButton.addTarget(self, action: #selector(self.btnMenuAction), for: .touchUpInside)
        menuButton.setTitleColor(UIColor.black, for: .normal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.logout(_:)), name: NSNotification.Name(rawValue: "logout_notification"), object: nil)

        // Do any additional setup after loading the view.
    }
    @objc func logout(_ notificationInfo: Notification)
    {
        let alert = UIAlertController(title: "", message: "ログアウトしますか？", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: logoutAction))
        alert.addAction(UIAlertAction(title: "NO", style: .default, handler: nil))
        
        self.present(alert, animated: true)
        //self.perform(#selector(logoutFromView), with: nil, afterDelay: 0.2)
    }
    func logoutAction(action: UIAlertAction) {
        //Use action.title
        
        self.objSideMenuViewController = nil
        SideMenuManager.default.menuLeftNavigationController = nil
        
        ConfigManager.sharedAppDelegate.logoutFromApp()
        
    }
    @IBAction func btnCustomerListAction(_ sender: Any) {
        
       self.objCustomerListViewController = CustomerListViewController(nibName: "CustomerListViewController", bundle: nil)
        self.navigationController?.pushViewController(self.objCustomerListViewController!, animated: true)
        
       // self.objJTSStaffCalenderViewController = JTSStaffCalenderViewController(nibName: "JTSStaffCalenderViewController", bundle: nil)
       // self.navigationController?.pushViewController(self.objJTSStaffCalenderViewController!, animated: true)
    }
    fileprivate func setupSideMenu() {
        // Define the menus
        
        if SideMenuManager.default.menuLeftNavigationController == nil
        {
            self.objSideMenuViewController = SideMenuViewController()
            let sideNavigationController = UISideMenuNavigationController(rootViewController: self.objSideMenuViewController!)
            
            SideMenuManager.default.menuLeftNavigationController = sideNavigationController
            
            SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
            SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
            SideMenuManager.default.menuAddPanGestureToPresent(toView: self.view)
        }
        
    }
        
    @objc func btnMenuAction()
    {
        let center = NotificationCenter.default
        center.post(name: Notification.Name("reload_notification"), object: nil, userInfo: nil)
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
            
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
