//
//  AddHolidaysViewController.swift
//  JTSBoard
//
//  Created by jts on 27/08/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher

class AddHolidaysViewController: UIViewController,UITextFieldDelegate,WebServiceControllerDelegate{

    var objWebServiceController: WebServiceController?

    @IBOutlet weak var txtHolidayName: UITextField!
    @IBOutlet weak var txtHolidayDate: UITextField!
    
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    var arrHolidayeData = NSDictionary()
    var holidayId:String!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.objWebServiceController = WebServiceController()
        self.objWebServiceController?.delegate = self
        
        self.btnSubmit.layer.cornerRadius = 5.0
        self.btnSubmit.clipsToBounds = true
        
        self.navigationItem.title = "休日"
        
        if self.arrHolidayeData.count > 0 {
            
            self.setHolidayData()
            
        }

        // Do any additional setup after loading the view.
    }
    func setHolidayData()
    {
        //  ConfigManager.showLoadingHUD(to_view: self.view)
        
        
        self.txtHolidayName.text = self.arrHolidayeData["title"] as? String
        self.txtHolidayDate.text = self.arrHolidayeData["date"] as? String
        
        
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
        
        if textField == self.txtHolidayDate {
            
            self.createDatePicker(textField: textField)
            resignTextField()
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
        self.txtHolidayDate.resignFirstResponder()
        self.txtHolidayName.resignFirstResponder()

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
                                let dateStr:String! = formatter.string(from: dt)
                                self.txtHolidayDate.text = dateStr
                                    
                                
                                
                                
                            }
        }
    }
    
    @IBAction func btnSubmitAction(_ sender: Any) {

        if self.txtHolidayName.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: "名前を入力してください", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if self.txtHolidayDate.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: "誕生日を入力してください", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        self.saveHolidayData()
    }
    // MARK:  Webservice  method
    
    
    func saveHolidayData() {
        
        ConfigManager.showLoadingHUD(to_view: self.view)
        
        var parameters = [String : AnyObject] ()
        
        parameters["MethodName"] = "add_holiday" as AnyObject
        parameters["user_id"] = ConfigManager.gUserId as AnyObject
        parameters["title"] = self.txtHolidayName.text as AnyObject
        parameters["date"] = self.txtHolidayDate.text as AnyObject
       
        if self.holidayId != nil || self.holidayId != "" {
            
            parameters["id"] = self.holidayId as AnyObject
            
        }
        
        self.objWebServiceController?.serverParameter(parameters: parameters)
        
        
    }
    // Mark WebService  delegate
    
    func serviceResponse(forURl urlString: String, response: JSON) {
        
        ConfigManager.hideLoadingHUD(for_view: self.view)
        
        if !(urlString == "server_error_handle") {
            
            if urlString == "add_holiday"
            {
                let status:String! = String(describing:response["status"])
                
                if status == "success"
                {
                    let alert = UIAlertController(title: "", message: "Holiday added successfully", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    
                    self.dismiss(animated: true) {
                        
                        self.navigationController?.popViewController(animated: true)
                        
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
