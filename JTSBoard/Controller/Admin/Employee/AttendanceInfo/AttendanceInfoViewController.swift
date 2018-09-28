//
//  AttendanceInfoViewController.swift
//  JTSBoard
//
//  Created by jts on 09/08/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit
import SwiftyJSON

let identifier = "attendanceinfocell"


class AttendanceInfoViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,WebServiceControllerDelegate {

    @IBOutlet weak var tblView: UITableView!
    var arrAttandanceList:NSMutableArray!
    var objWebServiceController: WebServiceController?
    var objSalaryCalculateViewController: SalaryCalculateViewController?

    var employeeId:String!
    var userNameStr:String!
    var designationStr:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.arrAttandanceList = NSMutableArray()
        
        self.objWebServiceController = WebServiceController()
        self.objWebServiceController?.delegate = self
        
        if ConfigManager.DeviceType.IS_IPAD
        {
            self.tblView.register(UINib(nibName: "AttandanceInfoTableViewCell_ipad", bundle: nil), forCellReuseIdentifier: identifier)

        }
        else
        {
            self.tblView.register(UINib(nibName: "AttandanceInfoTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)

        }
        

//
        // Do any additional setup after loading the view.
        
        let editButton = UIButton(type: .custom)
        editButton.setImage(UIImage(named: "monthly-calendar"), for: .normal) // Image can be downloaded from here below link
        editButton.setTitle("", for: .normal)
        editButton.addTarget(self, action: #selector(AttendanceInfoViewController.infoButtonTapped), for: .touchUpInside)
        editButton.setTitleColor(UIColor.black, for: .normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editButton)
        
        
      /*  let infoButton = UIButton(type: .infoLight)
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: infoButton)
        self.navigationItem.rightBarButtonItem = barButton*/
        
        // Do any additional setup after loading the view.
    }
    @objc func infoButtonTapped()
    {
        self.objSalaryCalculateViewController = SalaryCalculateViewController()
        self.objSalaryCalculateViewController?.employeeId = self.employeeId
        self.objSalaryCalculateViewController?.userNameStr = self.userNameStr
        self.objSalaryCalculateViewController?.designationStr = self.designationStr
        self.navigationController?.pushViewController(self.objSalaryCalculateViewController!, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.getAttendanceData()
        
    }
    func getAttendanceData() {
        
        ConfigManager.showLoadingHUD(to_view: self.view)
        
        var parameters = [String : AnyObject] ()
        
        parameters["MethodName"] = "attendance_info" as AnyObject
        parameters["user_id"] = ConfigManager.gUserId as AnyObject
        parameters["employee_id"] = self.employeeId as AnyObject

        self.objWebServiceController?.serverParameter(parameters: parameters)
        
        
    }
    
    // MARK:  Tableview Bar delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
            if self.arrAttandanceList.count > 0 {
                
                return self.arrAttandanceList.count;
                
            }
       
        return 0;
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70.0
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: AttandanceInfoTableViewCell! = (tableView.dequeueReusableCell(withIdentifier: identifier) as? AttandanceInfoTableViewCell?)!
        
        if cell == nil {
            
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? AttandanceInfoTableViewCell
        }
        
        var attandanceDic:NSDictionary!
        
        
        attandanceDic = self.arrAttandanceList[indexPath.row] as! NSDictionary
        
       
       
        let checkinDate:String! = attandanceDic["date"] as! String
        let checkinTime:String! = attandanceDic["checkin_time"] as! String
        let checkoutTime:String! = attandanceDic["checkout_time"] as! String
        let lunchHours:String! = attandanceDic["lunch_hour"] as! String
        let workingHours:String! = attandanceDic["working_hour"] as! String
        let totalHours:String! = attandanceDic["total_hour"] as! String
        
        print(checkinDate)
        print(checkinTime)
        print(checkoutTime)

        print(lunchHours)
        print(workingHours)
        print(totalHours)

        cell.lblDate.text = String(format: "日付   :  %@", checkinDate)

        cell.lblCheckInTime.text = String(format: "出勤   :  %@", checkinTime)
        cell.lblCheckoutTime.text = String(format: "退勤   :  %@", checkoutTime)
        cell.lblLunchHours.text = String(format: "合計 昼食時間 : %@", lunchHours)
        cell.lblWorkingHours.text = String(format: "合計 労働時間 : %@", workingHours)
        cell.lblTotalHours.text = String(format: "合計 時間 : %@", totalHours)
       
        return cell
        
        
    }
    
    // MARK:  Webservice Bar delegate
    
    func serviceResponse(forURl urlString: String, response: JSON) {
        
        ConfigManager.hideLoadingHUD(for_view: self.view)
        
        if !(urlString == "server_error_handle") {
            
            if urlString == "attendance_info"
            {
                self.arrAttandanceList.removeAllObjects()
                
                if let resData = response["Attendance"].arrayObject {
                    
                    self.arrAttandanceList = (resData as NSArray).mutableCopy() as! NSMutableArray
                    
                }
                
                if self.arrAttandanceList.count > 0
                {
                    self.tblView.reloadData()
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
