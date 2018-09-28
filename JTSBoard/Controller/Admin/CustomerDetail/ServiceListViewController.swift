//
//  ServiceListViewController.swift
//  JTSBoard
//
//  Created by jts on 31/08/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ServiceListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,WebServiceControllerDelegate {

    @IBOutlet weak var tblView: UITableView!
   
    let identifier = "servicelistcell"
    var arrServiceData:NSMutableArray!
    var objWebServiceController: WebServiceController?
    var objServiceDetailViewController: ServiceDetailViewController!
    
    var customerId:NSString!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.arrServiceData = NSMutableArray()
        
        self.objWebServiceController = WebServiceController()
        self.objWebServiceController?.delegate = self
        
        self.navigationItem.title = "Service List"

        if ConfigManager.IS_IPHONE() {
            
            self.tblView.register(UINib(nibName: "ServiceListTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)

        }
        else
        {
            self.tblView.register(UINib(nibName: "ServiceListTableViewCell_ipad", bundle: nil), forCellReuseIdentifier: identifier)

        }

        self.getServiceData()
        // Do any additional setup after loading the view.
    }
    func getServiceData() {
        
        ConfigManager.showLoadingHUD(to_view: self.view)
        
        var parameters = [String : AnyObject] ()
        
        parameters["MethodName"] = "customer_service_list" as AnyObject
        parameters["user_id"] = ConfigManager.gUserId as AnyObject
        parameters["customer_id"] = self.customerId as AnyObject

        
        self.objWebServiceController?.serverParameter(parameters: parameters)
        
        
    }
    
    // MARK:  Tableview  delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
            if self.arrServiceData.count > 0 {
                
                return self.arrServiceData.count;
                
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
        
        var cell: ServiceListTableViewCell! = (tableView.dequeueReusableCell(withIdentifier: identifier) as? ServiceListTableViewCell?)!
        
        if cell == nil {
            
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? ServiceListTableViewCell
        }
        
        var serviceDic:NSDictionary!
        
        
        serviceDic = self.arrServiceData[indexPath.row] as! NSDictionary
            
       
        let serviceName:String! = serviceDic["service_name"] as! String
        let serviceDate:String! = serviceDic["date"] as! String

        cell.lblServiceName.text = serviceName
        cell.lblServiceDate.text = serviceDate

        
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var serviceDic:NSDictionary!
        serviceDic = self.arrServiceData[indexPath.row] as! NSDictionary
        
        let serviceId:String! = serviceDic["service_id"] as! String
        
        if serviceId != "1" {
            
            self.objServiceDetailViewController = ServiceDetailViewController(nibName: "ServiceDetailViewController", bundle: nil)
            self.objServiceDetailViewController?.customerId = self.customerId as String?
            self.objServiceDetailViewController?.serviceId = serviceId
                self.objServiceDetailViewController?.customerServiceId = serviceDic["customer_service_id"] as! String
            
            self.navigationController?.pushViewController(self.objServiceDetailViewController!, animated: true)

        }

        
    }
    
    
    // MARK:  Webservice Bar delegate
    
    
    func serviceResponse(forURl urlString: String, response: JSON) {
        
        ConfigManager.hideLoadingHUD(for_view: self.view)
        
        if !(urlString == "server_error_handle") {
            
            
            if let resData = response["Service"].arrayObject {
                
                self.arrServiceData = (resData as NSArray).mutableCopy() as! NSMutableArray
                
            }
            
            if self.arrServiceData.count > 0
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
