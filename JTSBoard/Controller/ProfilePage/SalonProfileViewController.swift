//
//  SalonProfileViewController.swift
//  JTSBoard
//
//  Created by jts on 10/07/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SalonProfileViewController: UIViewController,WebServiceControllerDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var btnHoliday: UIButton!
    @IBOutlet weak var txtSalonOwnerName: FloatLabelTextField!
    
    @IBOutlet weak var txtSalonatName: FloatLabelTextField!
    @IBOutlet weak var txtEmail: FloatLabelTextField!
    
    @IBOutlet weak var txtZipCode: FloatLabelTextField!
    @IBOutlet weak var txtPrefecture: FloatLabelTextField!
    @IBOutlet weak var txtCity: FloatLabelTextField!
    @IBOutlet weak var txtStreetName: FloatLabelTextField!
    @IBOutlet weak var txtApartmentName: FloatLabelTextField!
    
    @IBOutlet weak var txtPhoneNumber: FloatLabelTextField!
    @IBOutlet weak var txtWebsiteUrl: FloatLabelTextField!
    @IBOutlet weak var txtEmployeeNumber: FloatLabelTextField!
    @IBOutlet weak var txtAdvertisement: FloatLabelTextField!
    @IBOutlet weak var txtAverageNumber: FloatLabelTextField!
    
    @IBOutlet weak var txtWeekend: FloatLabelTextField!
    @IBOutlet weak var txtStartDate: FloatLabelTextField!

    
    var navigation: TopNavigationView?
    var objWebServiceController: WebServiceController?
    var objEditProfileViewController: EditProfileViewController?
    var objHolidaysListViewController: HolidaysListViewController?

    var userDic = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "プロフィール"
        
        self.objWebServiceController = WebServiceController()
        self.objWebServiceController?.delegate = self
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 163/255, green: 125/255, blue: 30/255, alpha: 1.0)
        self.navigationController?.navigationBar.tintColor =  UIColor.black
        
        
        
        // Do any additional setup after loading the view.
        let editButton = UIButton(type: .custom)
        editButton.setImage(UIImage(named: "edit_profile_icon"), for: .normal) // Image can be downloaded from here below link
        editButton.setTitle("", for: .normal)
        editButton.addTarget(self, action: #selector(SalonProfileViewController.btnEditProfileAction), for: .touchUpInside)
        editButton.setTitleColor(UIColor.black, for: .normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editButton)
        // Do any additional setup after loading the view.
        let menuButton = UIButton(type: .custom)
        menuButton.setImage(UIImage(named: "menu"), for: .normal) // Image can be downloaded from here below link
        menuButton.setTitle("", for: .normal)
        menuButton.addTarget(self, action: #selector(SalonProfileViewController.btnMenuAction), for: .touchUpInside)
        menuButton.setTitleColor(UIColor.black, for: .normal)
      //  self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
        // Do any additional setup after loading the view.
    }
    @objc func btnMenuAction()
    {
        self.slideMenuController()?.openLeft()
        
    }
    @objc func btnEditProfileAction()
    {
        self.objEditProfileViewController = EditProfileViewController()
        self.navigationController?.pushViewController(self.objEditProfileViewController!, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        
        //self.navigationItem.setHidesBackButton(true, animated:true);
        self.getUserProfileData()

    }
    
    
    
    
    func setNavigation() {
        
        navigation = TopNavigationView(frame: CGRect(x: 0, y: 0, width: (ConfigManager.sharedAppDelegate.window?.frame.size.width)!, height: 60), withRef: self, navController: navigationController!, vController: view)
        navigation?.lblTitle?.isHidden = false
        var mImg: UIImage? = nil
        let tImg: UIImage? = nil
        
        mImg = ConfigManager.filledImageFrom(source: UIImage(named: "back_arrow")!, fillColor: UIColor.white)
        navigation?.menuButton?.setImage(mImg, for: .normal)
        navigation?.menuButton?.addTarget(self, action: #selector(self.btnBackPressed), for: .touchUpInside)
        
        navigation?.btnTV?.setImage(tImg, for: .normal)
        navigation?.btnTV.titleLabel?.text = "LOGIN"
        
        navigation?.lblTitle?.text = "Sign Up"
        view.addSubview(navigation!)
        
    }
    @IBAction func btnBackPressed(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    func getUserProfileData() {
        
        ConfigManager.showLoadingHUD(to_view: self.view)
        
        var parameters = [String : AnyObject] ()
        
        parameters["MethodName"] = "user_profile" as AnyObject
        parameters["user_id"] = ConfigManager.gUserId as AnyObject

       // parameters["salon_id"] = ConfigManager.gSalonId as AnyObject
        
        self.objWebServiceController?.serverParameter(parameters: parameters)
        
        
    }
    
    // MARK: Webservice delegate

    func serviceResponse(forURl urlString: String, response: JSON) {
        
        ConfigManager.hideLoadingHUD(for_view: self.view)
        
        if !(urlString == "server_error_handle") {
            
            let dic = response["User"].dictionaryObject
            
            if dic != nil
            {
                self.userDic = dic!
                self.setUserData()
            }
            
            
        }
        else {
            let alert = UIAlertController(title: "", message: "Error", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    func setUserData()
    {
        self.txtSalonOwnerName.text = self.userDic["name"] as? String

        self.txtSalonatName.text = self.userDic["salon_name"] as? String
        self.txtEmail.text = self.userDic["email"] as? String
        self.txtZipCode.text = self.userDic["zip_code"] as? String
        self.txtPrefecture.text = self.userDic["prefecture"] as? String
        self.txtCity.text = self.userDic["city"] as? String
        self.txtStreetName.text = self.userDic["address1"] as? String
        self.txtApartmentName.text = self.userDic["address2"] as? String
        self.txtPhoneNumber.text = self.userDic["tel"] as? String
        self.txtWebsiteUrl.text = self.userDic["website"] as? String
        self.txtEmployeeNumber.text = self.userDic["employee_number"] as? String
        self.txtAdvertisement.text = self.userDic["advertisement"] as? String
        self.txtAverageNumber.text = self.userDic["avr_customer"] as? String
        self.txtStartDate.text = self.userDic["month_start_date"] as? String
        self.txtWeekend.text = self.userDic["weekend"] as? String
        
        ConfigManager.gEmployeePinNumber = self.userDic["employee_pin_number"] as? String
        ConfigManager.gCustomerPinNumber = self.userDic["customer_pin_number"] as? String
       
        UserDefaults.standard.set(ConfigManager.gEmployeePinNumber, forKey: "EMP_PIN_NUM")
        UserDefaults.standard.set(ConfigManager.gCustomerPinNumber, forKey: "CUST_PIN_NUM")

        
    }
    @IBAction func btnHolidayAction(_ sender: Any) {
        
        self.objHolidaysListViewController = HolidaysListViewController()
        self.navigationController?.pushViewController(self.objHolidaysListViewController!, animated: true)
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
