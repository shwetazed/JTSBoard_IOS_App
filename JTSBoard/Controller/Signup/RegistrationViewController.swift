//
//  RegistrationViewController.swift
//  SalonatApp
//
//  Created by Apple on 05/04/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegistrationViewController: UIViewController, UITextFieldDelegate,WebServiceControllerDelegate {

    var userId:String!

    @IBOutlet weak var scrollView: UIScrollView!
 
    @IBOutlet weak var txtSalonaOwnerName: FloatLabelTextField!
    @IBOutlet weak var txtSalonaName: FloatLabelTextField!
    @IBOutlet weak var txtEmail: FloatLabelTextField!
    @IBOutlet weak var txtPassword: FloatLabelTextField!
    @IBOutlet weak var txtConPassword: FloatLabelTextField!
    @IBOutlet weak var txtCustomerPinNumber: FloatLabelTextField!
    @IBOutlet weak var txtEmployeePinNumber: FloatLabelTextField!

    @IBOutlet weak var txtZipCode: FloatLabelTextField!
    @IBOutlet weak var txtPrefecture: FloatLabelTextField!
    @IBOutlet weak var txtCity: FloatLabelTextField!
    @IBOutlet weak var txtStreetName: FloatLabelTextField!
    @IBOutlet weak var txtApartmentName: FloatLabelTextField!
    
    @IBOutlet weak var txtPhoneNumber: FloatLabelTextField!
    @IBOutlet weak var txtWebsiteUrl: FloatLabelTextField!
    @IBOutlet weak var txtEmployeeNumber: FloatLabelTextField!
    @IBOutlet weak var txtAdvertisement: FloatLabelTextField!
    @IBOutlet weak var txtAverageNumber: FloatLabelTextField!
    
   

    @IBOutlet weak var btnSignUp: UIButton!

    var navigation: TopNavigationView?
    var objWebServiceController: WebServiceController?
    var objSuccessRegisterViewController: SuccessRegisterViewController?

    func setNavigation() {
        
        navigation = TopNavigationView(frame: CGRect(x: 0, y: 0, width: (ConfigManager.sharedAppDelegate.window?.frame.size.width)!, height: 60), withRef: self, navController: navigationController!, vController: view)
        navigation?.lblTitle?.isHidden = false
        var mImg: UIImage? = nil
        let tImg: UIImage? = nil

        mImg = ConfigManager.filledImageFrom(source: UIImage(named: "back_arrow")!, fillColor: UIColor.white)
        navigation?.menuButton?.setImage(mImg, for: .normal)
        navigation?.menuButton?.addTarget(self, action: #selector(self.btnBackPressed), for: .touchUpInside)
        
        navigation?.btnTV?.setImage(tImg, for: .normal)
        navigation?.btnTV.titleLabel?.text = "LOGIN"
        
        navigation?.lblTitle?.text = "Sign Up"
        view.addSubview(navigation!)
        
    }
    @IBAction func btnBackPressed(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func btnSignUpAction(_ sender: UIButton) {
        
            
        if self.txtSalonaOwnerName.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_NAME, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        else if self.txtSalonaName.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_NAME, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        else if self.txtEmail.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_EMAIL, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        else if !ConfigManager.validateEmail(self.txtEmail.text!) {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_EMAIL_INVALID, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        else if self.txtPassword.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_PASSWORD, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        else if self.txtConPassword.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_CONFIRM_PASSWORD, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
       
         else if self.txtConPassword.text! != self.txtPassword.text! {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_CONFIRM_PASSWORD_NOT_MATCH, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        else if self.txtEmployeePinNumber.text?.count != 4 && (self.txtEmployeePinNumber.text?.count)! > 0{
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_MINIMUM_EMP_PIN_LENGTH, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        else if self.txtCustomerPinNumber.text?.count != 4 && (self.txtCustomerPinNumber.text?.count)! > 0{
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_MINIMUM_CUST_PIN_LENGTH, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
       /* else if self.txtEmployeePinNumber.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_EMP_PIN_NUM, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        else if self.txtEmployeePinNumber.text?.count != 4 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_MINIMUM_EMP_PIN_LENGTH, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        else if self.txtCustomerPinNumber.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_CUST_PIN_NUM, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        else if self.txtCustomerPinNumber.text?.count != 4 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_MINIMUM_CUST_PIN_LENGTH, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }*/
         else if self.txtZipCode.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_ZIPCODE, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
         }
         else if self.txtPrefecture.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_PREFECTURE, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
         }
         else if self.txtCity.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_CITY, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
         }
         else if self.txtStreetName.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_STREET_ADDRESS, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
         }
        /* else if self.txtApartmentName.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_APARTMENT_ADDRESS, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
         }*/
         else if self.txtPhoneNumber.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_PHONE_NO, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
         }
       /*  else if self.txtWebsiteUrl.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_WEBSITEURL, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
         }*/
         else if self.txtEmployeeNumber.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_EMPLOYEEID, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
         }
         else if self.txtAdvertisement.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_ADVERTISEMENT, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
         }
         else if self.txtAverageNumber.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_AVERAGE_USERS, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        self.setSignUpData()

        
    }
    func setSignUpData() {
        
        ConfigManager.showLoadingHUD(to_view: self.view)
        
        var parameters = [String : AnyObject] ()
        
        parameters["MethodName"] = "signup" as AnyObject
        parameters["email"] = self.txtEmail.text as AnyObject
        parameters["password"] = self.txtPassword.text as AnyObject
        parameters["name"] = self.txtSalonaOwnerName.text as AnyObject
        parameters["salon_name"] = self.txtSalonaName.text as AnyObject
        parameters["email"] = self.txtEmail.text as AnyObject
        parameters["zip_code"] = self.txtZipCode.text as AnyObject
        parameters["employee_pin_number"] = self.txtEmployeePinNumber.text as AnyObject
        parameters["customer_pin_number"] = self.txtCustomerPinNumber.text as AnyObject

        parameters["prefecture"] = self.txtPrefecture.text as AnyObject
        parameters["city"] = self.txtCity.text as AnyObject
        parameters["address1"] = self.txtStreetName.text as AnyObject
        parameters["address2"] = self.txtApartmentName.text as AnyObject
        parameters["tel"] = self.txtPhoneNumber.text as AnyObject
        parameters["website"] = self.txtWebsiteUrl.text as AnyObject
        parameters["advertisement"] = self.txtAdvertisement.text as AnyObject
        parameters["avr_customer"] = self.txtAverageNumber.text as AnyObject
        parameters["employee_number"] = self.txtEmployeeNumber.text as AnyObject
      
        self.objWebServiceController?.serverParameter(parameters: parameters)

       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.objWebServiceController = WebServiceController()
        self.objWebServiceController?.delegate = self

        self.navigationItem.title = "新規登録"
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 163/255, green: 125/255, blue: 30/255, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor =  UIColor.black
      
        self.btnSignUp.layer.cornerRadius = 5.0
        self.btnSignUp.clipsToBounds = true

    }
    
    // MARK: Uitextfield delegate

    func resignTextField() {
        
        self.txtEmail.resignFirstResponder()
        self.txtPassword.resignFirstResponder()
        self.txtConPassword.resignFirstResponder()
        self.txtSalonaName.resignFirstResponder()
        self.txtSalonaOwnerName.resignFirstResponder()
        self.txtStreetName.resignFirstResponder()
        self.txtZipCode.resignFirstResponder()
        self.txtPrefecture.resignFirstResponder()
        self.txtApartmentName.resignFirstResponder()
        self.txtWebsiteUrl.resignFirstResponder()
        self.txtPhoneNumber.resignFirstResponder()
        self.txtAdvertisement.resignFirstResponder()
        self.txtEmployeeNumber.resignFirstResponder()
        self.txtAverageNumber.resignFirstResponder()
        self.txtCity.resignFirstResponder()
        self.txtEmployeePinNumber.resignFirstResponder()
        self.txtCustomerPinNumber.resignFirstResponder()

    }
    
    
    func scrollView(to textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: (textField.frame.origin.y) - 25), animated: true)
        scrollView.contentSize = CGSize(width: 100, height: 200)
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
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == self.txtEmployeePinNumber || textField == self.txtCustomerPinNumber
        {
            if (textField.text?.count)! >= 4 && string != ""
            {
                return false
            }
            let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            return string == numberFiltered
            
            
        }
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
    // MARK: Webservice delegate

   
    func serviceResponse(forURl urlString: String, response: JSON) {
        
        ConfigManager.hideLoadingHUD(for_view: self.view)
        
        if !(urlString == "server_error_handle") {
            
            let status:String! = String(describing:response["status"])
            let msg:String! = String(describing:response["msg"])

            if status != nil
            {
                if status == "success"
                {
                   /* let alert = UIAlertController(title: "", message: "ご登録ありがとうございます。お客様のメールアドレスに24時間以内にアクティベーションメールをお送り致しますので、 ご確認よろしくお願い致します。", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    
                    self.dismiss(animated: true) {*/
                    
                    self.objSuccessRegisterViewController = SuccessRegisterViewController(nibName: "SuccessRegisterViewController", bundle: nil)
                    self.navigationController?.pushViewController(self.objSuccessRegisterViewController!, animated: true)
                    
                        
                       // self.navigationController?.popViewController(animated: true)
                   // }
                }
                else
                {
                
                    let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
               
            }

        }
        else {
            let alert = UIAlertController(title: "", message: "Error", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
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
