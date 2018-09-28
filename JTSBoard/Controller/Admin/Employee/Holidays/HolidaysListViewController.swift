//
//  HolidaysListViewController.swift
//  JTSBoard
//
//  Created by jts on 27/08/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher

class HolidaysListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,WebServiceControllerDelegate {

    @IBOutlet weak var tblView: UITableView!
    
    let identifier = "holidaylistcell"
    var objWebServiceController: WebServiceController?
    var objAddHolidaysViewController: AddHolidaysViewController?

    var arrHolidayList:NSMutableArray! = NSMutableArray()
    var deleteIndex:Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.objWebServiceController = WebServiceController()
        self.objWebServiceController?.delegate = self
        self.tblView.register(UINib(nibName: "HolidayListTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        
        self.navigationItem.title = "休日"
        
        let holidayButton = UIButton(type: .custom)
        holidayButton.setImage(UIImage(named: "add_holiday_icon"), for: .normal) // Image can be downloaded from here below link
        holidayButton.setTitle("", for: .normal)
        holidayButton.addTarget(self, action: #selector(HolidaysListViewController.btnHolidayAction), for: .touchUpInside)
        holidayButton.setTitleColor(UIColor.black, for: .normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: holidayButton)
        
        // Do any additional setup after loading the view.
    }
    @objc func btnHolidayAction()
    {
        self.objAddHolidaysViewController = AddHolidaysViewController()
        self.objAddHolidaysViewController?.holidayId = ""
        self.navigationController?.pushViewController(self.objAddHolidaysViewController!, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {

        self.getHolidaysData()
        
    }
    func getHolidaysData() {
        
        ConfigManager.showLoadingHUD(to_view: self.view)
        
        var parameters = [String : AnyObject] ()
        
        parameters["MethodName"] = "holiday_list" as AnyObject
        parameters["user_id"] = ConfigManager.gUserId as AnyObject
        
        self.objWebServiceController?.serverParameter(parameters: parameters)
        
        
    }
    // MARK:  Tableview Bar delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
            if self.arrHolidayList.count > 0 {
                
                return self.arrHolidayList.count;
                
            }
        
        return 0;
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70.0
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
        
    
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "削除") { (action, indexPath) in
            // delete item at indexPath
            
            self.deleteHoliday(deletedIndex: indexPath.row)
        }
        
        let edit = UITableViewRowAction(style: .normal, title: "編集") { (action, indexPath) in
            // share item at indexPath
            self.editHoliday(editedIndex: indexPath.row)
        }
        //delete.backgroundColor = UIColor(patternImage: UIImage(named: "delete_icon")!)
        // edit.backgroundColor = UIColor(patternImage: UIImage(named: "edit_icon")!)
        
        edit.backgroundColor = UIColor(red: 5/255, green: 105/255, blue: 189/255, alpha: 1.0)
        
        delete.backgroundColor = UIColor(red: 193/255, green: 44/255, blue: 14/255, alpha: 1.0)
        
        return [delete, edit]
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: HolidayListTableViewCell! = (tableView.dequeueReusableCell(withIdentifier: identifier) as? HolidayListTableViewCell?)!
        
        if cell == nil {
            
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? HolidayListTableViewCell
        }
        
        var holidayDic:NSDictionary!
        
        
        holidayDic = self.arrHolidayList[indexPath.row] as! NSDictionary
        
        let holidayName:String! = holidayDic["title"] as! String
        let holidayDate:String! = holidayDic["date"] as! String
        cell.lblHolidayTitle.text = holidayName.capitalized
        cell.lblDate.text = holidayDate
        
        return cell
        
        
    }
   
    func deleteHoliday(deletedIndex: Int)
    {
        ConfigManager.showLoadingHUD(to_view: self.view)
        
        var parameters = [String : AnyObject] ()
        
        self.deleteIndex = deletedIndex ;
        
        parameters["MethodName"] = "delete_holiday" as AnyObject
        
        
        parameters["id"] = ((self.arrHolidayList.object(at: deletedIndex)) as! NSDictionary).object(forKey: "id") as? String as AnyObject
        
        self.objWebServiceController?.serverParameter(parameters: parameters)
        
    }
    func editHoliday(editedIndex: Int)
    {
        var holidayDic:NSDictionary!
        
        holidayDic = self.arrHolidayList[editedIndex] as! NSDictionary
            
        
        print(holidayDic)
        
        self.objAddHolidaysViewController = AddHolidaysViewController()
        self.objAddHolidaysViewController?.holidayId = holidayDic.object(forKey: "id") as! String
        self.objAddHolidaysViewController?.arrHolidayeData = holidayDic
        self.navigationController?.pushViewController(self.objAddHolidaysViewController!, animated: true)
    }
    // MARK:  Webservice Bar delegate
    
    func serviceResponse(forURl urlString: String, response: JSON) {
        
        ConfigManager.hideLoadingHUD(for_view: self.view)
        
        if !(urlString == "server_error_handle") {
            
            if urlString == "holiday_list"
            {
                self.arrHolidayList.removeAllObjects()
                
                if let resData = response["Holiday"].arrayObject {
                    
                    self.arrHolidayList = (resData as NSArray).mutableCopy() as! NSMutableArray
                    
                }
                
                if self.arrHolidayList.count > 0
                {
                    self.tblView.reloadData()
                }
            }
            else if urlString == "delete_holiday"
            {
                let status:String! = String(describing:response["status"])
                
                if status == "success"
                {
                    self.arrHolidayList.removeObject(at: self.deleteIndex);
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
