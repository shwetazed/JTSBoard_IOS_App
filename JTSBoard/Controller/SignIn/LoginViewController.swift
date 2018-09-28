//
//  LoginViewController.swift
//  SalonatApp
//
//  Created by Apple on 05/04/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import SwiftyJSON


class LoginViewController: UIViewController, UITextFieldDelegate,WebServiceControllerDelegate {

    var socialDic = [String : String] ()
    var checkForgotAlert : String!
    var checkLoginType : String!
    var checkLoginCount : Int!

    @IBOutlet weak var imgIpadLogo: UIImageView!
    @IBOutlet weak var imgIphoneLogo: UIImageView!
    
    @IBOutlet weak var txtEmail: FloatLabelTextField!
    @IBOutlet weak var txtPass: FloatLabelTextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btnSignUp: UIButton!
    
    @IBOutlet weak var txtEmailLandscape: FloatLabelTextField!
    @IBOutlet weak var txtPassLandscape: FloatLabelTextField!
    @IBOutlet weak var btnLoginLandscape: UIButton!
    @IBOutlet weak var scrollViewLandscape: UIScrollView!
    @IBOutlet weak var btnSignUpLandscape: UIButton!
    
    @IBOutlet weak var viewLandscape: UIView!
    @IBOutlet weak var viewPortrait: UIView!

    var isPortrait: Bool!

    var objRegistrationViewController : RegistrationViewController?
    var objDashboardViewController : DashboardViewController?
    var objCustomerListViewController : CustomerListViewController?

    var objWebServiceController: WebServiceController?

    var navigation: TopNavigationView?
    
    func setNavigation() {
        
        if ConfigManager.DeviceType.IS_IPHONE_X {
            
            navigation = TopNavigationView(frame: CGRect(x: 0, y: 0, width: (ConfigManager.sharedAppDelegate.window?.frame.size.width)!, height: 80), withRef: self, navController: navigationController!, vController: view)

        }
        else
        {
            navigation = TopNavigationView(frame: CGRect(x: 0, y: 0, width: (ConfigManager.sharedAppDelegate.window?.frame.size.width)!, height: 60), withRef: self, navController: navigationController!, vController: view)

        }
        navigation?.lblTitle?.isHidden = false
                
        var mImg: UIImage? = nil
        
        mImg = ConfigManager.filledImageFrom(source: UIImage(named: "back_arrow")!, fillColor: UIColor.white)
        navigation?.menuButton?.setImage(mImg, for: .normal)
        navigation?.menuButton?.addTarget(self, action: #selector(self.btnBackPressed), for: .touchUpInside)
        
        navigation?.btnTV?.isHidden = true
        navigation?.menuButton?.isHidden = true


        view.addSubview(navigation!)
        
       
        
    }
    @IBAction func btnBackPressed(_ sender: Any) {
        
        if ConfigManager.isLoginAtStart == false
        {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    @IBAction func btnSkipPressed(_ sender: Any) {
        
        ConfigManager.isSkip = true
       // ConfigManager.sharedAppDelegate.createMenuView()
    }
    @IBAction func btnLoginAction(_ sender: UIButton) {
        
        //ConfigManager.sharedAppDelegate.createMenuView()

        if self.isPortrait == true {
            
            if self.txtEmail.text?.count == 0 {
                
                let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_EMAIL, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                return
            }
                
            else if self.txtPass.text?.count == 0 {
                
                let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_PASSWORD, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                return
            }
            
            setLoginData(self.txtEmail.text!, password: self.txtPass.text!)

        }
        else
        {
            if self.txtEmailLandscape.text?.count == 0 {
                
                let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_EMAIL, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                return
            }
                
            else if self.txtPassLandscape.text?.count == 0 {
                
                let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_PASSWORD, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                return
            }
            
            setLoginData(self.txtEmailLandscape.text!, password: self.txtPassLandscape.text!)

        }
        
    }
    
    func setLoginData(_ email: String, password: String) {
        
        ConfigManager.showLoadingHUD(to_view: self.view)
        var parameters = [String : AnyObject] ()
        parameters["email"] = email as AnyObject
        parameters["password"] = password as AnyObject
        parameters["MethodName"] = "login" as AnyObject
       
        self.objWebServiceController?.serverParameter(parameters: parameters)

    }
   
    
   
    @IBAction func btnSignUpAction(_ sender: UIButton) {
        
        self.objRegistrationViewController = RegistrationViewController(nibName: "RegistrationViewController", bundle: nil)
        self.navigationController?.pushViewController(self.objRegistrationViewController!, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.viewPortrait)
        self.view.addSubview(self.viewLandscape)
        
        self.navigationItem.title = "ログイン"
        
        self.navigationController?.navigationBar.tintColor = UIColor.black
        
        self.btnLogin.layer.cornerRadius = 5.0
        self.btnLogin.clipsToBounds = true

        self.btnSignUp.layer.cornerRadius = 5.0
        self.btnSignUp.clipsToBounds = true
        
        self.btnLoginLandscape.layer.cornerRadius = 5.0
        self.btnLoginLandscape.clipsToBounds = true
        
        self.btnSignUpLandscape.layer.cornerRadius = 5.0
        self.btnSignUpLandscape.clipsToBounds = true

        self.objWebServiceController = WebServiceController()
        self.objWebServiceController?.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTapFrom))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        //AD7D1E
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 163/255, green: 125/255, blue: 30/255, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor =  UIColor(red: 163/255, green: 125/255, blue: 30/255, alpha: 1.0)

        self.setValuesFromUserDefaults()
        
        print(ConfigManager.gUserId!)
        
//        let jstStaffButton = UIButton(type: .custom)
//       // jstStaffButton.setImage(UIImage(named: "add_holiday_icon"), for: .normal) // Image can be downloaded from here below link
//        jstStaffButton.setTitle("JTSStaff", for: .normal)
//        jstStaffButton.addTarget(self, action: #selector(self.btnJtsStaffAction), for: .touchUpInside)
//        jstStaffButton.setTitleColor(UIColor.black, for: .normal)
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: jstStaffButton)

    }
    @objc func btnJtsStaffAction()
    {
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
                
                ConfigManager.showLoadingHUD(to_view: self.view)
                
                var parameters = [String : AnyObject] ()
                
                parameters["MethodName"] = "get_user_id" as AnyObject
                parameters["emp_code"] = textField.text as AnyObject
                
                self.objWebServiceController?.serverParameter(parameters: parameters)
                
            }
        }))
        
        self.present(titlePrompt, animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
       
        self.viewLandscape.frame = self.view.frame
        self.viewPortrait.frame = self.view.frame
        
        if UIApplication.shared.statusBarOrientation.isPortrait == true
        {
            self.viewPortrait.isHidden = false
            self.viewLandscape.isHidden = true
            
            self.isPortrait = true
        }
        else
        {
            self.viewPortrait.isHidden = true
            self.viewLandscape.isHidden = false
            
            self.isPortrait = false
            
        }
    }
    
    func setValuesFromUserDefaults()
    {
       
        if UserDefaults.standard.object(forKey: "USERID") != nil {
            
            if UserDefaults.standard.object(forKey: "EMAIL") != nil {
                
                ConfigManager.gEmail = UserDefaults.standard.object(forKey: "EMAIL") as! String
                
            }
            if UserDefaults.standard.object(forKey: "EMP_PIN_NUM") != nil {
                
                ConfigManager.gEmployeePinNumber = UserDefaults.standard.object(forKey: "EMP_PIN_NUM") as! String
                
            }
            if UserDefaults.standard.object(forKey: "CUST_PIN_NUM") != nil {
                
                ConfigManager.gCustomerPinNumber = UserDefaults.standard.object(forKey: "CUST_PIN_NUM") as! String
                
            }
            if UserDefaults.standard.object(forKey: "EMP_ID") != nil {
                
                ConfigManager.gEmployeeId = UserDefaults.standard.object(forKey: "EMP_ID") as! String
                
            }
            if UserDefaults.standard.object(forKey: "EMP_NAME") != nil {
                
                ConfigManager.gEmployeeName = UserDefaults.standard.object(forKey: "EMP_NAME") as! String
                
            }
            if UserDefaults.standard.object(forKey: "EMP_IMAGE") != nil {
                
                ConfigManager.gEmployeeImage = UserDefaults.standard.object(forKey: "EMP_IMAGE") as! String
                
            }
            ConfigManager.gUserId = UserDefaults.standard.object(forKey: "USERID") as! String

            ConfigManager.sharedAppDelegate.setLandingPage()
          
            
        }
       
       
        
      
    }
    
    
    @objc func handleTapFrom(recognizer : UITapGestureRecognizer ) {
        
       
    }
   
    
    // MARK: ------------Delegate-----------------
    // MARK: TextFieldDelegate
    
    func resignTextField() {
      
        self.txtEmail.resignFirstResponder()
        self.txtPass.resignFirstResponder()
        self.txtEmailLandscape.resignFirstResponder()
        self.txtPassLandscape.resignFirstResponder()

        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        self.scrollViewLandscape.setContentOffset(CGPoint(x: 0, y: 0), animated: true)

    }
    

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    func scrollView(toCenterOfScreen theView: UIView, textfield: UITextField) {
        let viewCenterY: CGFloat = theView.center.y
        let applicationFrame: CGRect = UIScreen.main.bounds
        var availableHeight: CGFloat
        availableHeight = applicationFrame.size.height - 150
       
        var y: CGFloat = viewCenterY - availableHeight / 2.0
        if y < 0 {
            y = 0
        }
        if self.isPortrait == true {

            scrollView.setContentOffset(CGPoint(x: 0, y: y), animated: true)
            
        }
        else
        {
            scrollViewLandscape.setContentOffset(CGPoint(x: 0, y: y+70), animated: true)

        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        scrollView(toCenterOfScreen: textField, textfield: textField)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
     
            textField.resignFirstResponder()
            UIView.beginAnimations("anim", context: nil)
            UIView.setAnimationBeginsFromCurrentState(true)
            UIView.setAnimationDuration(0.25)
       
        if self.isPortrait == true {
            
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)

        }
        else
        {
            scrollViewLandscape.setContentOffset(CGPoint(x: 0, y: 0), animated: true)

        }
        
        UIView.commitAnimations()
        return true
    }
   
    // MARK: Webservice delegate

   
    func serviceResponse(forURl urlString: String, response: JSON) {
        
        ConfigManager.hideLoadingHUD(for_view: self.view)
        
        if !(urlString == "server_error_handle") {
            
            if urlString == "get_user_id"
            {
                if let resData = response["Employee"].dictionaryObject {
                    
                    let status:String! = String(describing:resData["status"]!)
                    let msg:String! = String(describing:resData["msg"]!)
                    
                    if status == "success"
                    {
                        ConfigManager.gUserId = resData["user_id"] as! String
                                                
                        self.objCustomerListViewController = CustomerListViewController()
                        self.navigationController?.pushViewController(self.objCustomerListViewController!, animated: true)
                    }
                    else
                    {
                        let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                    
                }
                
                
            }
            else
            {
                let status:String! = String(describing:response["status"])
                let msg:String! = String(describing:response["msg"])
                
                if status != nil
                {
                    if status == "error"
                    {
                        self.txtEmail.text = ""
                        self.txtPass.text = ""
                        self.txtEmailLandscape.text = ""
                        self.txtPassLandscape.text = ""

                        let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true)
                        
                    }
                    else
                    {
                        let userId:String! = String(describing:response["user_id"])
                        let isForm:String! = String(describing:response["is_form"])
                        let empPinNum:String! = String(describing:response["employee_pin_number"])
                        let custPinNum:String! = String(describing:response["customer_pin_number"])
                        
                        let isAdmin:String! = String(describing:response["is_admin"])
                        let employee_id:String! = String(describing:response["employee_id"])
                        let employee_name:String! = String(describing:response["employee_name"])
                        let employee_image:String! = String(describing:response["employee_image"])
                      
                        
                        if userId != nil
                        {
                            
                            ConfigManager.gUserId = userId!
                            ConfigManager.gFormNumber = isForm!
                            
                            if self.isPortrait == true
                            {
                                ConfigManager.gEmail = self.txtEmail.text!
                                
                            }
                            else
                            {
                                ConfigManager.gEmail = self.txtEmailLandscape.text!
                                
                            }
                            ConfigManager.gIsAdmin = isAdmin
                            ConfigManager.gEmployeePinNumber = empPinNum
                            ConfigManager.gCustomerPinNumber = custPinNum
                            ConfigManager.gEmployeeId = employee_id
                            ConfigManager.gEmployeeName = employee_name
                            ConfigManager.gEmployeeImage = employee_image

                            
                            UserDefaults.standard.set(ConfigManager.gUserId, forKey: "USERID")
                            UserDefaults.standard.set(ConfigManager.gFormNumber, forKey: "FORMNUM")
                            UserDefaults.standard.set(ConfigManager.gEmail, forKey: "EMAIL")
                            UserDefaults.standard.set(ConfigManager.gIsAdmin, forKey: "ISADMIN")
                            UserDefaults.standard.set(ConfigManager.gEmployeePinNumber, forKey: "EMP_PIN_NUM")
                            UserDefaults.standard.set(ConfigManager.gCustomerPinNumber, forKey: "CUST_PIN_NUM")
                            UserDefaults.standard.set(ConfigManager.gEmployeeId, forKey: "EMP_ID")
                            UserDefaults.standard.set(ConfigManager.gEmployeeName, forKey: "EMP_NAME")
                            UserDefaults.standard.set(ConfigManager.gEmployeeImage, forKey: "EMP_IMAGE")

                            ConfigManager.sharedAppDelegate.setLandingPage()
                            
                            //self.objDashboardViewController = DashboardViewController(nibName: "DashboardViewController", bundle: nil)
                            //self.navigationController?.pushViewController(self.objDashboardViewController!, animated: true)
                            
                            self.txtEmail.text = ""
                            self.txtPass.text = ""
                            self.txtEmailLandscape.text = ""
                            self.txtPassLandscape.text = ""
                        }
                        
                        
                    }
            }
           
                
            }
            
        }
        else {
            let alert = UIAlertController(title: "", message: "Error", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
            
            self.viewLandscape.isHidden = false
            self.viewPortrait.isHidden = true
            self.viewLandscape.frame = self.view.frame
            
            self.isPortrait = false
            
            self.txtEmailLandscape.text = self.txtEmail.text
            self.txtPassLandscape.text = self.txtPass.text

            self.resignTextField()
            
            
        } else {
            print("Portrait")
            self.viewPortrait.frame = self.view.frame
            
            self.viewLandscape.isHidden = true
            self.viewPortrait.isHidden = false
            
            self.isPortrait = true
            
            self.txtEmail.text = self.txtEmailLandscape.text
            self.txtPass.text = self.txtPassLandscape.text
            
            
            self.resignTextField()

            
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func serviceImageResponse(forURl urlString: String, response: NSDictionary) {
        
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
