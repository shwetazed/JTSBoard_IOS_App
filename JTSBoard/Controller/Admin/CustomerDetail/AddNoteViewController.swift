//
//  AddNoteViewController.swift
//  JTSBoard
//
//  Created by jts on 01/08/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit
import SwiftyJSON

class AddNoteViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,WebServiceControllerDelegate  {

    @IBOutlet weak var tblDate: UITableView!
    
    @IBOutlet weak var btnAddDate: UIButton!

    var arrDateList:NSMutableArray! = NSMutableArray()

    var objNoteDetailViewController: NoteDetailViewController?
    var objWebServiceController: WebServiceController?
    var objCustomerDetailViewController: CustomerDetailViewController?

    let dateIdentifier = "adddatecell"
    var customerId:String!
    var deleteIndex:Int!
    var customerDic = [String:Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.objWebServiceController = WebServiceController()
        self.objWebServiceController?.delegate = self
        self.tblDate.register(UITableViewCell.self, forCellReuseIdentifier: dateIdentifier)
        
        
        var customerFName:String! = ""
        var customerLName:String! = ""
        
        if customerDic["first_name"] != nil {
            
            customerFName = customerDic["first_name"] as! String
            
        }
        if customerDic["last_name"] != nil {
            
            customerLName = customerDic["last_name"] as! String
            
        }
        
        
        let customerName:String! = customerLName + " " + customerFName
        
        self.navigationItem.title = customerName

        
        let addButton = UIButton(type: .custom)
        addButton.setImage(UIImage(named: "customer-info"), for: .normal) // Image can be downloaded from here below link
        addButton.setTitle("", for: .normal)
        addButton.addTarget(self, action: #selector(AddNoteViewController.btnAddAction), for: .touchUpInside)
        addButton.setTitleColor(UIColor.black, for: .normal)
       
        if ConfigManager.DeviceType.IS_IPAD || ConfigManager.gEmployeeRole == "1" || ConfigManager.gEmployeeRole == "2"
        {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)

        }
       
        
        
        // Do any additional setup after loading the view.
    }
    @objc func btnAddAction()
    {
        if ConfigManager.gCustomerPinNumber == ""
        {
            self.objCustomerDetailViewController = CustomerDetailViewController(nibName: "CustomerDetailViewController", bundle: nil)
            self.objCustomerDetailViewController?.customerDic = customerDic
            self.navigationController?.pushViewController(self.objCustomerDetailViewController!, animated: true)

        }
        else
        {
            if ConfigManager.DeviceType.IS_IPAD
            {
                self.moveToCustomerDetailView()
            }
            else
            {
                if ConfigManager.gEmployeeRole == "2"
                {
                    self.moveToCustomerDetailView()

                }
                else
                {
                    self.objCustomerDetailViewController = CustomerDetailViewController(nibName: "CustomerDetailViewController", bundle: nil)
                    self.objCustomerDetailViewController?.customerDic = self.customerDic
                    self.navigationController?.pushViewController(self.objCustomerDetailViewController!, animated: true)
                }
            }

        }
     
    }
    func moveToCustomerDetailView()
    {
        let titlePrompt = UIAlertController(title: "JTS",
                                            message: "パスワードを入力してください",
                                            preferredStyle: .alert)
        
        var titleTextField: UITextField?
        titlePrompt.addTextField { (textField) -> Void in
            titleTextField = textField
            textField.placeholder = "パスワード"
            textField.keyboardType = .numberPad
            titleTextField?.isSecureTextEntry = true
            
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .default, handler: nil)
        
        titlePrompt.addAction(cancelAction)
        
        titlePrompt.addAction(UIAlertAction(title: "送信", style: .destructive, handler: { (action) -> Void in
            if let textField = titleTextField {
                
                if textField.text! == ConfigManager.gCustomerPinNumber!
                {
                    self.objCustomerDetailViewController = CustomerDetailViewController(nibName: "CustomerDetailViewController", bundle: nil)
                    self.objCustomerDetailViewController?.customerDic = self.customerDic
                    self.navigationController?.pushViewController(self.objCustomerDetailViewController!, animated: true)
                    
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
    override func viewWillAppear(_ animated: Bool) {
    
        self.arrDateList.removeAllObjects()
    
        self.getCustomerDateList()

    }
    @IBAction func btnAddDateAction(_ sender: UIButton) {
   
        
        
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
       
            // self.arrDateList.add(formatter.string(from: currentDate))
            var parameters = [String : Any] ()
            
            parameters["date"] = formatter.string(from: currentDate)
            parameters["id"] = ""
        
        var isDateExist = false
        
          for i in 0..<self.arrDateList.count {
            
            let date = ((self.arrDateList.object(at: i)) as! NSDictionary).object(forKey: "date") as! String
            
            print(date)
            
            if date == formatter.string(from: currentDate)
            {
                isDateExist = true
                break
            }
        
            
        }
        if isDateExist == false {
            
            //self.arrDateList.insert(parameters, at: 0)
            self.arrDateList.add(parameters)
            self.tblDate.isHidden = false
            self.tblDate.reloadData()
            print(self.arrDateList)
        }
        else
        {
            let alert = UIAlertController(title: "", message: "日付は既に存在します", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
       

       // self.datePickerTapped()


    }
   func getCustomerDateList()
   {
    ConfigManager.showLoadingHUD(to_view: self.view)
    
    var parameters = [String : AnyObject] ()
    
    parameters["MethodName"] = "get_customer_analysis_dates" as AnyObject
    parameters["user_id"] = ConfigManager.gUserId as AnyObject
    parameters["customer_id"] = self.customerId as AnyObject

    self.objWebServiceController?.serverParameter(parameters: parameters)
    
   }
   
    // MARK:  Tableview  delegate

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrDateList.count
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60;
      
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tblDate.dequeueReusableCell(withIdentifier: dateIdentifier)!

        cell.textLabel?.text = ((self.arrDateList.object(at: indexPath.row)) as! NSDictionary).object(forKey: "date") as? String
            return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
       // self.objNoteDetailViewController = NoteDetailViewController(nibName: "NoteDetailViewController", bundle: nil)
       // self.navigationController?.pushViewController(self.objNoteDetailViewController!, animated: true)

        ConfigManager.showLoadingHUD(to_view: self.view)
        self.perform(#selector(moveToView), with: indexPath, afterDelay: 0.0)
    }
    @objc func moveToView(indexPath:NSIndexPath)
    {
        
        let dict:NSDictionary! = self.arrDateList.object(at: indexPath.row) as! NSDictionary
        
        self.objNoteDetailViewController = NoteDetailViewController(nibName: "NoteDetailViewController", bundle: nil)
        self.objNoteDetailViewController?.customerId = self.customerId
        
        print(dict.object(forKey: "date") as? String as Any)
        
        self.objNoteDetailViewController?.currentDate = dict.object(forKey: "date") as? String
        
        let dateId = dict.object(forKey: "id") as? String
        
        if dateId != "" {
            
            self.objNoteDetailViewController?.dateId = dateId
            
        }
        else
        {
            self.objNoteDetailViewController?.dateId = ""

        }
        ConfigManager.hideLoadingHUD(for_view: self.view)
        self.navigationController?.pushViewController(self.objNoteDetailViewController!, animated: true)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        let dateId = ((self.arrDateList.object(at: indexPath.row)) as! NSDictionary).object(forKey: "id") as? String
        
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
            
            self.deleteNote(deletedIndex: indexPath.row)
        }
        
        let edit = UITableViewRowAction(style: .normal, title: "編集") { (action, indexPath) in
            // share item at indexPath
            self.editNote(editedIndex: indexPath.row)
        }
        //delete.backgroundColor = UIColor(patternImage: UIImage(named: "delete_icon")!)
       // edit.backgroundColor = UIColor(patternImage: UIImage(named: "edit_icon")!)

        edit.backgroundColor = UIColor(red: 5/255, green: 105/255, blue: 189/255, alpha: 1.0)

        delete.backgroundColor = UIColor(red: 193/255, green: 44/255, blue: 14/255, alpha: 1.0)
        
        return [delete, edit]
    }
    // MARK:  Webservice  delegate

    func deleteNote(deletedIndex: Int)
    {
        ConfigManager.showLoadingHUD(to_view: self.view)
        
        var parameters = [String : AnyObject] ()
        
        self.deleteIndex = deletedIndex ;
        
        parameters["MethodName"] = "delete_customer_analysis_dates" as AnyObject
        parameters["user_id"] = ConfigManager.gUserId as AnyObject
        parameters["customer_id"] = self.customerId as AnyObject
        parameters["id"] = ((self.arrDateList.object(at: deletedIndex)) as! NSDictionary).object(forKey: "id") as? String as AnyObject
        self.objWebServiceController?.serverParameter(parameters: parameters)

    }
    func editNote(editedIndex: Int)
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
                                let dateId = ((self.arrDateList.object(at: editedIndex)) as! NSDictionary).object(forKey: "id") as? String
                                
                                ConfigManager.showLoadingHUD(to_view: self.view)
                                
                                var parameters = [String : AnyObject] ()
                                
                                parameters["MethodName"] = "edit_customer_analysis_date" as AnyObject
                                parameters["id"] = dateId as AnyObject
                                parameters["date"] = dobStr as AnyObject
                                parameters["user_id"] = ConfigManager.gUserId as AnyObject
                                parameters["customer_id"] = self.customerId as AnyObject
                                self.objWebServiceController?.serverParameter(parameters: parameters)

                            }
        }
       
    }
    func serviceResponse(forURl urlString: String, response: JSON) {
        
        ConfigManager.hideLoadingHUD(for_view: self.view)
        
        if !(urlString == "server_error_handle") {
            
            if urlString == "get_customer_analysis_dates"
            {
                if let resData = response.arrayObject {
                    
                    self.arrDateList = (resData as NSArray).mutableCopy() as! NSMutableArray
                }
                
                
                    self.tblDate.reloadData()
                
            }
            else if urlString == "delete_customer_analysis_dates"
            {
                let status:String! = String(describing:response["status"])

                if status == "success"
                {
                    self.arrDateList.removeObject(at: self.deleteIndex);
                    self.tblDate.reloadData()

                }
            }
            else if urlString == "edit_customer_analysis_date"
            {
                let status:String! = String(describing:response["status"])
                let msg:String! = String(describing:response["msg"])
                
                if msg != nil
                {
                    let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    
                }
                if status != nil
                {
                    if status == "success"
                    {
                        self.arrDateList.removeAllObjects()
                        self.getCustomerDateList()
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func serviceImageResponse(forURl urlString: String, response: NSDictionary) {
        
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
