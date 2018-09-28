//
//  CustomerListViewController.swift
//  JTSBoard
//
//  Created by jts on 10/07/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CustomerListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,WebServiceControllerDelegate,UISearchBarDelegate {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var backSearchView: UIView!

    @IBOutlet weak var searchBar: UISearchBar!
    var objWebServiceController: WebServiceController?
    var objCustomerDetailViewController: CustomerDetailViewController?
    var objAddNoteViewController: AddNoteViewController?

    let identifier = "customerlistcell"
   // var arrCustomerData = [[String : AnyObject]] ()
   // var arrCustomerSearchData = [[String : AnyObject]] ()
    var arrCustomerData:NSMutableArray!
    var arrCustomerSearchData:NSMutableArray!
    var searchActive:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.arrCustomerData = NSMutableArray()
        self.arrCustomerSearchData = NSMutableArray()
        
        self.navigationItem.title = "顧客一覧"
        
        self.backSearchView.layer.cornerRadius = 10.0
        self.backSearchView.clipsToBounds = true
        
        for view in searchBar.subviews.last!.subviews {
            if type(of: view) == NSClassFromString("UISearchBarBackground"){
                view.alpha = 0.0
            }
           
        }
        let textFieldInsideSearchBar = self.searchBar.value(forKey: "searchField") as? UITextField
        
        textFieldInsideSearchBar?.backgroundColor = UIColor.clear
        textFieldInsideSearchBar?.textColor = UIColor.black
       // textFieldInsideSearchBar?.backgroundColor = UIColor(red: 233/255, green: 238/255, blue: 241/255, alpha: 1.0)
      
        
        self.objWebServiceController = WebServiceController()
        self.objWebServiceController?.delegate = self
        
        self.tblView.register(UINib(nibName: "CustomerListTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)

        self.getCustomerData()
        
//        let analyticButton = UIButton(type: .custom)
//        analyticButton.setImage(UIImage(named: "analytic"), for: .normal) // Image can be downloaded from here below link
//        analyticButton.setTitle("", for: .normal)
//        analyticButton.addTarget(self, action: #selector(CustomerListViewController.btnAnalyticAction), for: .touchUpInside)
//        analyticButton.setTitleColor(UIColor.black, for: .normal)
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: analyticButton)
//        // Do any additional setup after loading the view.
//        let menuButton = UIButton(type: .custom)
//        menuButton.setImage(UIImage(named: "menu"), for: .normal) // Image can be downloaded from here below link
//        menuButton.setTitle("", for: .normal)
//        menuButton.addTarget(self, action: #selector(CustomerListViewController.btnMenuAction), for: .touchUpInside)
//        menuButton.setTitleColor(UIColor.black, for: .normal)
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.searchBar.resignFirstResponder()
        self.searchActive = false
        self.searchBar.text = ""
        
    }
    @objc func btnMenuAction()
    {
        self.slideMenuController()?.openLeft()
        
    }
    @objc func btnAnalyticAction()
    {

    }
    func getCustomerData() {
        
        ConfigManager.showLoadingHUD(to_view: self.view)
        
        var parameters = [String : AnyObject] ()
        
        parameters["MethodName"] = "customer_list" as AnyObject
        parameters["user_id"] = ConfigManager.gUserId as AnyObject        
        
        self.objWebServiceController?.serverParameter(parameters: parameters)
        
        
    }
    
    // MARK:  Tableview  delegate

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.searchActive == false {
            
            if self.arrCustomerData.count > 0 {
                
                return self.arrCustomerData.count;
                
            }
        }
        else
        {
            if self.arrCustomerSearchData.count > 0 {
                
                return self.arrCustomerSearchData.count;
                
            }
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
        
        var cell: CustomerListTableViewCell! = (tableView.dequeueReusableCell(withIdentifier: identifier) as? CustomerListTableViewCell?)!
        
        if cell == nil {
            
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CustomerListTableViewCell
        }
        
        var customerDic:NSDictionary!
        
        if self.searchActive == false {

            customerDic = self.arrCustomerData[indexPath.row] as! NSDictionary
        
        }
        else
        {
            customerDic = self.arrCustomerSearchData[indexPath.row] as! NSDictionary

        }
        
        
        var customerFName:String! = ""
        var customerLName:String! = ""
        
        if customerDic["first_name"] != nil {
            
            customerFName = customerDic["first_name"] as! String

        }
        if customerDic["last_name"] != nil {
            
            customerLName = customerDic["last_name"] as! String

        }

        
        let customerName:String! = customerLName + " " + customerFName

       // let customerName:String! = customerDic["name"] as! String
        
        cell.lblCustomerName.text = customerName
      
        
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var customerDic:NSDictionary!
        
        if self.searchActive == false {
            
            customerDic = self.arrCustomerData[indexPath.row] as! NSDictionary
            
        }
        else
        {
            customerDic = self.arrCustomerSearchData[indexPath.row] as! NSDictionary
            
        }
       // let customerDic = self.arrCustomerData[indexPath.row]
        
        print(customerDic)
        self.objAddNoteViewController = AddNoteViewController()
       self.objAddNoteViewController?.customerDic = customerDic as! [String : Any]
        self.objAddNoteViewController?.customerId = customerDic["id"] as! String

        self.navigationController?.pushViewController(self.objAddNoteViewController!, animated: true)

    }
    
    
    // MARK:  Webservice Bar delegate
    
  
    func serviceResponse(forURl urlString: String, response: JSON) {
        
        ConfigManager.hideLoadingHUD(for_view: self.view)
        
        if !(urlString == "server_error_handle") {
            
            
            if let resData = response["Customer"].arrayObject {
                
                self.arrCustomerData = (resData as NSArray).mutableCopy() as! NSMutableArray

            }
            
            if self.arrCustomerData.count > 0
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
   
    
    // MARK: UISearch bar delegate

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.searchActive = false
        self.tblView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.searchActive = true
        
        self.arrCustomerSearchData.removeAllObjects()
        let searchPredicate = NSPredicate(format: "(name CONTAINS [c] %@)", searchText)

        let arrays = (self.arrCustomerData).filtered(using: searchPredicate)
        print(arrays)
        self.arrCustomerSearchData = (arrays as NSArray).mutableCopy() as! NSMutableArray
        
        if searchBar.text == "" && searchText == "" {
            
            self.searchActive = false
            self.arrCustomerSearchData.removeAllObjects()
        }
        self.tblView.reloadData()

    }
    func  searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        //self.searchActive = true

    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.searchActive = true
        self.searchBar.resignFirstResponder()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        if (self.searchBar.text?.count)! > 0 {
            
            self.searchActive = true
        }
        self.searchBar.resignFirstResponder()
        
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
