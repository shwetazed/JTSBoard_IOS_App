//
//  EmployeeDetailViewController.swift
//  JTSBoard
//
//  Created by jts on 09/08/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher

class EmployeeDetailViewController: UIViewController,WebServiceControllerDelegate,UITextFieldDelegate {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    
    @IBOutlet weak var emailBackView: UIView!
    @IBOutlet weak var dobBackView: UIView!
    @IBOutlet weak var phoneBackView: UIView!
    @IBOutlet weak var joiningBackView: UIView!
    @IBOutlet weak var empCodeBackView: UIView!
    @IBOutlet weak var salaryBackView: UIView!
    @IBOutlet weak var addressBackView: UIView!
    @IBOutlet weak var roleBackView: UIView!
    @IBOutlet weak var lunchStartTimeView: UIView!
    @IBOutlet weak var lunchEndTimeView: UIView!

    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblDob: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblRole: UILabel!

    @IBOutlet weak var lblJoiningDate: UILabel!
    @IBOutlet weak var lblEmpCode: UILabel!
    @IBOutlet weak var lblSalary: UILabel!
    @IBOutlet weak var lblHomeAddress: UILabel!
    
    @IBOutlet weak var txtStartLunchTime: UITextField!
    @IBOutlet weak var txtEndLunchTime: UITextField!
    
    @IBOutlet weak var buttonView: UIView!

    var objWebServiceController: WebServiceController?
    var objAddEmployeeViewController: AddEmployeeViewController?
    var objAttendanceInfoViewController: AttendanceInfoViewController?

    
    @IBOutlet weak var addressViewHeight: NSLayoutConstraint!
    var arrEmployeeData = NSDictionary()

    var employeeId:String!
    var startLunchTimeStr:String!
    var endLunchTimeStr:String!


    override func viewDidLoad() {
        super.viewDidLoad()

        self.objWebServiceController = WebServiceController()
        self.objWebServiceController?.delegate = self
        
        self.lblHomeAddress.sizeToFit()
        self.setBorderArroundView()
    
        
        self.setEmployeeData()
        // Do any additional setup after loading the view.
        let deleteButton = UIButton(type: .custom)
        deleteButton.setImage(UIImage(named: "delete"), for: .normal) // Image can be downloaded from here below link
        deleteButton.setTitle("", for: .normal)
        deleteButton.addTarget(self, action: #selector(EmployeeDetailViewController.btnDeleteEmployeeAction), for: .touchUpInside)
        deleteButton.setTitleColor(UIColor.black, for: .normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: deleteButton)
        // Do any additional setup after loading the view.
    }
    @objc func btnDeleteEmployeeAction()
    {
        if ConfigManager.gCustomerPinNumber == ""
        {
            self.deleteEmployee()
        }
        else
        {
            let titlePrompt = UIAlertController(title: "JTS",
                                                message: "パスワードを入力してください",
                                                preferredStyle: .alert)
            
            var titleTextField: UITextField?
            titlePrompt.addTextField { (textField) -> Void in
                titleTextField = textField
                titleTextField?.isSecureTextEntry = true
                textField.placeholder = "パスワード"
            }
            
            let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .default, handler: nil)
            
            titlePrompt.addAction(cancelAction)
            
            titlePrompt.addAction(UIAlertAction(title: "送信", style: .destructive, handler: { (action) -> Void in
                if let textField = titleTextField {
                    
                    if textField.text! == ConfigManager.gCustomerPinNumber!
                    {
                        self.deleteEmployee()
                    }
                    else
                    {
                        let alert = UIAlertController(title: "", message: "間違ったパスワード", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "はい", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                }
            }))
            
            self.present(titlePrompt, animated: true, completion: nil)
            
        }

    }

    func setBorderArroundView()
    {
        self.buttonView.layer.cornerRadius = 10.0
        self.buttonView.clipsToBounds = true
        
        self.imgView.layer.cornerRadius = 10.0
        self.imgView.clipsToBounds = true
        self.imgView.layer.borderWidth = 2.0
        self.imgView.layer.borderColor = UIColor(red: 170/255, green: 171/255, blue: 175/255, alpha: 1.0).cgColor
        
        self.emailBackView.layer.cornerRadius = 5.0
        self.emailBackView.clipsToBounds = true
        self.emailBackView.layer.borderWidth = 1.0
        self.emailBackView.layer.borderColor = UIColor(red: 170/255, green: 171/255, blue: 175/255, alpha: 1.0).cgColor
        
        self.dobBackView.layer.cornerRadius = 5.0
        self.dobBackView.clipsToBounds = true
        self.dobBackView.layer.borderWidth = 1.0
        self.dobBackView.layer.borderColor = UIColor(red: 170/255, green: 171/255, blue: 175/255, alpha: 1.0).cgColor
        
        self.phoneBackView.layer.cornerRadius = 5.0
        self.phoneBackView.clipsToBounds = true
        self.phoneBackView.layer.borderWidth = 1.0
        self.phoneBackView.layer.borderColor = UIColor(red: 170/255, green: 171/255, blue: 175/255, alpha: 1.0).cgColor
        
        self.joiningBackView.layer.cornerRadius = 5.0
        self.joiningBackView.clipsToBounds = true
        self.joiningBackView.layer.borderWidth = 1.0
        self.joiningBackView.layer.borderColor = UIColor(red: 170/255, green: 171/255, blue: 175/255, alpha: 1.0).cgColor
        
        self.empCodeBackView.layer.cornerRadius = 5.0
        self.empCodeBackView.clipsToBounds = true
        self.empCodeBackView.layer.borderWidth = 1.0
        self.empCodeBackView.layer.borderColor = UIColor(red: 170/255, green: 171/255, blue: 175/255, alpha: 1.0).cgColor
        
        self.salaryBackView.layer.cornerRadius = 5.0
        self.salaryBackView.clipsToBounds = true
        self.salaryBackView.layer.borderWidth = 1.0
        self.salaryBackView.layer.borderColor = UIColor(red: 170/255, green: 171/255, blue: 175/255, alpha: 1.0).cgColor
        
        self.addressBackView.layer.cornerRadius = 5.0
        self.addressBackView.clipsToBounds = true
        self.addressBackView.layer.borderWidth = 1.0
        self.addressBackView.layer.borderColor = UIColor(red: 170/255, green: 171/255, blue: 175/255, alpha: 1.0).cgColor
        
        self.roleBackView.layer.cornerRadius = 5.0
        self.roleBackView.clipsToBounds = true
        self.roleBackView.layer.borderWidth = 1.0
        self.roleBackView.layer.borderColor = UIColor(red: 170/255, green: 171/255, blue: 175/255, alpha: 1.0).cgColor

        self.lunchStartTimeView.layer.cornerRadius = 5.0
        self.lunchStartTimeView.clipsToBounds = true
        self.lunchStartTimeView.layer.borderWidth = 1.0
        self.lunchStartTimeView.layer.borderColor = UIColor(red: 170/255, green: 171/255, blue: 175/255, alpha: 1.0).cgColor
        
        self.lunchEndTimeView.layer.cornerRadius = 5.0
        self.lunchEndTimeView.clipsToBounds = true
        self.lunchEndTimeView.layer.borderWidth = 1.0
        self.lunchEndTimeView.layer.borderColor = UIColor(red: 170/255, green: 171/255, blue: 175/255, alpha: 1.0).cgColor

    }
    
    func setEmployeeData()
    {
      //  ConfigManager.showLoadingHUD(to_view: self.view)
        
        
        self.lblName.text = self.arrEmployeeData["name"] as? String
        self.lblDesignation.text = self.arrEmployeeData["designation"] as? String
        self.lblEmail.text = self.arrEmployeeData["email"] as? String
        self.lblPhone.text = self.arrEmployeeData["phone"] as? String
        self.lblDob.text = self.arrEmployeeData["dob"] as? String
        self.lblSalary.text = self.arrEmployeeData["salary"] as? String
        self.lblEmpCode.text = self.arrEmployeeData["emp_code"] as? String
        self.lblHomeAddress.text = self.arrEmployeeData["address"] as? String
        self.lblJoiningDate.text = self.arrEmployeeData["joining_date"] as? String
        self.lblRole.text = self.arrEmployeeData["role_title"] as? String
        self.txtStartLunchTime.text = self.arrEmployeeData["start_lunch_time"] as? String
        self.txtEndLunchTime.text = self.arrEmployeeData["end_lunch_time"] as? String

        if let imgUrl = self.arrEmployeeData["image"] as? String{

            var imgFullUrl:String! = ""
            
            print(imgUrl)
            
            if imgUrl != nil && imgUrl != "" && imgUrl != "<null>"{
                
                imgFullUrl = ConfigManager.gImageUrl + imgUrl
                
                let url = URL(string: imgFullUrl)
                
                self.imgView.kf.setImage(with: url)
                
                print(self.imgView.frame)
                print(self.imgView.image?.size as Any)

                var rect:CGRect! = self.imgView.frame
                rect.size.width = (self.imgView.image?.size.width)!
                rect.size.height = (self.imgView.image?.size.height)!
                self.imgView.frame = rect
                print(rect)

                self.imgView.layer.cornerRadius = 10.0
                self.imgView.clipsToBounds = true
                self.imgView.layer.borderWidth = 2.0
                self.imgView.layer.borderColor = UIColor(red: 170/255, green: 171/255, blue: 175/255, alpha: 1.0).cgColor

            }
            else
            {
                self.imgView.image = UIImage(named: "placeholder")
            }
        }
        else
        {
            self.imgView.image = UIImage(named: "placeholder")
        }
        

    }
    @IBAction func btnEditAction(_ sender: Any) {
        
        self.editEmployee()
    }
    
    
    @IBAction func btnAttandanceInfo(_ sender: Any) {
        
        self.objAttendanceInfoViewController = AttendanceInfoViewController(nibName: "AttendanceInfoViewController", bundle: nil)
        self.objAttendanceInfoViewController?.employeeId = self.employeeId
        self.objAttendanceInfoViewController?.designationStr = self.arrEmployeeData.object(forKey: "designation") as! String
        self.objAttendanceInfoViewController?.userNameStr = self.arrEmployeeData.object(forKey: "name") as! String

        self.navigationController?.pushViewController(self.objAttendanceInfoViewController!, animated: true)
        
    }
    
    func deleteEmployee()
    {
        
        ConfigManager.showLoadingHUD(to_view: self.view)
        
        var parameters = [String : AnyObject] ()
        
        let deleteId = self.arrEmployeeData["id"] as? String

        parameters["MethodName"] = "delete_employee" as AnyObject
        
        parameters["id"] = deleteId as AnyObject
        
        self.objWebServiceController?.serverParameter(parameters: parameters)
        
        
    }
    func editEmployee()
    {
        
        if ConfigManager.DeviceType.IS_IPAD {
            
            self.objAddEmployeeViewController = AddEmployeeViewController(nibName: "AddEmployeeViewController_ipad", bundle: nil)
            
        }
        else
        {
            self.objAddEmployeeViewController = AddEmployeeViewController(nibName: "AddEmployeeViewController", bundle: nil)
            
        }
        self.objAddEmployeeViewController?.employeeId = self.arrEmployeeData.object(forKey: "id") as! String
        self.objAddEmployeeViewController?.arrEmployeeData = self.arrEmployeeData
        self.navigationController?.pushViewController(self.objAddEmployeeViewController!, animated: true)
    }
    
    func createLunchTimePicker(textField:UITextField)
    {
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.month = -3
        let threeMonthAgo = Calendar.current.date(byAdding: dateComponents, to: currentDate)
        
        let datePicker = DatePickerDialog(textColor: .black,
                                          buttonColor: .black,
                                          font: UIFont.boldSystemFont(ofSize: 17),
                                          showCancelButton: true)
        datePicker.show("Select Lunch time",
                        doneButtonTitle: "Done",
                        cancelButtonTitle: "Cancel",
                        minimumDate: threeMonthAgo,
                        maximumDate: currentDate,
                        datePickerMode: .time) { (date) in
                            if let dt = date {
                                let formatter = DateFormatter()
                                formatter.dateFormat = "HH:mm"
                                let timeStr:String! = formatter.string(from: dt)
                                if textField == self.txtStartLunchTime
                                {
                                    self.txtStartLunchTime.text = timeStr
                                    self.startLunchTimeStr = timeStr
                                    
                                    
                                }
                                else
                                {
                                    self.txtEndLunchTime.text = timeStr
                                    self.endLunchTimeStr = timeStr

                                }
                                
                                self.setLunchTime()

                                
                        }
        }
    }
    func setLunchTime()
    {
        ConfigManager.showLoadingHUD(to_view: self.view)
        
        var parameters = [String : AnyObject] ()
        
        let empId = self.arrEmployeeData["id"] as? String
        
        parameters["MethodName"] = "add_employee_lunch_time" as AnyObject
        
        parameters["id"] = empId as AnyObject
        parameters["start_lunch_time"] = self.startLunchTimeStr as AnyObject
        parameters["end_lunch_time"] = self.endLunchTimeStr as AnyObject

        self.objWebServiceController?.serverParameter(parameters: parameters)
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
            textField.resignFirstResponder()
            self.createLunchTimePicker(textField: textField)
            return false
            
        
    }
    // MARK:  Webservice Bar delegate
    
    func serviceResponse(forURl urlString: String, response: JSON) {
        
        ConfigManager.hideLoadingHUD(for_view: self.view)
        
        if !(urlString == "server_error_handle") {
            
           if urlString == "delete_employee"
            {
                let status:String! = String(describing:response["status"])
                
                if status == "success"
                {
                    let alert = UIAlertController(title: "", message: "Employee deleted successfully", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    
                    self.dismiss(animated: true) {
                        
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
            else if urlString == "add_employee_lunch_time"
            {
                let status:String! = String(describing:response["status"])
                let msg:String! = String(describing:response["msg"])

                if status != "success"
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
    func serviceImageResponse(forURl urlString: String, response: NSDictionary) {
        
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
