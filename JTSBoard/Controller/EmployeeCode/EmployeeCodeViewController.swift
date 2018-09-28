//
//  EmployeeCodeViewController.swift
//  JTSStaff
//
//  Created by Japan Techno Solutions on 27/08/18.
//  Copyright © 2018 Japan Techno Solutions. All rights reserved.
//

import UIKit
import SwiftyJSON

class EmployeeCodeViewController: UIViewController,UITextFieldDelegate,WebServiceControllerDelegate {

    var objWebServiceController: WebServiceController?
    var objCustomerListViewController: CustomerListViewController?
    var objJTSStaffDashboardViewController: JTSStaffDashboardViewController?

    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var txtEmployeeCode: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.black

        self.objWebServiceController = WebServiceController()
        self.objWebServiceController?.delegate = self
        
        self.btnSubmit.layer.cornerRadius = 5.0
        self.btnSubmit.clipsToBounds = true
        
        if UserDefaults.standard.object(forKey: "USERID") != nil {
            
            ConfigManager.gUserId = UserDefaults.standard.object(forKey: "USERID") as! String
            
            if UserDefaults.standard.object(forKey: "EMP_ROLE") != nil {

                ConfigManager.gEmployeeRole = UserDefaults.standard.object(forKey: "EMP_ROLE") as! String

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
            self.objJTSStaffDashboardViewController = JTSStaffDashboardViewController(nibName: "JTSStaffDashboardViewController", bundle: nil)
            
            self.navigationController?.pushViewController(self.objJTSStaffDashboardViewController!, animated: true)

            
        }
        if ConfigManager.IS_IPHONE()
        {
            if UIApplication.shared.statusBarOrientation.isLandscape == true
            {
                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                
            }
        }
     
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if ConfigManager.IS_IPHONE()
        {
            AppUtility.lockOrientation(.portrait)

        }
        // Or to rotate and lock
        // AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Don't forget to reset when view is being removed
        if ConfigManager.IS_IPHONE()
        {
            AppUtility.lockOrientation(.portrait)

        }
    }
    @IBAction func btnSubmitAction(_ sender: Any) {
        
        if self.txtEmployeeCode.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: "従業員コードを入力してください", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        ConfigManager.showLoadingHUD(to_view: self.view)
        
        var parameters = [String : AnyObject] ()
        
        parameters["MethodName"] = "get_user_id" as AnyObject
        parameters["emp_code"] = self.txtEmployeeCode.text as AnyObject
        parameters["device_token"] = ConfigManager.gDeviceToken as AnyObject

        self.objWebServiceController?.serverParameter(parameters: parameters)
    }
    // MARK:  Webservice Bar delegate
    
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
                            self.txtEmployeeCode.resignFirstResponder()
                            ConfigManager.gUserId = resData["user_id"] as! String
                            ConfigManager.gEmployeeRole = resData["role_id"] as! String
                            ConfigManager.gEmployeeName = resData["employee_name"] as! String
                            ConfigManager.gEmployeeImage = resData["employee_image"] as! String
                            
                            if (resData["employee_pin_number"] != nil)
                            {
                                ConfigManager.gEmployeePinNumber = String(format: "%@", resData["employee_pin_number"] as! CVarArg)

                            }
                            if (resData["customer_pin_number"] != nil)
                            {
                                ConfigManager.gCustomerPinNumber = String(format: "%@", resData["customer_pin_number"] as! CVarArg)

                            }

                            if (resData["employee_id"] != nil)
                            {
                                ConfigManager.gEmployeeId = String(format: "%@", resData["employee_id"] as! CVarArg)

                            }

                            ConfigManager.gEmployeeCode = self.txtEmployeeCode.text
                            
                            UserDefaults.standard.set(ConfigManager.gUserId, forKey: "USERID")
                            UserDefaults.standard.set(ConfigManager.gEmployeeCode, forKey: "EMP_CODE")
                            UserDefaults.standard.set(ConfigManager.gEmployeeRole, forKey: "EMP_ROLE")
                            
                            UserDefaults.standard.set(ConfigManager.gEmployeePinNumber, forKey: "EMP_PIN_NUM")
                            UserDefaults.standard.set(ConfigManager.gCustomerPinNumber, forKey: "CUST_PIN_NUM")

                            UserDefaults.standard.set(ConfigManager.gEmployeeId, forKey: "EMP_ID")
                            UserDefaults.standard.set(ConfigManager.gEmployeeName, forKey: "EMP_NAME")
                            UserDefaults.standard.set(ConfigManager.gEmployeeImage, forKey: "EMP_IMAGE")
                            
                            self.objJTSStaffDashboardViewController = JTSStaffDashboardViewController(nibName: "JTSStaffDashboardViewController", bundle: nil)
                            self.navigationController?.pushViewController(self.objJTSStaffDashboardViewController!, animated: true)

                            //self.objCustomerListViewController = CustomerListViewController()
                            //self.navigationController?.pushViewController(self.objCustomerListViewController!, animated: true)
                        }
                        else
                        {
                            let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true)
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
    func serviceImageResponse(forURl urlString: String, response: NSDictionary) {
        
    }
    // MARK: ------------Delegate-----------------
    // MARK: TextFieldDelegate
    
    func resignTextField() {
        
        self.txtEmployeeCode.resignFirstResponder()
        
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        
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
        
        scrollView.setContentOffset(CGPoint(x: 0, y: y), animated: true)
      
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
        
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
       
        
        UIView.commitAnimations()
        return true
    }
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
  
    }
    

