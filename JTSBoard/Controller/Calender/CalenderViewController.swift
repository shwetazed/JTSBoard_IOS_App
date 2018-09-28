//
//  CalenderViewController.swift
//  JTSBoard
//
//  Created by jts on 10/07/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CalenderViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,WebServiceControllerDelegate {

    @IBOutlet weak var tblView: UITableView!
    
    
   // var arrCalenderList:NSMutableArray!
    var arrCalenderList = [[String:AnyObject]] ()

    let identifier = "calendercell"
    var headerView:CalenderHeaderView! = CalenderHeaderView()
    var calenderPopupView:CalenderProgressPopupView! = CalenderProgressPopupView()
    var objWebServiceController: WebServiceController?

    override func viewDidLoad() {
        super.viewDidLoad()

       // self.arrCalenderList = NSMutableArray()
        
        self.objWebServiceController = WebServiceController()
        self.objWebServiceController?.delegate = self

        self.tblView.register(UINib(nibName: "CalenderTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        
        if UIApplication.shared.statusBarOrientation.isPortrait == true
        {
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")

        }
        
        self.getCalenderData()
       
       // let value = UIInterfaceOrientation.landscapeRight.rawValue
        //UIDevice.current.setValue(value, forKey: "orientation")
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AppUtility.lockOrientation(.landscape)
        // Or to rotate and lock
        // AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Don't forget to reset when view is being removed
        AppUtility.lockOrientation(.all)
    }
   func getCalenderData()
   {
        ConfigManager.showLoadingHUD(to_view: self.view)
    
        var parameters = [String : AnyObject] ()
    
        parameters["MethodName"] = "reservation_calendar_ipad" as AnyObject
        parameters["user_id"] = ConfigManager.gUserId as AnyObject
    
        self.objWebServiceController?.serverParameter(parameters: parameters)
    }
    // MARK:  Tableview  delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrCalenderList.count;
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 60
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60.0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
//        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 60))
//        view.addSubview(self.headerView)
        
        self.headerView = CalenderHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 60))

        return self.headerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: CalenderTableViewCell! = (tableView.dequeueReusableCell(withIdentifier: identifier) as? CalenderTableViewCell?)!
        
        if cell == nil {
            
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CalenderTableViewCell
        }
        
//        cell.lblJobName.text = (self.arrCalenderList.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "job_name") as? String
//        cell.lblJobName.text = (self.arrCalenderList.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "last_visit") as? String
//        cell.lblJobName.text = (self.arrCalenderList.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "price") as? String
//        cell.lblJobName.text = (self.arrCalenderList.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "staff") as? String
//        cell.lblJobName.text = (self.arrCalenderList.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "time") as? String
//        cell.lblJobName.text = (self.arrCalenderList.object(at: indexPath.row) as? NSDictionary)?.object(forKey: "ongoing") as? String

        var jobName:String! = String(format: "%@", (self.arrCalenderList[indexPath.row]["job_name"] as! String))
        var time:String! = String(format: "%@", (self.arrCalenderList[indexPath.row]["time"] as! String))
        var lastVisit:String! = String(format: "%@", (self.arrCalenderList[indexPath.row]["last_visit"] as! String))
        var price:String! = String(format: "%@", (self.arrCalenderList[indexPath.row]["price"] as! String))
        var staff:String! = String(format: "%@", (self.arrCalenderList[indexPath.row]["staff"] as! String))
        var ongoing:String! = String(format: "%@", (self.arrCalenderList[indexPath.row]["ongoing"] as! String))

        jobName = jobName.trimmingCharacters(in: .whitespacesAndNewlines)
        time = time.trimmingCharacters(in: .whitespacesAndNewlines)
        lastVisit = lastVisit.trimmingCharacters(in: .whitespacesAndNewlines)
        price = price.trimmingCharacters(in: .whitespacesAndNewlines)
        staff = staff.trimmingCharacters(in: .whitespacesAndNewlines)
        ongoing = ongoing.trimmingCharacters(in: .whitespacesAndNewlines)

        
        print((self.arrCalenderList[indexPath.row]["job_name"] as? String)!)
        
        cell.lblJobName.text = jobName!
        cell.lblTime.text = time!
        cell.lblLastVisit.text = lastVisit!
        cell.lblPrice.text = price!
        cell.lblStaff.text = staff!
        cell.lblOngoing.text = ongoing!

        
        
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! CalenderTableViewCell
        
        self.calenderPopupView = CalenderProgressPopupView(frame: CGRect(x: 0, y: 0 , width: 350, height: 210))
        self.calenderPopupView.layer.masksToBounds = false
        self.calenderPopupView.layer.shadowColor = UIColor.black.cgColor
        self.calenderPopupView.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.calenderPopupView.layer.shadowOpacity = 0.24
        self.calenderPopupView.layer.shadowRadius = CGFloat(2)
        
        self.calenderPopupView.btnCross.addTarget(self, action: #selector(btnCrossPopupAction), for: .touchUpInside)
        
        let popoverContent = UIViewController()
        popoverContent.view = self.calenderPopupView
        popoverContent.modalPresentationStyle = .popover
        
        present(popoverContent, animated: true)
        
        let popover: UIPopoverPresentationController? = popoverContent.popoverPresentationController
       // popover?.permittedArrowDirections = .right
        popover!.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)

        popoverContent.preferredContentSize = CGSize(width: 350, height: 210)

        popover?.sourceView = cell
      //  popover?.sourceRect = cell.bounds
        popover?.sourceRect = CGRect(x: cell.bounds.origin.x + 400, y: cell.bounds.origin.y, width: 0, height: 0)
    }
    @objc func btnCrossPopupAction()
    {
        self.presentedViewController?.dismiss(animated: true, completion: nil)

    }
    // MARK:  Webservice Bar delegate
    
    
    func serviceResponse(forURl urlString: String, response: JSON) {
        
        ConfigManager.hideLoadingHUD(for_view: self.view)
        
        if !(urlString == "server_error_handle") {
            
            
            if let resData = response["Reservation"].arrayObject {
                
                //self.arrCalenderList = (resData as NSArray).mutableCopy() as! NSMutableArray
                self.arrCalenderList = resData as! [[String : AnyObject]]

            }
            
            if self.arrCalenderList.count > 0
            {
                self.tblView.reloadData()
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
