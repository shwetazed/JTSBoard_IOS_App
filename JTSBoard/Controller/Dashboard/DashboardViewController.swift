//
//  DashboardViewController.swift
//  JTSBoard
//
//  Created by jts on 10/07/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit
import SwiftyJSON
import SideMenu

class DashboardViewController: UIViewController,WebServiceControllerDelegate {

   // @IBOutlet weak var btnMyShop: UIButton!
    @IBOutlet weak var btnForm: UIButton!
    @IBOutlet weak var btnCustomerList: UIButton!
   // @IBOutlet weak var btnEmployee: UIButton!
    @IBOutlet weak var btnAttendance: UIButton!
    
    //@IBOutlet weak var btnMyShopIpad: UIButton!
    @IBOutlet weak var btnFormIpad: UIButton!
    @IBOutlet weak var btnCustomerListIpad: UIButton!
   // @IBOutlet weak var btnEmployeeIpad: UIButton!
    @IBOutlet weak var btnAttendanceIpad: UIButton!
    
    @IBOutlet weak var scrollPortrait: UIScrollView!
    @IBOutlet weak var scrollLandscape: UIScrollView!
    @IBOutlet weak var viewLandscape: UIView!
    @IBOutlet weak var viewPortrait: UIView!
    var objWebServiceController: WebServiceController?

    var customerDic = [String:Any]()

    var objMainFromViewController: MainFromViewController?
    var objCustomerListViewController: CustomerListViewController?
    var objSalonProfileViewController: SalonProfileViewController?
    var objEmployeeListViewController: EmployeeListViewController?
    var objAttendanceViewController: AttendanceViewController?
    var objSideMenuViewController: SideMenuViewController?
    var objCalenderViewController: CalenderViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupSideMenu()

        self.view.addSubview(self.viewPortrait)
        self.view.addSubview(self.viewLandscape)
              
        self.objWebServiceController = WebServiceController()
        self.objWebServiceController?.delegate = self
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 163/255, green: 125/255, blue: 30/255, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor =  UIColor.black

      //  self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "ログアウト", style: UIBarButtonItemStyle.done, target: self, action: #selector(btnLogoutAction))
        
        self.setLayout()

       // NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)

        // Do any additional setup after loading the view.
        let menuButton = UIButton(type: .custom)
        menuButton.setImage(UIImage(named: "menu"), for: .normal) // Image can be downloaded from here below link
        menuButton.setTitle("", for: .normal)
        menuButton.addTarget(self, action: #selector(DashboardViewController.btnMenuAction), for: .touchUpInside)
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
  
    // Mark - Set up side menu
    
    fileprivate func setupSideMenu() {
        // Define the menus
        
        if SideMenuManager.default.menuLeftNavigationController == nil
        {
            self.objSideMenuViewController = SideMenuViewController()
            let sideNavigationController = UISideMenuNavigationController(rootViewController: self.objSideMenuViewController!)
            
            SideMenuManager.default.menuLeftNavigationController = sideNavigationController
            
            
            // SideMenuManager.default.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
            // SideMenuManager.default.menuRightNavigationController = storyboard!.instantiateViewController(withIdentifier: "RightMenuNavigationController") as? UISideMenuNavigationController
            
            // Enable gestures. The left and/or right menus must be set up above for these to work.
            // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
            SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
            SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
            SideMenuManager.default.menuAddPanGestureToPresent(toView: self.view)
        }
        
       

        // Set up a cool background image for demo purposes
        //SideMenuManager.default.menuAnimationBackgroundColor = UIColor(patternImage: UIImage(named: "background")!)
    }
   /* fileprivate func setDefaults() {
        let modes:[SideMenuManager.MenuPresentMode] = [.menuSlideIn, .viewSlideOut, .menuDissolveIn]
        presentModeSegmentedControl.selectedSegmentIndex = modes.index(of: SideMenuManager.default.menuPresentMode)!
        
        let styles:[UIBlurEffectStyle] = [.dark, .light, .extraLight]
        if let menuBlurEffectStyle = SideMenuManager.default.menuBlurEffectStyle {
            blurSegmentControl.selectedSegmentIndex = styles.index(of: menuBlurEffectStyle) ?? 0
        } else {
            blurSegmentControl.selectedSegmentIndex = 0
        }
        
        darknessSlider.value = Float(SideMenuManager.default.menuAnimationFadeStrength)
        shadowOpacitySlider.value = Float(SideMenuManager.default.menuShadowOpacity)
        shrinkFactorSlider.value = Float(SideMenuManager.default.menuAnimationTransformScaleFactor)
        screenWidthSlider.value = Float(SideMenuManager.default.menuWidth / view.frame.width)
        blackOutStatusBar.isOn = SideMenuManager.default.menuFadeStatusBar
    }*/
    
    @objc func btnMenuAction()
    {
        let center = NotificationCenter.default

        center.post(name: Notification.Name("reload_notification"), object: nil, userInfo: nil)

        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)

    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.viewLandscape.frame = self.view.frame
        self.viewPortrait.frame = self.view.frame
        
        if UIApplication.shared.statusBarOrientation.isPortrait == true
        {
            self.viewPortrait.isHidden = false
            self.viewLandscape.isHidden = true
        }
        else
        {
            self.viewPortrait.isHidden = true
            self.viewLandscape.isHidden = false
        }
        
        self.scrollPortrait.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        self.scrollLandscape.setContentOffset(CGPoint(x: 0, y: 0), animated: true)

        

    }
    func setLayout()
    {
        //self.btnMyShop.layer.cornerRadius = 10.0
        //self.btnMyShop.clipsToBounds = true
        
        self.btnForm.layer.cornerRadius = 10.0
        self.btnForm.clipsToBounds = true
        
        self.btnCustomerList.layer.cornerRadius = 10.0
        self.btnCustomerList.clipsToBounds = true
        
       // self.btnEmployee.layer.cornerRadius = 10.0
       // self.btnEmployee.clipsToBounds = true
        
        self.btnAttendance.layer.cornerRadius = 10.0
        self.btnAttendance.clipsToBounds = true
        self.btnAttendance.layer.borderColor = (UIColor(red: 184/255, green: 134/255, blue: 30/255, alpha: 1.0)).cgColor
        self.btnAttendance.layer.borderWidth = 1.0
        
       // self.btnMyShopIpad.layer.cornerRadius = 10.0
       // self.btnMyShopIpad.clipsToBounds = true

        self.btnFormIpad.layer.cornerRadius = 10.0
        self.btnFormIpad.clipsToBounds = true

        self.btnCustomerListIpad.layer.cornerRadius = 10.0
        self.btnCustomerListIpad.clipsToBounds = true

       // self.btnEmployeeIpad.layer.cornerRadius = 10.0
        //self.btnEmployeeIpad.clipsToBounds = true

        self.btnAttendanceIpad.layer.cornerRadius = 10.0
        self.btnAttendanceIpad.clipsToBounds = true
        self.btnAttendanceIpad.layer.borderColor = (UIColor(red: 184/255, green: 134/255, blue: 30/255, alpha: 1.0)).cgColor
        self.btnAttendanceIpad.layer.borderWidth = 1.0
    }
    
  
    @IBAction func btnFormAction(_ sender: UIButton) {
        
        ConfigManager.isFromNote = false
        
       /* let titlePrompt = UIAlertController(title: "JTS",
                                            message: "電話番号を入力してください",
                                            preferredStyle: .alert)
        
        var titleTextField: UITextField?
        titlePrompt.addTextField { (textField) -> Void in
            titleTextField = textField
            textField.placeholder = "電話"
            textField.keyboardType = .phonePad
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル.", style: .default, handler: nil)
        
        titlePrompt.addAction(cancelAction)
        
        titlePrompt.addAction(UIAlertAction(title: "提出する", style: .destructive, handler: { (action) -> Void in
            if let textField = titleTextField {
                
                self.getFormDetail(phoneNumber: textField.text!)
                
                
            }
        }))
        self.present(titlePrompt, animated: true, completion: nil)*/
        
        self.objMainFromViewController = MainFromViewController(nibName: "MainFromViewController", bundle: nil)
        self.objMainFromViewController?.customerDic = self.customerDic
        self.navigationController?.pushViewController(self.objMainFromViewController!, animated: true)

    }
    func getFormDetail(phoneNumber : String)
    {
        
        ConfigManager.showLoadingHUD(to_view: self.view)
        
        var parameters = [String : AnyObject] ()
                
        parameters["MethodName"] = "customer_check" as AnyObject
        parameters["tel"] = phoneNumber as AnyObject
        parameters["user_id"] = ConfigManager.gUserId as AnyObject
        
        self.objWebServiceController?.serverParameter(parameters: parameters)
    }
    @IBAction func btnCustomerListAction(_ sender: UIButton) {
        
        self.objCustomerListViewController = CustomerListViewController(nibName: "CustomerListViewController", bundle: nil)
        self.navigationController?.pushViewController(self.objCustomerListViewController!, animated: true)
        
       //self.objCalenderViewController = CalenderViewController(nibName: "CalenderViewController", bundle: nil)
       // self.navigationController?.pushViewController(self.objCalenderViewController!, animated: true)
        
    }
  
    
    @IBAction func btnAttendanceAction(_ sender: UIButton) {
        
        let titlePrompt = UIAlertController(title: "出席",
                                            message: "従業員コードを入力してください",
                                            preferredStyle: .alert)
        
        var titleTextField: UITextField?
        titlePrompt.addTextField { (textField) -> Void in
            titleTextField = textField
            textField.placeholder = "従業員コード"
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .default, handler: nil)
        
        titlePrompt.addAction(cancelAction)
        
        titlePrompt.addAction(UIAlertAction(title: "送信", style: .destructive, handler: { (action) -> Void in
            if let textField = titleTextField {
               
                self.checkAttandanceStatus(empCode: textField.text!)
                
              
            }
        }))
        
        self.present(titlePrompt, animated: true, completion: nil)
        
        
    }
    func checkAttandanceStatus(empCode : String)
    {
        ConfigManager.showLoadingHUD(to_view: self.view)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateStr:String! = formatter.string(from: Date())
        
        
        var parameters = [String : AnyObject] ()
        
        parameters["MethodName"] = "attendance_status" as AnyObject
        parameters["emp_code"] = empCode as AnyObject
        parameters["user_id"] = ConfigManager.gUserId as AnyObject
        parameters["date"] = dateStr as AnyObject

        self.objWebServiceController?.serverParameter(parameters: parameters)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
            
            self.viewLandscape.isHidden = false
            self.viewPortrait.isHidden = true
            self.viewLandscape.frame = self.view.frame

            
        } else {
            print("Portrait")
            self.viewPortrait.frame = self.view.frame

            self.viewLandscape.isHidden = true
            self.viewPortrait.isHidden = false

        }
    }
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        var text=""
        switch UIDevice.current.orientation{
        case .portrait:
            text="Portrait"
        case .portraitUpsideDown:
            text="PortraitUpsideDown"
        case .landscapeLeft:
            text="LandscapeLeft"
        case .landscapeRight:
            text="LandscapeRight"
        default:
            text="Another"
        }
        NSLog("You have moved: \(text)")
    }
    
    func serviceResponse(forURl urlString: String, response: JSON) {
        
        ConfigManager.hideLoadingHUD(for_view: self.view)
        
        if !(urlString == "server_error_handle") {
            
            if urlString == "attendance_status"
            {
                let status:String! = String(describing:response["status"])
                let msg:String! = String(describing:response["msg"])
                let attendance_status:String! = String(describing:response["attendance_status"])
                let emp_code:String! = String(describing:response["emp_code"])

                if status == "success"
                {
                    
                    if attendance_status == "1" || attendance_status == "2"
                    {
                        self.objAttendanceViewController = AttendanceViewController(nibName: "AttendanceViewController", bundle: nil)
                        self.objAttendanceViewController?.empCode = emp_code
                        self.objAttendanceViewController?.checkinStatus = attendance_status
                        self.navigationController?.pushViewController(self.objAttendanceViewController!, animated: true)

                    }
                    else
                    {
                        let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                    
                   
                }
                else
                {
                    let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
                
                
               
                
                //self.navigationController?.popViewController(animated: true)
            }
            else if (urlString == "customer_check") {
                
                let dic = response["Customer"].dictionaryObject
                
                if dic != nil
                {
                    self.customerDic = dic!
                    
                }
                self.objMainFromViewController = MainFromViewController(nibName: "MainFromViewController", bundle: nil)
                self.objMainFromViewController?.customerDic = self.customerDic
                self.navigationController?.pushViewController(self.objMainFromViewController!, animated: true)
                
                
                
            }
        }
        else {
            let alert = UIAlertController(title: "", message: "Error", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    func serviceImageResponse(forURl urlString: String, response: NSDictionary) {
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        self.viewPortrait = nil
        self.viewLandscape = nil
        self.view = nil
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
extension DashboardViewController: UISideMenuNavigationControllerDelegate {
    
    func sideMenuWillAppear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Appearing! (animated: \(animated))")
    }
    
    func sideMenuDidAppear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Appeared! (animated: \(animated))")
    }
    
    func sideMenuWillDisappear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappearing! (animated: \(animated))")
    }
    
    func sideMenuDidDisappear(menu: UISideMenuNavigationController, animated: Bool) {
        print("SideMenu Disappeared! (animated: \(animated))")
    }
    
}
