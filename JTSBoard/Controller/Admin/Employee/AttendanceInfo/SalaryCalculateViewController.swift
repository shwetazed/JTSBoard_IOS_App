//
//  SalaryCalculateViewController.swift
//  JTSBoard
//
//  Created by jts on 27/08/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit
import SwiftyJSON

class SalaryCalculateViewController: UIViewController,WebServiceControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate {
   

    @IBOutlet weak var topInfoView: UIView!
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    
    //@IBOutlet weak var btnMonth: UIButton!
    //@IBOutlet weak var btnYear: UIButton!
    
    @IBOutlet weak var btnStartDate: UIButton!
    @IBOutlet weak var btnEndDate: UIButton!
    
    @IBOutlet weak var presentDaysView: UIView!
    @IBOutlet weak var workingView: UIView!
    @IBOutlet weak var abscentDaysViews: UIView!
    @IBOutlet weak var buttonView: UIView!

    @IBOutlet weak var holidaysView: UIView!
    @IBOutlet weak var lunchHourView: UIView!
    @IBOutlet weak var workingHourView: UIView!
    @IBOutlet weak var totalHourView: UIView!

    
    @IBOutlet weak var lblWorkingDays: UILabel!
    
    @IBOutlet weak var lblPresentDays: UILabel!
    @IBOutlet weak var lblAbsentDays: UILabel!
    @IBOutlet weak var lblHolidays: UILabel!
    
    @IBOutlet weak var lblLuchHour: UILabel!
    @IBOutlet weak var lblWorkingHour: UILabel!
    @IBOutlet weak var lblTotalHour: UILabel!

    
    var employeeId:String!
    var userNameStr:String!
    var designationStr:String!
    
    var monthStr:String!
    var yearStr:String!
    
    var startDateStr:String!
    var endDateStr:String!
    
    var arrMonthList = NSMutableArray()
    var arrYearList = NSMutableArray()

    var attandanceDic = [String:Any]()
    var pickerType:String!
    
    var pickerView:UIPickerView!

    @IBOutlet weak var btnYearAction: UIButton!
    
    var objWebServiceController: WebServiceController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBorderArroundView()
        
        self.objWebServiceController = WebServiceController()
        self.objWebServiceController?.delegate = self
        
      //  self.fillMonthArrayList()
      //  self.fillYearArrayList()

        
      /*  let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        let nameOfMonth = dateFormatter.string(from: now)
        
        dateFormatter.dateFormat = "YYYY"
        let nameOfYear = dateFormatter.string(from: now)

        print(nameOfMonth)
        print(nameOfYear)
        
        self.monthStr = nameOfMonth
        self.yearStr = nameOfYear*/
        
      //  self.btnMonth.setTitle(self.monthStr, for: .normal)
      //  self.btnYear.setTitle(self.yearStr, for: .normal)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let endDobStr:String! = formatter.string(from: Date())
        
        self.endDateStr = endDobStr
        
        let prevDate = Calendar.current.date(byAdding: .month, value: -1, to: Date())
        let startDobStr:String! = formatter.string(from: prevDate!)
        
        self.startDateStr = startDobStr
        
        self.btnStartDate.setTitle(self.startDateStr, for: .normal)
        self.btnEndDate.setTitle(self.endDateStr, for: .normal)


        self.getAttandanceData()

        // Do any additional setup after loading the view.
    }
    func createDatePicker(btn:UIButton)
    {
        var alertTitle:String!
        
        
        if btn == self.btnStartDate
        {
            alertTitle = "Select Start Date"
        }
        else
        {
            alertTitle = "Select End Date"
        }
        
        
        let currentDate = Date()
        var dateComponents = DateComponents()
        dateComponents.month = -3
        let threeMonthAgo = Calendar.current.date(byAdding: dateComponents, to: currentDate)
        
        let datePicker = DatePickerDialog(textColor: .black,
                                          buttonColor: .black,
                                          font: UIFont.boldSystemFont(ofSize: 17),
                                          showCancelButton: true)
        datePicker.show(alertTitle,
                        doneButtonTitle: "Done",
                        cancelButtonTitle: "Cancel",
                        minimumDate: threeMonthAgo,
                        maximumDate: currentDate,
                        datePickerMode: .date) { (date) in
                            if let dt = date {
                                let formatter = DateFormatter()
                                formatter.dateFormat = "yyyy-MM-dd"
                                let dobStr:String! = formatter.string(from: dt)
                                if btn == self.btnStartDate
                                {
                                    self.btnStartDate.setTitle(dobStr, for: .normal)
                                    self.startDateStr = String(format: "%@", dobStr)
                                    self.getAttandanceData()

                                    
                                }
                                else
                                {
                                    self.btnEndDate.setTitle(dobStr, for: .normal)
                                    self.endDateStr = String(format: "%@", dobStr)

                                    self.getAttandanceData()

                                }
                                
                            }
        }
    }
    func fillMonthArrayList()
    {
        self.arrMonthList.add("1月")
        self.arrMonthList.add("2月")
        self.arrMonthList.add("3月")
        self.arrMonthList.add("4月")
        self.arrMonthList.add("5月")
        self.arrMonthList.add("6月")
        self.arrMonthList.add("7月")
        self.arrMonthList.add("8月")
        self.arrMonthList.add("9月")
        self.arrMonthList.add("10月")
        self.arrMonthList.add("11月")
        self.arrMonthList.add("12月")
        
       

    }
    func fillYearArrayList()
    {
        let years = (2010...2100).map { String($0) }

        self.arrYearList = (years as NSArray).mutableCopy() as! NSMutableArray
        
       // print(self.arrYearList)
      
    }
    func setBorderArroundView()
    {
        self.buttonView.layer.cornerRadius = 5.0
        self.buttonView.clipsToBounds = true
        
        self.presentDaysView.layer.cornerRadius = 5.0
        self.presentDaysView.clipsToBounds = true
        self.presentDaysView.layer.borderWidth = 1.0
        self.presentDaysView.layer.borderColor = UIColor(red: 170/255, green: 171/255, blue: 175/255, alpha: 1.0).cgColor
        
        self.abscentDaysViews.layer.cornerRadius = 5.0
        self.abscentDaysViews.clipsToBounds = true
        self.abscentDaysViews.layer.borderWidth = 1.0
        self.abscentDaysViews.layer.borderColor = UIColor(red: 170/255, green: 171/255, blue: 175/255, alpha: 1.0).cgColor
        
        self.workingView.layer.cornerRadius = 5.0
        self.workingView.clipsToBounds = true
        self.workingView.layer.borderWidth = 1.0
        self.workingView.layer.borderColor = UIColor(red: 170/255, green: 171/255, blue: 175/255, alpha: 1.0).cgColor
        
        self.holidaysView.layer.cornerRadius = 5.0
        self.holidaysView.clipsToBounds = true
        self.holidaysView.layer.borderWidth = 1.0
        self.holidaysView.layer.borderColor = UIColor(red: 170/255, green: 171/255, blue: 175/255, alpha: 1.0).cgColor
        
        self.lunchHourView.layer.cornerRadius = 5.0
        self.lunchHourView.clipsToBounds = true
        self.lunchHourView.layer.borderWidth = 1.0
        self.lunchHourView.layer.borderColor = UIColor(red: 170/255, green: 171/255, blue: 175/255, alpha: 1.0).cgColor
        
        self.workingHourView.layer.cornerRadius = 5.0
        self.workingHourView.clipsToBounds = true
        self.workingHourView.layer.borderWidth = 1.0
        self.workingHourView.layer.borderColor = UIColor(red: 170/255, green: 171/255, blue: 175/255, alpha: 1.0).cgColor
        
        self.totalHourView.layer.cornerRadius = 5.0
        self.totalHourView.clipsToBounds = true
        self.totalHourView.layer.borderWidth = 1.0
        self.totalHourView.layer.borderColor = UIColor(red: 170/255, green: 171/255, blue: 175/255, alpha: 1.0).cgColor
    }
    func getAttandanceData() {
        
        ConfigManager.showLoadingHUD(to_view: self.view)
        
        var parameters = [String : AnyObject] ()
        
        parameters["MethodName"] = "monthly_attendance" as AnyObject
        parameters["user_id"] = ConfigManager.gUserId as AnyObject
        parameters["employee_id"] = self.employeeId as AnyObject
        parameters["start_date"] = self.startDateStr as AnyObject
        parameters["end_date"] = self.endDateStr as AnyObject
        //parameters["month"] = self.monthStr as AnyObject
       // parameters["year"] = self.yearStr as AnyObject

        self.objWebServiceController?.serverParameter(parameters: parameters)
        
        
    }
    func setAttandanceData()
    {
        self.lblUserName.text = self.userNameStr
        self.lblDesignation.text = self.designationStr
       
        self.lblWorkingDays.text = String(format: "%@", self.attandanceDic["total"] as! CVarArg )
        self.lblPresentDays.text = String(format: "%@", self.attandanceDic["present"] as! CVarArg )
        self.lblAbsentDays.text = String(format: "%@", self.attandanceDic["apsent"] as! CVarArg )
        self.lblHolidays.text = String(format: "%@", self.attandanceDic["holiday"] as! CVarArg)
        self.lblLuchHour.text = String(format: "%@", self.attandanceDic["lunch_hour"] as! CVarArg)
        self.lblWorkingHour.text = String(format: "%@", self.attandanceDic["working_hour"] as! CVarArg)
        self.lblTotalHour.text = String(format: "%@", self.attandanceDic["total_hour"] as! CVarArg)
    }
   /* func createDatePicker(btn:UIButton)
    {
            var alertTitle:String!
            
        
            if btn == self.btnMonth
            {
                alertTitle = "Select Month"
                self.pickerType = "month"
            }
            else
            {
                alertTitle = "Select Year"
                self.pickerType = "year"
            }
        
        
    
    
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
                
                if btn == self.btnMonth {
                    
                     self.btnMonth.setTitle(self.arrMonthList.object(at: self.pickerView.selectedRow(inComponent: 0)) as? String, for: .normal)
                    
                    let index = self.pickerView.selectedRow(inComponent: 0)
                    
                    let month = String(format: "%d", index+1)
                    
                    if month.count == 1
                    {
                        self.monthStr = String(format: "0%@", month)
                    }
                    else
                    {
                        self.monthStr = month
                    }
                    
                    self.getAttandanceData()
                    
                    
                }
                else
                {
                    self.btnYear.setTitle(self.arrYearList.object(at: self.pickerView.selectedRow(inComponent: 0)) as? String, for: .normal)
                    self.yearStr = self.arrYearList.object(at: self.pickerView.selectedRow(inComponent: 0)) as? String
                    self.getAttandanceData()

                }
            })
        
        
        
            alertView.addAction(action)
            self.present(alertView, animated: true) {
                
                self.pickerView.frame.size.width = alertView.view.frame.size.width
                
                
            }
            
            
    }
    @IBAction func btnMonthAction(_ sender: UIButton) {
        
        self.createDatePicker(btn: sender)
    }
    
    @IBAction func btnYearAction(_ sender: UIButton) {
        
        self.createDatePicker(btn: sender)

    }*/
    @IBAction func btnStartDateAction(_ sender: UIButton) {
        
        self.createDatePicker(btn: sender)
    }
    
    @IBAction func btnEndDateAction(_ sender: UIButton) {
        
        self.createDatePicker(btn: sender)
        
    }
    func serviceResponse(forURl urlString: String, response: JSON) {
        
        ConfigManager.hideLoadingHUD(for_view: self.view)
        
        if !(urlString == "server_error_handle") {
            
            if urlString == "monthly_attendance"
            {
                if let resData = response["Attendance"].dictionaryObject {
                    
                    self.attandanceDic = resData
                    
                }
                
                if attandanceDic.count > 0
                {
                    self.setAttandanceData()

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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if self.pickerType == "month"
        {
            return self.arrMonthList.count
        }
        else
        {
            return self.arrYearList.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if self.pickerType == "month"
        {
            return self.arrMonthList.object(at: row) as? String
        }
        else
        {
            return self.arrYearList.object(at: row) as? String

        }
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
