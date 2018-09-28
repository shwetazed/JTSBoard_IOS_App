//
//  EmployeeListViewController.swift
//  JTSBoard
//
//  Created by jts on 09/08/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher

class EmployeeListViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,WebServiceControllerDelegate,UISearchBarDelegate {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var backSearchView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
   
    let identifier = "employeelistcell"
    var objWebServiceController: WebServiceController?
    var objEmployeeDetailViewController: EmployeeDetailViewController?
    var objAddEmployeeViewController: AddEmployeeViewController?
    var arrEmployeeList:NSMutableArray!
    var arrEmployeeSearchData:NSMutableArray!
    var searchActive:Bool = false
    var deleteIndex:Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 163/255, green: 125/255, blue: 30/255, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor =  UIColor.black

        self.arrEmployeeList = NSMutableArray()
        self.arrEmployeeSearchData = NSMutableArray()
        
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

        self.objWebServiceController = WebServiceController()
        self.objWebServiceController?.delegate = self
        
        if ConfigManager.IS_IPHONE()
        {
            self.tblView.register(UINib(nibName: "EmployeeListTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)

        }
        else
        {
            self.tblView.register(UINib(nibName: "EmployeeListTableViewCell_ipad", bundle: nil), forCellReuseIdentifier: identifier)

        }
        

        self.navigationItem.title = "従業員"
        
        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
        let menuButton = UIButton(type: .custom)
        menuButton.setImage(UIImage(named: "menu"), for: .normal) // Image can be downloaded from here below link
        menuButton.setTitle("", for: .normal)
        menuButton.addTarget(self, action: #selector(CustomerListViewController.btnMenuAction), for: .touchUpInside)
        menuButton.setTitleColor(UIColor.black, for: .normal)
       // self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
        // Do any additional setup after loading the view.
    }
    @objc func btnMenuAction()
    {
        self.slideMenuController()?.openLeft()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.searchBar.resignFirstResponder()
        self.searchActive = false
        self.searchBar.text = ""
        self.getEmployeeData()

    }
    func getEmployeeData() {
        
        ConfigManager.showLoadingHUD(to_view: self.view)
        
        var parameters = [String : AnyObject] ()
        
        parameters["MethodName"] = "employee_list" as AnyObject
        parameters["user_id"] = ConfigManager.gUserId as AnyObject
       
        self.objWebServiceController?.serverParameter(parameters: parameters)
        
        
    }
    
    // MARK:  Tableview Bar delegate

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.searchActive == false {
            
            if self.arrEmployeeList.count > 0 {
                
                return self.arrEmployeeList.count;
                
            }
        }
        else
        {
            if self.arrEmployeeSearchData.count > 0 {
                
                return self.arrEmployeeSearchData.count;
                
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
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        
        let dateId:String!
        
        if self.searchActive == false {
            
            dateId = ((self.arrEmployeeList.object(at: indexPath.row)) as! NSDictionary).object(forKey: "id") as? String

        }
        else
        {
            dateId = ((self.arrEmployeeSearchData.object(at: indexPath.row)) as! NSDictionary).object(forKey: "id") as? String

        }
        if dateId != "" {
            
            return true
        }
        else
        {
            return false
        }
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "削除") { (action, indexPath) in
            // delete item at indexPath
            
            self.deleteEmployee(deletedIndex: indexPath.row)
        }
        
        let edit = UITableViewRowAction(style: .normal, title: "編集") { (action, indexPath) in
            // share item at indexPath
            self.editEmployee(editedIndex: indexPath.row)
        }
        //delete.backgroundColor = UIColor(patternImage: UIImage(named: "delete_icon")!)
        // edit.backgroundColor = UIColor(patternImage: UIImage(named: "edit_icon")!)
        
        edit.backgroundColor = UIColor(red: 5/255, green: 105/255, blue: 189/255, alpha: 1.0)
        
        delete.backgroundColor = UIColor(red: 193/255, green: 44/255, blue: 14/255, alpha: 1.0)
        
        return [delete, edit]
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: EmployeeListTableViewCell! = (tableView.dequeueReusableCell(withIdentifier: identifier) as? EmployeeListTableViewCell?)!
        
        if cell == nil {
            
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? EmployeeListTableViewCell
        }
        
        var employeeDic:NSDictionary!
        
        if self.searchActive == false {
            
            employeeDic = self.arrEmployeeList[indexPath.row] as! NSDictionary
            
        }
        else
        {
            employeeDic = self.arrEmployeeSearchData[indexPath.row] as! NSDictionary
            
        }
        let empName:String! = employeeDic["name"] as! String
        let empPhone:String! = employeeDic["phone"] as! String
        let empDesignation:String! = employeeDic["designation"] as! String
        let imgUrl:String! = employeeDic["image"] as! String
        
        cell.lblName.text = empName
        cell.lblPhoneNumber.text = empPhone
        cell.lblDesignation.text = empDesignation
            
            
       
        var imgFullUrl:String! = ""

        if imgUrl != nil {
            
            imgFullUrl = ConfigManager.gImageUrl + imgUrl
            
            let url = URL(string: imgFullUrl)
            
            cell.imgView.kf.setImage(with: url)
        }
       
        
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var employeeDic:NSDictionary!
        
        if self.searchActive == false {
            
            print("false")
            print(self.arrEmployeeList.count)
            
            if indexPath.row < self.arrEmployeeList.count
            {
                employeeDic = self.arrEmployeeList[indexPath.row] as! NSDictionary

            }

            
        }
        else
        {
            print("true")
            print(self.arrEmployeeSearchData.count)

            if indexPath.row < self.arrEmployeeSearchData.count
            {
                employeeDic = self.arrEmployeeSearchData[indexPath.row] as! NSDictionary

            }

            
            
        }
        
        print(employeeDic)
        
        if employeeDic != nil
        {
            if employeeDic.count > 0
            {
                if ConfigManager.DeviceType.IS_IPAD {
                    
                    self.objEmployeeDetailViewController = EmployeeDetailViewController(nibName: "EmployeeDetailViewController_ipad", bundle: nil)
                }
                else
                {
                    self.objEmployeeDetailViewController = EmployeeDetailViewController(nibName: "EmployeeDetailViewController", bundle: nil)
                    
                }
                self.objEmployeeDetailViewController?.employeeId = employeeDic.object(forKey: "id") as! String
                self.objEmployeeDetailViewController?.arrEmployeeData = employeeDic
                self.navigationController?.pushViewController(self.objEmployeeDetailViewController!, animated: true)
            }
        }
        
        
        
      
    }
    func deleteEmployee(deletedIndex: Int)
    {
        ConfigManager.showLoadingHUD(to_view: self.view)
        
        var parameters = [String : AnyObject] ()
        
        self.deleteIndex = deletedIndex ;
        
        parameters["MethodName"] = "delete_employee" as AnyObject
       
        if self.searchActive == false {
            
            parameters["id"] = ((self.arrEmployeeList.object(at: deletedIndex)) as! NSDictionary).object(forKey: "id") as? String as AnyObject
        }
        else
        {
            parameters["id"] = ((self.arrEmployeeSearchData.object(at: deletedIndex)) as! NSDictionary).object(forKey: "id") as? String as AnyObject

        }
        self.objWebServiceController?.serverParameter(parameters: parameters)
        
    }
    func editEmployee(editedIndex: Int)
    {
        var employeeDic:NSDictionary!
        
        if self.searchActive == false {
            
            employeeDic = self.arrEmployeeList[editedIndex] as! NSDictionary
            
        }
        else
        {
            employeeDic = self.arrEmployeeSearchData[editedIndex] as! NSDictionary
            
        }
        
        print(employeeDic)
        
        if ConfigManager.DeviceType.IS_IPAD {

            self.objAddEmployeeViewController = AddEmployeeViewController(nibName: "AddEmployeeViewController_ipad", bundle: nil)

        }
        else
        {
            self.objAddEmployeeViewController = AddEmployeeViewController(nibName: "AddEmployeeViewController", bundle: nil)

        }
        self.objAddEmployeeViewController?.employeeId = employeeDic.object(forKey: "id") as! String
        self.objAddEmployeeViewController?.arrEmployeeData = employeeDic
        self.navigationController?.pushViewController(self.objAddEmployeeViewController!, animated: true)
    }
    // MARK:  Webservice Bar delegate

    func serviceResponse(forURl urlString: String, response: JSON) {
        
        ConfigManager.hideLoadingHUD(for_view: self.view)
        
        if !(urlString == "server_error_handle") {
            
            if urlString == "employee_list"
            {
                self.arrEmployeeList.removeAllObjects()
                
                if let resData = response["Employee"].arrayObject {
                    
                    self.arrEmployeeList = (resData as NSArray).mutableCopy() as! NSMutableArray
                    
                }
                
                if self.arrEmployeeList.count > 0
                {
                    self.tblView.reloadData()
                }
            }
            else if urlString == "delete_employee"
            {
                let status:String! = String(describing:response["status"])
                
                if status == "success"
                {
                    self.arrEmployeeList.removeObject(at: self.deleteIndex);
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
    @IBAction func btnAddEmployeeAction(_ sender: UIButton) {
        
        
        if ConfigManager.DeviceType.IS_IPAD {
            
            self.objAddEmployeeViewController = AddEmployeeViewController(nibName: "AddEmployeeViewController_ipad", bundle: nil)
            
        }
        else
        {
            self.objAddEmployeeViewController = AddEmployeeViewController(nibName: "AddEmployeeViewController", bundle: nil)
            
        }
        self.objAddEmployeeViewController?.employeeId = ""
        self.navigationController?.pushViewController(self.objAddEmployeeViewController!, animated: true)
    }
   /* // MARK:  Textfield  delegate

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString searchText: String) -> Bool {
        
        self.searchActive = true
        
        self.arrEmployeeSearchData.removeAllObjects()
        let searchPredicate = NSPredicate(format: "(name CONTAINS [c] %@)", searchText)
        
        let arrays = (self.arrEmployeeList).filtered(using: searchPredicate)
        print(arrays)
        self.arrEmployeeSearchData = (arrays as NSArray).mutableCopy() as! NSMutableArray
        
       /* if textField.text?.count == 1  && searchText == "" {
            
            self.searchActive = false
            self.txtSearch.resignFirstResponder()
        }*/
        self.tblView.reloadData()
        
        return true
        
    }*/
    
    // MARK: UISearch bar delegate
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.searchActive = false
        self.tblView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.searchActive = true
        
        self.arrEmployeeSearchData.removeAllObjects()
        let searchPredicate = NSPredicate(format: "(name CONTAINS [c] %@)", searchText)
        
        let arrays = (self.arrEmployeeList).filtered(using: searchPredicate)
        print(arrays)
        self.arrEmployeeSearchData = (arrays as NSArray).mutableCopy() as! NSMutableArray
        
        if searchBar.text == "" && searchText == "" {
            
            self.searchActive = false
        }
        self.tblView.reloadData()
        
    }
    func  searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
      //  self.searchActive = true
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if (self.searchBar.text?.count)! > 0 {
            
            self.searchActive = true
        }
        self.searchBar.resignFirstResponder()

        
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
