//
//  CustomerDetailViewController.swift
//  JTSBoard
//
//  Created by jts on 10/07/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit

class CustomerDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var objServiceDetailViewController: ServiceDetailViewController?
    var objAddNoteViewController: AddNoteViewController?
    var objAddFormViewController: AddFormViewController?
    var objServiceListViewController: ServiceListViewController?

    @IBOutlet weak var tblView: UITableView!
    var customerDic = [String:Any]()
    let identifier = "servicedetailcell"

    var arrTitleList:NSMutableArray! = NSMutableArray()
    var arrValueList:NSMutableArray! = NSMutableArray()

    var howcomeStr:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblView.register(UINib(nibName: "ServiceDetailTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        
        self.setTitleArrayValue()
        self.setArrayValue()
        
        self.tblView.reloadData()
        
        print(self.customerDic)
        
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
//        let addbutton = UIButton(type: .contactAdd)
//        addbutton.addTarget(self, action: #selector(CustomerDetailViewController.btnAddNoteAction), for: .touchUpInside)
//        addbutton.setTitleColor(UIColor.black, for: .normal)
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addbutton)

       // self.setCustomerData()
        // Do any additional setup after loading the view.
     
        // Do any additional setup after loading the view.
        
      
    }
   
    @objc func btnAddNoteAction()
    {
        self.objAddNoteViewController = AddNoteViewController(nibName: "AddNoteViewController", bundle: nil)
        self.objAddNoteViewController?.customerId = customerDic["id"] as! String
        self.navigationController?.pushViewController(self.objAddNoteViewController!, animated: true)
        
    }

    func setTitleArrayValue()
    {
       // self.arrTitleList.add("名前") // name
        self.arrTitleList.add("姓") // last name
        self.arrTitleList.add("名") // first name
        
        self.arrTitleList.add("カナ") // kana
        self.arrTitleList.add("姓") // last name
        self.arrTitleList.add("名") // first name
        
        self.arrTitleList.add("性別") // Gender
        self.arrTitleList.add("誕生日") // Birthday
        self.arrTitleList.add("電話番号") // phone
        self.arrTitleList.add("郵便番号") // zipcode
        self.arrTitleList.add("都道府県") // prefecture
        self.arrTitleList.add("市町村") //city
        self.arrTitleList.add("住所") // street name
        self.arrTitleList.add("アパート・マンション名") // apartment
        self.arrTitleList.add("メール") // email
        self.arrTitleList.add("お得な情報を受取る") // news subscription
        self.arrTitleList.add("職業") // job
        self.arrTitleList.add("どうしてこのサロンを知りましたか？") // about company
        self.arrTitleList.add("何でサロンまでお越しになられましたか？") // how come
        self.arrTitleList.add("本日のコース") // service name
    }
    func setArrayValue()
    {
       // self.arrValueList.add(self.customerDic["name"] as Any) // name
        self.arrValueList.add(self.customerDic["last_name"] as Any) // last name
        self.arrValueList.add(self.customerDic["first_name"] as Any) // first name
        
        self.arrValueList.add(self.customerDic["kana"] as Any) // kana
        self.arrValueList.add(self.customerDic["kana_last_name"] as Any) // last name
        self.arrValueList.add(self.customerDic["kana_first_name"] as Any) // first name
        
        self.arrValueList.add(self.customerDic["gender"] as Any) // Gender
        self.arrValueList.add(self.customerDic["dob"] as Any) // Birthday
        self.arrValueList.add(self.customerDic["tel"] as Any) // phone
        self.arrValueList.add(self.customerDic["zip_code"] as Any) // zipcode
        self.arrValueList.add(self.customerDic["prefecture"] as Any) // prefecture
        self.arrValueList.add(self.customerDic["city"] as Any) //city
        self.arrValueList.add(self.customerDic["address1"] as Any) // street name
        self.arrValueList.add(self.customerDic["address2"] as Any) // apartment
        self.arrValueList.add(self.customerDic["email"] as Any) // email
        self.arrValueList.add(self.customerDic["subscription_of_news"] as Any) // news subscription
        self.arrValueList.add(self.customerDic["job"] as Any) // job
        self.arrValueList.add(self.customerDic["know_about_company"] as Any) // about company
        self.arrValueList.add(self.customerDic["how_did_you_come"] as Any) // how come
        self.arrValueList.add(self.customerDic["service_name"] as Any) // service name
    }
 
    // MARK:  Webservice Bar delegate

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.arrTitleList.count > 0 {
            
            return self.arrTitleList.count;
            
        }
        return 0;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: ServiceDetailTableViewCell! = (tableView.dequeueReusableCell(withIdentifier: identifier) as? ServiceDetailTableViewCell?)!
        
        if cell == nil {
            
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? ServiceDetailTableViewCell
        }
        
        print(self.arrTitleList.object(at: indexPath.row))
        
        cell.lblTitle.text = self.arrTitleList.object(at: indexPath.row) as? String
        cell.lblValue.text = self.arrValueList.object(at: indexPath.row) as? String
        
        if indexPath.row == self.arrTitleList.count - 1 {
            
            cell.lblTitle.text = "サービス"

            
            if customerDic["service_id"] as! String != "1"
            {
                cell.accessoryType = .detailButton

            }
            else
            {
                cell.accessoryType = .none

            }
            
        }
        else
        {
            cell.accessoryType = .none

        }

        return cell
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == self.arrTitleList.count - 1 {

            self.objServiceListViewController = ServiceListViewController()
            self.objServiceListViewController?.customerId = customerDic["id"] as! String as NSString
            self.navigationController?.pushViewController(self.objServiceListViewController!, animated: true)

            
          /*  if customerDic["service_id"] as! String != "1"
            {
                self.objServiceDetailViewController = ServiceDetailViewController(nibName: "ServiceDetailViewController", bundle: nil)
                self.objServiceDetailViewController?.customerId = customerDic["id"] as! String
                self.objServiceDetailViewController?.serviceId = customerDic["service_id"] as! String
                
                self.navigationController?.pushViewController(self.objServiceDetailViewController!, animated: true)
            }*/
           
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
