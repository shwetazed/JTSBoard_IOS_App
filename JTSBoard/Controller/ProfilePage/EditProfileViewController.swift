//
//  EditProfileViewController.swift
//  JTSBoard
//
//  Created by jts on 23/08/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class EditProfileViewController: UIViewController,WebServiceControllerDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var txtSalonOwnerName: FloatLabelTextField!
    
    @IBOutlet weak var txtSalonatName: FloatLabelTextField!
    @IBOutlet weak var txtEmail: FloatLabelTextField!
    
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
    
    @IBOutlet weak var txtCustomerPinNumber: FloatLabelTextField!
    @IBOutlet weak var txtEmployeePinNumber: FloatLabelTextField!
    
    @IBOutlet weak var txtWeekend: FloatLabelTextField!
    @IBOutlet weak var txtStartDate: FloatLabelTextField!

    var pickerView:UIPickerView!
    
    var navigation: TopNavigationView?
    var objWebServiceController: WebServiceController?
    
    var arrWeekDaysList:NSMutableArray! = NSMutableArray()
    
    var userDic = [String:Any]()
    
    var selectedTextfield:UITextField!
    
    let btnKeypadReturn = UIButton(type: UIButtonType.custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "プロフィール"
        
        self.objWebServiceController = WebServiceController()
        self.objWebServiceController?.delegate = self
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 163/255, green: 125/255, blue: 30/255, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor =  UIColor.black
        
        self.btnUpdate.layer.cornerRadius = 5.0
        self.btnUpdate.clipsToBounds = true
        
        self.getUserProfileData()
        self.createWeekDaysArray()
        
        if ConfigManager.IS_IPHONE() {
            
            self.btnKeypadReturn.setTitle("Return", for: UIControlState())
            self.btnKeypadReturn.setTitleColor(UIColor.black, for: UIControlState())
            self.btnKeypadReturn.frame = CGRect(x: 0, y: 163, width: 106, height: 53)
            self.btnKeypadReturn.adjustsImageWhenHighlighted = false
            self.btnKeypadReturn.addTarget(self, action: #selector(self.Done(_:)), for: UIControlEvents.touchUpInside)
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        }
        
        // Do any additional setup after loading the view.
    }
    func createWeekDaysArray()
    {
        self.arrWeekDaysList.add("Sunday")
        self.arrWeekDaysList.add("Monday")
        self.arrWeekDaysList.add("Tuesday")
        self.arrWeekDaysList.add("Wednesday")
        self.arrWeekDaysList.add("Thursday")
        self.arrWeekDaysList.add("Friday")
        self.arrWeekDaysList.add("Saturday")

    }
    override func viewWillAppear(_ animated: Bool) {
        
        //self.navigationItem.setHidesBackButton(true, animated:true);
        
    }
    
   
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
    @IBAction func btnUpdateAction(_ sender: Any) {
        
        if self.txtSalonOwnerName.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_NAME, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        else if self.txtSalonatName.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_NAME, preferredStyle: .alert)
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
          
        else if self.txtPhoneNumber.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_PHONE_NO, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
          
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
        else if self.txtStartDate.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_START_DATE, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        else if (self.txtStartDate.text?.count)! >= 0 {
            
            let startDateStr:String! = self.txtStartDate.text
            
            let startDate = Int(startDateStr)
            
            if startDate! >= 31 {
                
                let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_START_DATE_LIMIT, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                return
                
            }
        }

       
        self.setUpdateProfileData()
    }
    func createServicePicker(textField:UITextField)
    {
        var alertTitle:String!
        
        alertTitle = "サービスを選択"
       
        let alertView = UIAlertController(
            title: alertTitle,
            message: "\n\n\n\n\n\n\n\n\n",
            preferredStyle: .alert)
        
        self.pickerView = UIPickerView(frame:
            CGRect(x: 0, y: 50, width: 260, height: 162))
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        
        // comment this line to use white color
        self.pickerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        
        
        alertView.view.addSubview(self.pickerView)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            //  Do some action here.
            
        textField.text =  self.arrWeekDaysList.object(at: self.pickerView.selectedRow(inComponent: 0)) as? String
                
           
        })
        
        self.pickerView.selectRow(1, inComponent: 0, animated: true)
        
        alertView.addAction(action)
        self.present(alertView, animated: true) {
            
            self.pickerView.frame.size.width = alertView.view.frame.size.width
            
            
        }
        
        
    }
    func setUpdateProfileData() {
        
        ConfigManager.showLoadingHUD(to_view: self.view)
        
        var parameters = [String : AnyObject] ()
        
        parameters["MethodName"] = "edit_profile" as AnyObject
        parameters["email"] = self.txtEmail.text as AnyObject
        parameters["name"] = self.txtSalonOwnerName.text as AnyObject
        parameters["salon_name"] = self.txtSalonatName.text as AnyObject
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
        parameters["month_start_date"] = self.txtStartDate.text as AnyObject
        parameters["weekend"] = self.txtWeekend.text as AnyObject

        parameters["user_id"] = ConfigManager.gUserId as AnyObject

        self.objWebServiceController?.serverParameter(parameters: parameters)
        
        
    }
    func getUserProfileData() {
        
        ConfigManager.showLoadingHUD(to_view: self.view)
        
        var parameters = [String : AnyObject] ()
        
        parameters["MethodName"] = "user_profile" as AnyObject
        parameters["user_id"] = ConfigManager.gUserId as AnyObject
        
        // parameters["salon_id"] = ConfigManager.gSalonId as AnyObject
        
        self.objWebServiceController?.serverParameter(parameters: parameters)
        
        
    }
    
    // MARK: Webservice delegate
    
    func serviceResponse(forURl urlString: String, response: JSON) {
        
        ConfigManager.hideLoadingHUD(for_view: self.view)
        
        if !(urlString == "server_error_handle") {
            
            if urlString == "edit_profile"
            {
                let status:String! = String(describing:response["status"])
                let msg:String! = String(describing:response["msg"])
                
                if status != nil
                {
                    if status == "success"
                    {
                         let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
                         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                         self.present(alert, animated: true)
                         
                         self.dismiss(animated: true) {
                            
                            self.navigationController?.popViewController(animated: true)
                         }
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
                let dic = response["User"].dictionaryObject
                
                if dic != nil
                {
                    self.userDic = dic!
                    self.setUserData()
                }
            }
            
            
            
            
        }
        else {
            let alert = UIAlertController(title: "", message: "Error", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    func setUserData()
    {
        self.txtSalonOwnerName.text = self.userDic["name"] as? String
        
        self.txtSalonatName.text = self.userDic["salon_name"] as? String
        self.txtEmail.text = self.userDic["email"] as? String
        self.txtZipCode.text = self.userDic["zip_code"] as? String
        self.txtPrefecture.text = self.userDic["prefecture"] as? String
        self.txtCity.text = self.userDic["city"] as? String
        self.txtStreetName.text = self.userDic["address1"] as? String
        self.txtApartmentName.text = self.userDic["address2"] as? String
        self.txtPhoneNumber.text = self.userDic["tel"] as? String
        self.txtWebsiteUrl.text = self.userDic["website"] as? String
        self.txtEmployeeNumber.text = self.userDic["employee_number"] as? String
        self.txtAdvertisement.text = self.userDic["advertisement"] as? String
        self.txtAverageNumber.text = self.userDic["avr_customer"] as? String
        self.txtEmployeePinNumber.text = self.userDic["employee_pin_number"] as? String
        self.txtCustomerPinNumber.text = self.userDic["customer_pin_number"] as? String
        self.txtStartDate.text = self.userDic["month_start_date"] as? String
        self.txtWeekend.text = self.userDic["weekend"] as? String


    }
    // MARK: Uitextfield delegate
    
    func resignTextField() {
        
        self.txtEmail.resignFirstResponder()
       
        self.txtSalonOwnerName.resignFirstResponder()
        self.txtSalonatName.resignFirstResponder()
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
        self.txtStartDate.resignFirstResponder()
        self.txtWeekend.resignFirstResponder()

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
        
        self.selectedTextfield = textField

         if textField == self.txtWeekend
        {
            textField.resignFirstResponder()
            self.resignTextField()
            self.createServicePicker(textField: textField)
            
            return false
        }
        else
         {
            scrollView(toCenterOfScreen: textField, textfield: textField)

        }
        return true
    }
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == self.txtEmployeePinNumber || textField == self.txtCustomerPinNumber || textField == self.txtStartDate
        {
            if textField == self.txtStartDate
            {
                if (textField.text?.count)! >= 2 && string != ""
                {
                    return false
                }
                let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
                let compSepByCharInSet = string.components(separatedBy: aSet)
                let numberFiltered = compSepByCharInSet.joined(separator: "")
                return string == numberFiltered
            }
            else
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
            
        }
        else if textField == self.txtPhoneNumber {
            
            var fullString = textField.text ?? ""
            fullString.append(string)
            if range.length == 1 {
                textField.text = ConfigManager.format(phoneNumber: fullString, shouldRemoveLastDigit: true)
            } else {
                textField.text = ConfigManager.format(phoneNumber: fullString)
            }
            return false
            
          
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
    @objc func keyboardWillShow( note:NSNotification )
    {
        
        if ConfigManager.IS_IPHONE()
        {
          //  if self.selectedTextfield == self.txtPhoneNumber{

            self.btnKeypadReturn.isHidden = false
            let keyBoardWindow = UIApplication.shared.windows.last
            
            if ConfigManager.DeviceType.IS_IPHONE_X
            {
                self.btnKeypadReturn.frame = CGRect(x: 0, y: (keyBoardWindow?.frame.size.height)!-130, width: 106, height: 53)
                
            }
            else
            {
                self.btnKeypadReturn.frame = CGRect(x: 0, y: (keyBoardWindow?.frame.size.height)!-53, width: 106, height: 53)
                
            }
            
            keyBoardWindow?.addSubview(self.btnKeypadReturn)
            keyBoardWindow?.bringSubview(toFront: self.btnKeypadReturn)
            
            var userInfo = note.userInfo!
            var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
            print(keyboardFrame)
            
            keyboardFrame = self.view.convert(keyboardFrame, from: nil)
            
            var contentInset:UIEdgeInsets = self.scrollView.contentInset
            contentInset.bottom = keyboardFrame.size.height
            scrollView.contentInset = contentInset
                
           // }
        }
        
        
        
        
        
    }
    @objc func keyboardWillHide(_ notification:Notification) {
        
        if ConfigManager.IS_IPHONE(){
            
            self.btnKeypadReturn.isHidden = true
            
            let contentInset:UIEdgeInsets = .zero
            self.scrollView.contentInset = contentInset
            
        }
    }
    @objc func Done(_ sender : UIButton){
        
        
        self.selectedTextfield.resignFirstResponder()
        self.btnKeypadReturn.isHidden = true
        
        
    }
    // MARK: Picker view delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return self.arrWeekDaysList.count
       
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return self.arrWeekDaysList.object(at: row) as? String
            
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func serviceImageResponse(forURl urlString: String, response: NSDictionary) {
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(self)
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
