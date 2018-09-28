//
//  AttendanceViewController.swift
//  JTSBoard
//
//  Created by jts on 09/08/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit
import SwiftyJSON

class AttendanceViewController: UIViewController, WebServiceControllerDelegate {

    @IBOutlet weak var btnThumb: UIButton!
    var objWebServiceController: WebServiceController?

    @IBOutlet weak var lblMessage: UILabel!
    
    var empCode:String!
    var checkinStatus:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.objWebServiceController = WebServiceController()
        self.objWebServiceController?.delegate = self
        
        self.btnThumb.layer.cornerRadius = 5.0
        self.btnThumb.clipsToBounds = true
        
        if self.checkinStatus == "1"
        {
            self.btnThumb.setTitle("出勤", for: .normal)
        }
        else
        {
            self.btnThumb.setTitle("退勤", for: .normal)

        }
        // Do any additional setup after loading the view.
    }
    @IBAction func btnThumbAction(_ sender: UIButton) {
        
        if self.empCode != nil {
            
            self.addAttandance(empCode: self.empCode)

        }
        /**/
    }
    func addAttandance(empCode : String){

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateStr:String! = formatter.string(from: Date())
        
        let formatterTime = DateFormatter()
        formatterTime.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timeStr:String! = formatterTime.string(from: Date())
        
        ConfigManager.showLoadingHUD(to_view: self.view)
        
        var parameters = [String : AnyObject] ()
        
        parameters["MethodName"] = "add_attendance" as AnyObject
        parameters["emp_code"] = empCode as AnyObject
        parameters["date_time"] = timeStr as AnyObject
        parameters["date"] = dateStr as AnyObject

        parameters["user_id"] = ConfigManager.gUserId as AnyObject
        
        self.objWebServiceController?.serverParameter(parameters: parameters)
    }
    // MARK:  Webservice Bar delegate

    func serviceResponse(forURl urlString: String, response: JSON) {
        
        ConfigManager.hideLoadingHUD(for_view: self.view)
        
        if !(urlString == "server_error_handle") {
            
            if urlString == "add_attendance"
            {
                let status:String! = String(describing:response["status"])
                let msg:String! = String(describing:response["msg"])
                
                if msg != nil
                {
                    self.lblMessage.text = msg

                }
                
                if status == "success"
                {
                    if self.checkinStatus == "1"
                    {
                        self.btnThumb.setTitle("退勤", for: .normal)
                    }
                    else
                    {
                        self.btnThumb.setTitle("出勤", for: .normal)

                    }
                }
                
                let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                self.dismiss(animated: true) {
                
                    self.navigationController?.popViewController(animated: true)
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
