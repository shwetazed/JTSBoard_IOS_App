//
//  AddEmployeeViewController.swift
//  JTSBoard
//
//  Created by jts on 09/08/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher

class AddEmployeeViewController: UIViewController,UITextFieldDelegate,WebServiceControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    
   
    var objWebServiceController: WebServiceController?

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btnUploadImage: UIButton!
    @IBOutlet weak var imgUploadImage: UIImageView!
    
    @IBOutlet weak var bottomHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtDob: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtJoiningDate: UITextField!
    @IBOutlet weak var txtDesignation: UITextField!
    @IBOutlet weak var txtSalary: UITextField!
    @IBOutlet weak var txtHomeAddress: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var txtRole: UITextField!
    let picker = UIImagePickerController()

    var uploadedImage:String!

    var employeeId:String!
    var rolePicker = UIPickerView()
    var arrEmployeeData = NSDictionary()
    var arrRoleList = [[String:AnyObject]]()

    var roleId:String!
    var isBackSpace:Bool!

    var selectedTextfield:UITextField!
    
    let btnKeypadReturn = UIButton(type: UIButtonType.custom)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.objWebServiceController = WebServiceController()
        self.objWebServiceController?.delegate = self
        
        self.imgUploadImage.layer.cornerRadius = 10.0
        self.imgUploadImage.clipsToBounds = true
        
        self.btnSubmit.layer.cornerRadius = 5.0
        self.btnSubmit.clipsToBounds = true
        
        self.txtSalary.addTarget(self, action: #selector(myTextFieldDidchange), for: .editingChanged)

        self.getRoleData()

        if self.arrEmployeeData.count > 0 {
            
            self.setEmployeeData()
        }
    
        self.navigationItem.title = "従業員を追加する"
        
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
    func createRolePicker(textField:UITextField)
    {
        var alertTitle:String!
        
        alertTitle = "役割"
        
        let alertView = UIAlertController(
            title: alertTitle,
            message: "\n\n\n\n\n\n\n\n\n",
            preferredStyle: .alert)
        
        self.rolePicker = UIPickerView(frame:
            CGRect(x: 0, y: 50, width: 260, height: 162))
        self.rolePicker.dataSource = self
        self.rolePicker.delegate = self
        
        // comment this line to use white color
        self.rolePicker.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        
        
        alertView.view.addSubview(self.rolePicker)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            //  Do some action here.
            
            let roleTitle = String(format: "%@", self.arrRoleList[self.rolePicker.selectedRow(inComponent: 0)]["name"] as! CVarArg)
            let roleIdStr = String(format: "%@", self.arrRoleList[self.rolePicker.selectedRow(inComponent: 0)]["id"] as! CVarArg)

            textField.text = roleTitle
            self.roleId = roleIdStr
            
            //textField.text =  (self.arrRoleList.object(at: self.rolePicker.selectedRow(inComponent: 0))) as? String
                
        })
        
        self.rolePicker.selectRow(1, inComponent: 0, animated: true)
        
        alertView.addAction(action)
        self.present(alertView, animated: true) {
            
            self.rolePicker.frame.size.width = alertView.view.frame.size.width
            
        }
        
        
    }
    func getRoleData()
    {
        ConfigManager.showLoadingHUD(to_view: self.view)
        
        var parameters = [String : AnyObject] ()
        
        parameters["MethodName"] = "role_list" as AnyObject
        
        self.objWebServiceController?.serverParameter(parameters: parameters)
    }
   
    func setEmployeeData()
    {
        //  ConfigManager.showLoadingHUD(to_view: self.view)
        
        
        self.txtName.text = self.arrEmployeeData["name"] as? String
        self.txtDesignation.text = self.arrEmployeeData["designation"] as? String
        self.txtEmail.text = self.arrEmployeeData["email"] as? String
        self.txtPhone.text = self.arrEmployeeData["phone"] as? String
        self.txtDob.text = self.arrEmployeeData["dob"] as? String
        self.txtSalary.text = self.arrEmployeeData["salary"] as? String
        self.txtHomeAddress.text = self.arrEmployeeData["address"] as? String
        self.txtJoiningDate.text = self.arrEmployeeData["joining_date"] as? String
        self.txtRole.text = self.arrEmployeeData["role_title"] as? String
        self.roleId = self.arrEmployeeData["role_id"] as? String

        
        if let imgUrl = self.arrEmployeeData["image"] as? String{

            var imgFullUrl:String! = ""


            if imgUrl != nil && imgUrl != "" && imgUrl != "<null>"{
                
                self.uploadedImage = imgUrl

                imgFullUrl = ConfigManager.gImageUrl + imgUrl
                
                let url = URL(string: imgFullUrl)
                
                self.imgUploadImage.kf.setImage(with: url)
            }
            else
            {
                self.imgUploadImage.image = UIImage(named: "placeholder")
                self.uploadedImage = ""

            }
        }
        else
        {
            self.imgUploadImage.image = UIImage(named: "placeholder")
            self.uploadedImage = ""
        }
       
        
        
    }
    @IBAction func btnUploadImageAction(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: nil, message: "写真をアップする", preferredStyle: .actionSheet)
        
        let photoLibrary = UIAlertAction(title: "アルバムから", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            //  Do some action here.
            
            self.picker.allowsEditing = false
            self.picker.delegate = self
            self.picker.sourceType = .photoLibrary
            self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.picker.modalPresentationStyle = .popover
            self.present(self.picker, animated: true, completion: nil)
            self.picker.popoverPresentationController?.sourceView = sender
            
        })
        
        let cemaraAction = UIAlertAction(title: "写真を撮る", style: .destructive, handler: { (alert: UIAlertAction!) -> Void in
            //  Do some destructive action here.
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.picker.allowsEditing = false
                self.picker.delegate = self

                self.picker.sourceType = UIImagePickerControllerSourceType.camera
                self.picker.cameraCaptureMode = .photo
                self.picker.modalPresentationStyle = .fullScreen
                self.present(self.picker,animated: true,completion: nil)
            }
        })
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: { (alert: UIAlertAction!) -> Void in
            //  Do something here upon cancellation.
        })
        
        alertController.addAction(photoLibrary)
        alertController.addAction(cemaraAction)
        alertController.addAction(cancelAction)
        
        if let popoverController = alertController.popoverPresentationController {
            
            popoverController.sourceView = sender
            
            // popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            
        }
        self.present(alertController, animated: true, completion: nil)
        
    }
    // MARK: Picker view delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return self.arrRoleList.count
            
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let roleTitle = String(format: "%@", self.arrRoleList[row]["name"] as! CVarArg)

        return roleTitle
      
    }
    // MARK: UIimagepicker delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        self.imgUploadImage.image = img
        
        dismiss(animated:true, completion: nil)
        
        // print(self.arrServiceList!)
        
        var parameters = [String : AnyObject] ()
        
        parameters["MethodName"] = "upload_image" as AnyObject
        
        parameters["profile_image"] = self.uploadedImage as AnyObject
        
        ConfigManager.showLoadingHUD(to_view: self.view)
        
        print(parameters)
        
        self.objWebServiceController?.serverImageParameter(image: img)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated:true, completion: nil)

    }
    
   
    func createDatePicker(textField:UITextField)
    {
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.month = -3
        let threeMonthAgo = Calendar.current.date(byAdding: dateComponents, to: currentDate)
        
        let datePicker = DatePickerDialog(textColor: .black,
                                          buttonColor: .black,
                                          font: UIFont.boldSystemFont(ofSize: 17),
                                          showCancelButton: true)
        datePicker.show("Select Date",
                        doneButtonTitle: "Done",
                        cancelButtonTitle: "Cancel",
                        minimumDate: threeMonthAgo,
                        maximumDate: currentDate,
                        datePickerMode: .date) { (date) in
                            if let dt = date {
                                let formatter = DateFormatter()
                                formatter.dateFormat = "yyyy-MM-dd"
                                let dobStr:String! = formatter.string(from: dt)
                                if textField == self.txtDob
                                {
                                    self.txtDob.text = dobStr

                                }
                                else
                                {
                                    self.txtJoiningDate.text = dobStr

                                }
                                
                            }
        }
    }

    @IBAction func btnSubmitAction(_ sender: UIButton) {
        
        if self.txtName.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: "名前を入力してください", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if self.txtDob.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: "誕生日を入力してください", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if self.txtPhone.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: "電話を入力してください", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if self.txtEmail.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: "メールを入力してください", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if self.txtJoiningDate.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: "参加日を入力してください", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if self.txtDesignation.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: "役職を入力してください", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if self.txtSalary.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: "給料を入力してください", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if self.txtHomeAddress.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: "住所を入力してください", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if self.txtRole.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: "従業員の役割を選択してください", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        self.saveEmployeeData()
    }
    
    // MARK:  Webservice  method
   
    func saveEmployeeData() {
        
        ConfigManager.showLoadingHUD(to_view: self.view)
        
        var parameters = [String : AnyObject] ()
        
        parameters["MethodName"] = "add_employee" as AnyObject
        parameters["user_id"] = ConfigManager.gUserId as AnyObject
        parameters["name"] = self.txtName.text as AnyObject
        parameters["dob"] = self.txtDob.text as AnyObject
        parameters["phone"] = self.txtPhone.text as AnyObject
        parameters["email"] = self.txtEmail.text as AnyObject
        parameters["joining_date"] = self.txtJoiningDate.text as AnyObject
        parameters["designation"] = self.txtDesignation.text as AnyObject
        parameters["salary"] = self.txtSalary.text as AnyObject
        parameters["address"] = self.txtHomeAddress.text as AnyObject
        parameters["image"] = self.uploadedImage as AnyObject
        parameters["role_title"] = self.txtRole.text as AnyObject
        parameters["role_id"] = self.roleId as AnyObject

        if self.employeeId != nil || self.employeeId != "" {
            
            parameters["id"] = self.employeeId as AnyObject

        }
        
        self.objWebServiceController?.serverParameter(parameters: parameters)
        
        
    }
    // pragma UItextfield delegate
 
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
        
        if textField == self.txtDob || textField == self.txtJoiningDate{
            
            textField.resignFirstResponder()
            self.resignTextField()
            self.createDatePicker(textField: textField)
            return false

        }
        if textField == self.txtRole{

            self.createRolePicker(textField: self.txtRole)
            textField.resignFirstResponder()
            self.resignTextField()

            return false

        }
        else
        {
            scrollView(toCenterOfScreen: textField, textfield: textField)

        }
        return true
    }
    func resignTextField()
    {
        self.txtName.resignFirstResponder()
        self.txtDob.resignFirstResponder()
        self.txtPhone.resignFirstResponder()
        self.txtEmail.resignFirstResponder()
        self.txtJoiningDate.resignFirstResponder()
        self.txtDesignation.resignFirstResponder()
        self.txtSalary.resignFirstResponder()
        self.txtHomeAddress.resignFirstResponder()
        self.txtRole.resignFirstResponder()

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
            if self.selectedTextfield == self.txtPhone ||  self.selectedTextfield == self.txtSalary{
                
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
            }
            
            
        }
        
        
        
        
       
    }
    @objc func keyboardWillHide(_ notification:Notification) {
        
        if ConfigManager.IS_IPHONE(){

            if self.selectedTextfield == self.txtPhone ||  self.selectedTextfield == self.txtPhone{

                self.btnKeypadReturn.isHidden = true
        
                let contentInset:UIEdgeInsets = .zero
                self.scrollView.contentInset = contentInset
            }
            
        }
    }
    @objc func Done(_ sender : UIButton){
        
        
        self.selectedTextfield.resignFirstResponder()
        self.btnKeypadReturn.isHidden = true
        
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      
        if textField == self.txtPhone {
  
          var fullString = textField.text ?? ""
            fullString.append(string)
            if range.length == 1 {
                textField.text = ConfigManager.format(phoneNumber: fullString, shouldRemoveLastDigit: true)
            } else {
                textField.text = ConfigManager.format(phoneNumber: fullString)
            }
            return false

        }
        else if textField == self.txtSalary
        {
            let  char = string.cString(using: String.Encoding.utf8)!
            let isBackSpace = strcmp(char, "\\b")
            
            
            if (isBackSpace == -92) {
                print("Backspace was pressed")
                
                self.isBackSpace = true
            }
            else
            {
                self.isBackSpace = false
            }
            let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            return string == numberFiltered
            return true
        }
        else
        {
            return true
        }
       
    }
    @objc func myTextFieldDidchange(_ textField: UITextField) {
        
        if self.isBackSpace == false {
            
            
            let currencyFormatter = NumberFormatter()
            currencyFormatter.usesGroupingSeparator = true
            currencyFormatter.numberStyle = .currency
            currencyFormatter.currencySymbol = ""
            
            var amountStr = textField.text?.replacingOccurrences(of: ",", with: "")
            amountStr = amountStr?.replacingOccurrences(of: "円", with: "")
            
            let trimmedString = amountStr?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            var priceString:String! = currencyFormatter.string(from: NSNumber(value: Int(trimmedString!)!))
            priceString = priceString.replacingOccurrences(of: ".00", with: "")
            
            print(priceString!)
            
            textField.text = String(format: "%@円", priceString!)
            
        }
        
        
    }
    /*func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if textField == self.txtPhone
        {
            var newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            var components = newString.components(separatedBy: NSCharacterSet.decimalDigits)
            
           // var components = newString.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet)
            
            var decimalString = "".join(components) as NSString
            var length = decimalString.length
            var hasLeadingOne = length > 0 && decimalString.characterAtIndex(0) == (1 as unichar)
            
            if length == 0 || (length > 10 && !hasLeadingOne) || length > 11
            {
                var newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int
                
                return (newLength > 10) ? false : true
            }
            var index = 0 as Int
            var formattedString = NSMutableString()
            
            if hasLeadingOne
            {
                formattedString.append("1 ")
                index += 1
            }
            if (length - index) > 3
            {
                var areaCode = decimalString.substringWithRange(NSMakeRange(index, 3))
                formattedString.appendFormat("(%@)", areaCode)
                index += 3
            }
            if length - index > 3
            {
                var prefix = decimalString.substringWithRange(NSMakeRange(index, 3))
                formattedString.appendFormat("%@-", prefix)
                index += 3
            }
            
            var remainder = decimalString.substringFromIndex(index)
            formattedString.appendString(remainder)
            textField.text = formattedString as String
            return false
        }
        else
        {
            return true
        }
    }*/
    // Mark WebService  delegate

    func serviceResponse(forURl urlString: String, response: JSON) {
        
        ConfigManager.hideLoadingHUD(for_view: self.view)
        
        if !(urlString == "server_error_handle") {
            
            if urlString == "add_employee"
            {
                let status:String! = String(describing:response["status"])
                let msg:String! = String(describing:response["msg"])

                if status == "success"
                {
                    if self.roleId == "1"
                    {
                        let employee_id:String! = String(describing:response["employee_id"])
                      
                        ConfigManager.gEmployeeId = employee_id
                        ConfigManager.gEmployeeName = self.txtName.text
                        ConfigManager.gEmployeeImage = self.uploadedImage

                        UserDefaults.standard.set(ConfigManager.gEmployeeId, forKey: "EMP_ID")
                        UserDefaults.standard.set(ConfigManager.gEmployeeName, forKey: "EMP_NAME")
                        UserDefaults.standard.set(ConfigManager.gEmployeeImage, forKey: "EMP_MAGE")

                    }
               
                    
                    let alert = UIAlertController(title: "", message: "Employee added successfully", preferredStyle: .alert)
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
            else if urlString == "role_list"
            {
                
                if let resData = response["Role"].arrayObject {
                    
                    self.arrRoleList = resData as! [[String : AnyObject]]
                    
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
        
        ConfigManager.hideLoadingHUD(for_view: self.view)
        
        if !(urlString == "server_error_handle") {
            
            if urlString == "upload_note_image"
            {
                if let resData = response["response_data"] {
                    
                    let dict:NSDictionary = resData as! NSDictionary
                    
                    let image:String! = String(describing:dict["image"]!)
                    
                    self.uploadedImage = image!
                    
                    print(self.uploadedImage!);
                    
                }
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(self)
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
