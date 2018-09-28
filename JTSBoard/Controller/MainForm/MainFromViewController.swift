//
//  MainFromViewController.swift
//  JTSBoard
//
//  Created by jts on 03/07/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit
import SwiftyJSON

class MainFromViewController: UIViewController,WebServiceControllerDelegate,UITextFieldDelegate {

    var objEstheServiceViewController:EstheServiceViewController!
    var objEyeLastServiceViewController:EyeLastServiceViewController!
    var objBodyServiceViewController:BodyServiceViewController!
    var objHairRemovalServiceViewController:HairRemovalServiceViewController!
    var objThankYouPageViewController: ThankYouPageViewController?
    var objPhotoFacialViewController: PhotoFacialViewController!

    @IBOutlet var imgBottomJob: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtKana: FloatLabelTextField!
    @IBOutlet weak var txtName: FloatLabelTextField!
    @IBOutlet weak var txtDob: FloatLabelTextField!
    @IBOutlet weak var txtAge: FloatLabelTextField!
    @IBOutlet weak var txtPhoneNumber: FloatLabelTextField!
    @IBOutlet weak var txtPostalCode: FloatLabelTextField!
    @IBOutlet weak var txtEmail: FloatLabelTextField!
    
    @IBOutlet weak var txtFirstName: FloatLabelTextField!
    @IBOutlet weak var txtLastName: FloatLabelTextField!
    @IBOutlet weak var txtKanaLastName: FloatLabelTextField!
    @IBOutlet weak var txtKanaFirstName: FloatLabelTextField!
    
    @IBOutlet weak var txtPrefecture: FloatLabelTextField!
    @IBOutlet weak var txtCity: FloatLabelTextField!
    @IBOutlet weak var txtApartment: FloatLabelTextField!
    @IBOutlet weak var txtStreetName: FloatLabelTextField!

    @IBOutlet weak var txtJob: FloatLabelTextField!

    @IBOutlet weak var txtHowCome: FloatLabelTextField!
    
    @IBOutlet var howComeHeight: NSLayoutConstraint!
    @IBOutlet weak var btnGenderMen: UIButton!
    @IBOutlet weak var btnGenderWomen: UIButton!
    @IBOutlet weak var btnCanSendNewsLetterYes: UIButton!
    @IBOutlet weak var btnCanSendNewsLetterNo: UIButton!
    @IBOutlet weak var btnHouseWifeYes: UIButton!
    @IBOutlet weak var btnHouseWifeNo: UIButton!
    @IBOutlet weak var btnHowHeardNewsLetter: UIButton!
    @IBOutlet weak var btnHowHeardISpot: UIButton!
    @IBOutlet weak var btnHowHeardSpark: UIButton!
    @IBOutlet weak var btnHowHeardIntroduce: UIButton!
    @IBOutlet weak var btnHowHeardWebsite: UIButton!
    @IBOutlet weak var btnHowHeardOthers: UIButton!
    
    @IBOutlet weak var btnJobPartTime: UIButton!
    @IBOutlet weak var btnJobStudent: UIButton!
    @IBOutlet weak var btnJobEmployee: UIButton!
    @IBOutlet weak var btnJobSelfEmployee: UIButton!
    @IBOutlet weak var btnJobCompanyOfficer: UIButton!
    @IBOutlet weak var btnJobOther: UIButton!
    
    @IBOutlet weak var btnJobHouseWife: UIButton!
    @IBOutlet weak var btnHowComeCar: UIButton!
    @IBOutlet weak var btnHowComeTaxi: UIButton!
    @IBOutlet weak var btnHowComeTrain: UIButton!
    @IBOutlet weak var btnHowComeBycycle: UIButton!
    @IBOutlet weak var btnHowComeWalk: UIButton!
    @IBOutlet weak var btnHowComeAnother: UIButton!

    @IBOutlet weak var btnTodayCourseNail: UIButton!
    @IBOutlet weak var btnTodayCourseEsthe: UIButton!
    @IBOutlet weak var btnTodayCourseEyelast: UIButton!
    @IBOutlet weak var btnTodayCourseBody: UIButton!
    @IBOutlet weak var btnTodayCourseHairRemoval: UIButton!
    
    @IBOutlet weak var btnPhotoFacial: UIButton!
    
  
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var txtIntroduceDesc: FloatLabelTextField!
    
    var genderStr:String! = ""
    var canSendNewsLetterStr:String! = ""
    var areYouHouseWifeStr:String! = ""
    var howHeardStr:String! = ""
    var howComeStr:String! = ""
    var todayCourseStr:String! = ""
    var jobStr:String! = ""
    var customerDic = [String:Any]()

    var objWebServiceController: WebServiceController?
    
    var selectedTextfield:UITextField!
    
    let btnKeypadReturn = UIButton(type: UIButtonType.custom)

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // self.navigationItem.leftBarButtonItem?.title = "利用規約"
        
//        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back_icon")
//        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back_icon")
//        self.navigationController?.navigationItem.backBarButtonItem?.title = "dsdsg"
        
        self.navigationController?.navigationBar.tintColor = UIColor.black

        self.howComeHeight.constant = 0

        self.txtIntroduceDesc.text = ""
        self.navigationItem.title = "JTS"
        
        self.btnSubmit.layer.cornerRadius = 5.0
        self.btnSubmit.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTapFrom))
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 163/255, green: 125/255, blue: 30/255, alpha: 1.0)
        
        if ConfigManager.IS_IPHONE() {
            
            self.btnKeypadReturn.setTitle("Return", for: UIControlState())
            self.btnKeypadReturn.setTitleColor(UIColor.black, for: UIControlState())
            self.btnKeypadReturn.frame = CGRect(x: 0, y: 163, width: 106, height: 53)
            self.btnKeypadReturn.adjustsImageWhenHighlighted = false
            self.btnKeypadReturn.addTarget(self, action: #selector(self.Done(_:)), for: UIControlEvents.touchUpInside)

            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        }
        
       /*if self.customerDic != nil
       {
        if self.customerDic.count > 0
        {
            self.setCustomerData()
        }
        
        }*/

        // Do any additional setup after loading the view.
//        let menuButton = UIButton(type: .custom)
//        menuButton.setImage(UIImage(named: "menu"), for: .normal) // Image can be downloaded from here below link
//        menuButton.setTitle("", for: .normal)
//        menuButton.addTarget(self, action: #selector(CustomerListViewController.btnMenuAction), for: .touchUpInside)
//        menuButton.setTitleColor(UIColor.black, for: .normal)
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
        // Do any additional setup after loading the view.
    }
    
    @objc func btnMenuAction()
    {
        self.slideMenuController()?.openLeft()
        
    }
    func setCustomerData()
    {
        self.txtLastName.text = self.customerDic["last_name"] as? String
        self.txtFirstName.text = self.customerDic["first_name"] as? String
        self.txtKanaLastName.text = self.customerDic["kana_last_name"] as? String
        self.txtKanaFirstName.text = self.customerDic["kana_first_name"] as? String
        self.txtDob.text = self.customerDic["dob"] as? String
        self.txtAge.text = self.customerDic["age"] as? String
        self.txtCity.text = self.customerDic["city"] as? String
        self.txtPostalCode.text = self.customerDic["zip_code"] as? String
        self.txtPhoneNumber.text = self.customerDic["tel"] as? String
        self.txtPrefecture.text = self.customerDic["prefecture"] as? String
        self.txtStreetName.text = self.customerDic["address1"] as? String
        self.txtEmail.text = self.customerDic["email"] as? String
        self.txtApartment.text = self.customerDic["address2"] as? String
        
        self.txtJob.text = self.customerDic["job"] as? String
        self.txtIntroduceDesc.text = self.customerDic["name"] as? String
        self.txtHowCome.text = self.customerDic["how_did_you_come"] as? String
        
        let genderStr:String! = self.customerDic["gender"] as? String
        
        if genderStr == "男性" {
            
            self.btnGenderMen.isSelected = true
            self.btnGenderWomen.isSelected = false
            
            self.genderStr = "男性"
            
        }
        else
        {
            self.btnGenderMen.isSelected = false
            self.btnGenderWomen.isSelected = true
            
            self.genderStr = "女性"

        }
        
        let newsletterStr:String! = self.customerDic["subscription_of_news"] as? String
        
        if newsletterStr == "1" {
            
            self.btnCanSendNewsLetterYes.isSelected = true
            self.btnCanSendNewsLetterNo.isSelected = false
            
            self.canSendNewsLetterStr = "1"

        }
        else
        {
            self.btnCanSendNewsLetterYes.isSelected = false
            self.btnCanSendNewsLetterNo.isSelected = true
            
            self.canSendNewsLetterStr = "0"

        }
        
        // Set job
        
        
        let jobStr:String! = self.customerDic["job"] as? String
        
        if jobStr == "アルバイト・パート" {
            
            self.btnJobPartTime.isSelected = true
            self.btnJobStudent.isSelected = false
            self.btnJobEmployee.isSelected = false
            self.btnJobSelfEmployee.isSelected = false
            self.btnJobCompanyOfficer.isSelected = false
            self.btnJobOther.isSelected = false
            self.btnJobHouseWife.isSelected = false

            self.jobStr = jobStr

            self.txtJob.isHidden = true
            self.txtJob.text = ""
        }
        else if jobStr == "学生"
        {
            self.btnJobPartTime.isSelected = false
            self.btnJobStudent.isSelected = true
            self.btnJobEmployee.isSelected = false
            self.btnJobSelfEmployee.isSelected = false
            self.btnJobCompanyOfficer.isSelected = false
            self.btnJobOther.isSelected = false
            self.btnJobHouseWife.isSelected = false
            
            self.txtJob.isHidden = true
            self.txtJob.text = ""
            
            self.jobStr = jobStr

        }
        else if jobStr == "会社員"
        {
            self.btnJobPartTime.isSelected = false
            self.btnJobStudent.isSelected = false
            self.btnJobEmployee.isSelected = true
            self.btnJobSelfEmployee.isSelected = false
            self.btnJobCompanyOfficer.isSelected = false
            self.btnJobOther.isSelected = false
            self.btnJobHouseWife.isSelected = false
        }
        else if jobStr == "自営業"
        {
            self.btnJobPartTime.isSelected = false
            self.btnJobStudent.isSelected = false
            self.btnJobEmployee.isSelected = false
            self.btnJobSelfEmployee.isSelected = true
            self.btnJobCompanyOfficer.isSelected = false
            self.btnJobOther.isSelected = false
            self.btnJobHouseWife.isSelected = false
            
            self.jobStr = jobStr

            
            self.txtJob.isHidden = true
            self.txtJob.text = ""
        }
        else if jobStr == "専業主婦"
        {
            self.btnJobPartTime.isSelected = false
            self.btnJobStudent.isSelected = false
            self.btnJobEmployee.isSelected = false
            self.btnJobSelfEmployee.isSelected = false
            self.btnJobHouseWife.isSelected = true
            self.btnJobCompanyOfficer.isSelected = false
            self.btnJobOther.isSelected = false
            
            self.jobStr = jobStr
            
            self.txtJob.isHidden = true
            self.txtJob.text = ""

        }
        else if jobStr == "会社役員"
        {
            self.btnJobPartTime.isSelected = false
            self.btnJobStudent.isSelected = false
            self.btnJobEmployee.isSelected = false
            self.btnJobSelfEmployee.isSelected = false
            self.btnJobCompanyOfficer.isSelected = true
            self.btnJobOther.isSelected = false
            self.btnJobHouseWife.isSelected = false
            
            self.jobStr = jobStr

            
            self.txtJob.isHidden = true
            self.txtJob.text = ""
        }
        else
        {
            self.btnJobPartTime.isSelected = false
            self.btnJobStudent.isSelected = false
            self.btnJobEmployee.isSelected = false
            self.btnJobSelfEmployee.isSelected = false
            self.btnJobCompanyOfficer.isSelected = false
            self.btnJobOther.isSelected = true
            self.btnJobHouseWife.isSelected = false
            
            self.jobStr = "その他"

            
            self.txtJob.isHidden = false
            self.txtJob.text = jobStr
        }
        
        // set how heard
        
        let howHeardStr:String! = self.customerDic["know_about_company"] as? String
        
        if howHeardStr == "ホットペッパー" {
            
            self.btnHowHeardISpot.isSelected = false
            self.btnHowHeardSpark.isSelected = false
            self.btnHowHeardWebsite.isSelected = false
            self.btnHowHeardIntroduce.isSelected = false
            self.btnHowHeardOthers.isSelected = false
            
            self.howHeardStr = howHeardStr

            self.txtIntroduceDesc.isHidden = true
            self.txtIntroduceDesc.text = ""
        }
        else if howHeardStr == "iSpot" {
            
            self.btnHowHeardNewsLetter.isSelected = false
            self.btnHowHeardISpot.isSelected = true
            self.btnHowHeardSpark.isSelected = false
            self.btnHowHeardWebsite.isSelected = false
            self.btnHowHeardIntroduce.isSelected = false
            self.btnHowHeardOthers.isSelected = false
            
            self.howHeardStr = howHeardStr

            self.txtIntroduceDesc.isHidden = true
            self.txtIntroduceDesc.text = ""
        }
        else if howHeardStr == "EPark" {
            
            self.btnHowHeardNewsLetter.isSelected = false
            self.btnHowHeardISpot.isSelected = false
            self.btnHowHeardSpark.isSelected = true
            self.btnHowHeardWebsite.isSelected = false
            self.btnHowHeardIntroduce.isSelected = false
            self.btnHowHeardOthers.isSelected = false
            
            self.howHeardStr = howHeardStr

            self.txtIntroduceDesc.isHidden = true
            self.txtIntroduceDesc.text = ""
        }
        else if howHeardStr == "紹介" {
            
            self.btnHowHeardNewsLetter.isSelected = false
            self.btnHowHeardISpot.isSelected = false
            self.btnHowHeardSpark.isSelected = false
            self.btnHowHeardWebsite.isSelected = false
            self.btnHowHeardIntroduce.isSelected = true
            self.btnHowHeardOthers.isSelected = false
            
            self.howHeardStr = howHeardStr

            self.txtIntroduceDesc.isHidden = true
            self.txtIntroduceDesc.text = ""
        }
        else if howHeardStr == "ウェブサイト" {
            
            self.btnHowHeardNewsLetter.isSelected = false
            self.btnHowHeardISpot.isSelected = false
            self.btnHowHeardSpark.isSelected = false
            self.btnHowHeardWebsite.isSelected = true
            self.btnHowHeardIntroduce.isSelected = false
            self.howHeardStr = howHeardStr

            self.txtIntroduceDesc.isHidden = true
            self.txtIntroduceDesc.text = ""
        }
        else
        {
            self.btnHowHeardNewsLetter.isSelected = false
            self.btnHowHeardISpot.isSelected = false
            self.btnHowHeardSpark.isSelected = false
            self.btnHowHeardWebsite.isSelected = false
            self.btnHowHeardIntroduce.isSelected = false
            self.btnHowHeardOthers.isSelected = true
            
            self.howHeardStr = "その他"
            self.txtIntroduceDesc.text = howHeardStr
            self.txtIntroduceDesc.isHidden = false
        }
        
        let howComeStr:String! = self.customerDic["how_did_you_come"] as? String
        
        if howComeStr == "車" {
            
            self.btnHowComeCar.isSelected = true
            self.btnHowComeTaxi.isSelected = false
            self.btnHowComeTrain.isSelected = false
            self.btnHowComeBycycle.isSelected = false
            self.btnHowComeWalk.isSelected = false
            self.btnHowComeAnother.isSelected = false
            
            self.howComeStr = "車"
            
            self.txtHowCome.isHidden = true
            self.txtHowCome.text = ""
            self.howComeHeight.constant = 0
        }
        else if howComeStr == "タクシー" {
            
            self.btnHowComeCar.isSelected = false
            self.btnHowComeTaxi.isSelected = true
            self.btnHowComeTrain.isSelected = false
            self.btnHowComeBycycle.isSelected = false
            self.btnHowComeWalk.isSelected = false
            self.btnHowComeAnother.isSelected = false
            
            self.howComeStr = "タクシー"
            
            self.txtHowCome.isHidden = true
            self.txtHowCome.text = ""
            self.howComeHeight.constant = 0
        }
        else if howComeStr == "電車" {
            
            self.btnHowComeCar.isSelected = false
            self.btnHowComeTaxi.isSelected = false
            self.btnHowComeTrain.isSelected = true
            self.btnHowComeBycycle.isSelected = false
            self.btnHowComeWalk.isSelected = false
            self.btnHowComeAnother.isSelected = false
            
            self.howComeStr = "電車"
            
            self.txtHowCome.isHidden = true
            self.txtHowCome.text = ""
            self.howComeHeight.constant = 0
        }
        else if howComeStr == "自転車" {

            self.btnHowComeCar.isSelected = false
            self.btnHowComeTaxi.isSelected = false
            self.btnHowComeTrain.isSelected = false
            self.btnHowComeBycycle.isSelected = true
            self.btnHowComeWalk.isSelected = false
            self.btnHowComeAnother.isSelected = false
            
            self.howComeStr = "自転車"
            
            self.txtHowCome.isHidden = true
            self.txtHowCome.text = ""
            self.howComeHeight.constant = 0
        }
        else {

            self.btnHowComeCar.isSelected = false
            self.btnHowComeTaxi.isSelected = false
            self.btnHowComeTrain.isSelected = false
            self.btnHowComeBycycle.isSelected = false
            self.btnHowComeWalk.isSelected = false
            self.btnHowComeAnother.isSelected = true
            
            self.howComeStr = "その他"
            
            self.txtHowCome.isHidden = false
            self.txtHowCome.text = self.howComeStr
            self.howComeHeight.constant = 50
        }
        
        
        
        let serviceIdStr:String! = self.customerDic["service_id"] as? String
        
        if serviceIdStr == "1" {
            
            self.btnTodayCourseNail.isSelected = true
            self.btnTodayCourseEsthe.isSelected = false
            self.btnTodayCourseEyelast.isSelected = false
            self.btnTodayCourseBody.isSelected = false
            self.btnTodayCourseHairRemoval.isSelected = false
            self.btnPhotoFacial.isSelected = false
            
            self.todayCourseStr = "1"
            
            self.btnSubmit.setTitle("登録", for: .normal)
        }
        else if serviceIdStr == "2" {
            
            self.btnTodayCourseNail.isSelected = false
            self.btnTodayCourseEsthe.isSelected = true
            self.btnTodayCourseEyelast.isSelected = false
            self.btnTodayCourseBody.isSelected = false
            self.btnTodayCourseHairRemoval.isSelected = false
            self.btnPhotoFacial.isSelected = false
            
            self.todayCourseStr = "2"
            
            self.btnSubmit.setTitle("次", for: .normal)

        }
        else if serviceIdStr == "3" {

            self.btnTodayCourseNail.isSelected = false
            self.btnTodayCourseEsthe.isSelected = false
            self.btnTodayCourseEyelast.isSelected = true
            self.btnTodayCourseBody.isSelected = false
            self.btnTodayCourseHairRemoval.isSelected = false
            self.btnPhotoFacial.isSelected = false
            
            self.todayCourseStr = "3"
            
            self.btnSubmit.setTitle("次", for: .normal)
        }
        else if serviceIdStr == "4" {

            self.btnTodayCourseNail.isSelected = false
            self.btnTodayCourseEsthe.isSelected = false
            self.btnTodayCourseEyelast.isSelected = false
            self.btnTodayCourseBody.isSelected = true
            self.btnTodayCourseHairRemoval.isSelected = false
            self.btnPhotoFacial.isSelected = false
            
            self.todayCourseStr = "4"
            
            self.btnSubmit.setTitle("次", for: .normal)
        }
        else if serviceIdStr == "5" {

            self.btnTodayCourseNail.isSelected = false
            self.btnTodayCourseEsthe.isSelected = false
            self.btnTodayCourseEyelast.isSelected = false
            self.btnTodayCourseBody.isSelected = false
            self.btnPhotoFacial.isSelected = false
            
            self.btnTodayCourseHairRemoval.isSelected = true
            
            self.todayCourseStr = "5"
            
            self.btnSubmit.setTitle("次", for: .normal)

        }
        else if serviceIdStr == "6" {

            self.btnTodayCourseNail.isSelected = false
            self.btnTodayCourseEsthe.isSelected = false
            self.btnTodayCourseEyelast.isSelected = false
            self.btnTodayCourseBody.isSelected = false
            self.btnTodayCourseHairRemoval.isSelected = false
            self.btnPhotoFacial.isSelected = true
            
            self.todayCourseStr = "6"
            
            self.btnSubmit.setTitle("次", for: .normal)
            
        }
    }
    @objc func handleTapFrom(recognizer : UITapGestureRecognizer ) {
        
      //  self.resignTextField()
        
    }
    func resignTextField()
    {
        txtKana.resignFirstResponder()
        txtName.resignFirstResponder()
        txtDob.resignFirstResponder()
        txtAge.resignFirstResponder()
        txtPhoneNumber.resignFirstResponder()
        txtPostalCode.resignFirstResponder()
        txtEmail.resignFirstResponder()
        txtJob.resignFirstResponder()
        txtPrefecture.resignFirstResponder()
        txtCity.resignFirstResponder()
        txtApartment.resignFirstResponder()
        txtStreetName.resignFirstResponder()
        txtHowCome.resignFirstResponder()
        txtIntroduceDesc.resignFirstResponder()
        txtFirstName.resignFirstResponder()
        txtLastName.resignFirstResponder()
        txtKanaLastName.resignFirstResponder()
        txtKanaFirstName.resignFirstResponder()
        
        UIView.beginAnimations("anim", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(0.25)
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        UIView.commitAnimations()
        
    }
    @IBAction func btnGenderMenAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnGenderMen.isSelected = true
            
            self.btnGenderWomen.isSelected = false
            
            self.genderStr = "男性"

        }
       
    }
    
    @IBAction func btnGenderWomenAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnGenderWomen.isSelected = true
            
            self.btnGenderMen.isSelected = false
            
            self.genderStr = "女性"

        }
     
    }
    
    @IBAction func btnCanSendNewsletterYesAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnCanSendNewsLetterYes.isSelected = true
            
            self.btnCanSendNewsLetterNo.isSelected = false
            
            self.canSendNewsLetterStr = "1"

            
        }
       
    }
    
    @IBAction func btnCanSendNewsLetterNoAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnCanSendNewsLetterNo.isSelected = true
            
            self.btnCanSendNewsLetterYes.isSelected = false
            
            self.canSendNewsLetterStr = "0"

        }
    }
    
    @IBAction func btnHouseWifeYesAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnHouseWifeYes.isSelected = true
            
            self.btnHouseWifeNo.isSelected = false
            
            self.areYouHouseWifeStr = "1"

            
        }
    }
    
    @IBAction func btnHouseWifeNoAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnHouseWifeNo.isSelected = true
            
            self.btnHouseWifeYes.isSelected = false
            
            self.areYouHouseWifeStr = "0"
            
           

        }
    }
    
    @IBAction func btnHowHeardNewsLetterAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnHowHeardNewsLetter.isSelected = true
            
            self.btnHowHeardISpot.isSelected = false
            self.btnHowHeardSpark.isSelected = false
            self.btnHowHeardWebsite.isSelected = false
            self.btnHowHeardIntroduce.isSelected = false
            self.btnHowHeardOthers.isSelected = false

            self.howHeardStr = "ホットペッパー"
            
            self.txtIntroduceDesc.isHidden = true

        }
    }
    
    @IBAction func btnHowHeardISpotAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnHowHeardNewsLetter.isSelected = false
            self.btnHowHeardISpot.isSelected = true
            self.btnHowHeardSpark.isSelected = false
            self.btnHowHeardWebsite.isSelected = false
            self.btnHowHeardIntroduce.isSelected = false
            self.btnHowHeardOthers.isSelected = false

            self.howHeardStr = "iSpot"

            self.txtIntroduceDesc.isHidden = true
        }
    }
    
    @IBAction func btnHowHeardSparkAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnHowHeardNewsLetter.isSelected = false
            self.btnHowHeardISpot.isSelected = false
            self.btnHowHeardSpark.isSelected = true
            self.btnHowHeardWebsite.isSelected = false
            self.btnHowHeardIntroduce.isSelected = false
            self.btnHowHeardOthers.isSelected = false

            self.howHeardStr = "EPark"
            
            self.txtIntroduceDesc.isHidden = true

        }
    }
    
    @IBAction func btnHowHeardIntroduceAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnHowHeardNewsLetter.isSelected = false
            self.btnHowHeardISpot.isSelected = false
            self.btnHowHeardSpark.isSelected = false
            self.btnHowHeardWebsite.isSelected = false
            self.btnHowHeardIntroduce.isSelected = true
            self.btnHowHeardOthers.isSelected = false

            self.howHeardStr = "紹介"
            
            self.txtIntroduceDesc.isHidden = true

        }
    }
    
    @IBAction func btnHowHeardWebsiteAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnHowHeardNewsLetter.isSelected = false
            self.btnHowHeardISpot.isSelected = false
            self.btnHowHeardSpark.isSelected = false
            self.btnHowHeardWebsite.isSelected = true
            self.btnHowHeardIntroduce.isSelected = false
            
            self.howHeardStr = "ウェブサイト"

            self.txtIntroduceDesc.isHidden = true
        }
    }
    @IBAction func btnHowHeardOthersAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnHowHeardNewsLetter.isSelected = false
            self.btnHowHeardISpot.isSelected = false
            self.btnHowHeardSpark.isSelected = false
            self.btnHowHeardWebsite.isSelected = false
            self.btnHowHeardIntroduce.isSelected = false
            self.btnHowHeardOthers.isSelected = true

            self.howHeardStr = "その他"
            
            self.txtIntroduceDesc.isHidden = false
            
        }
    }
    @IBAction func btnHowComeCarAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnHowComeCar.isSelected = true
            self.btnHowComeTaxi.isSelected = false
            self.btnHowComeTrain.isSelected = false
            self.btnHowComeBycycle.isSelected = false
            self.btnHowComeWalk.isSelected = false
            self.btnHowComeAnother.isSelected = false

            self.howComeStr = "車"
            
            self.txtHowCome.isHidden = true
            self.txtHowCome.text = ""
            self.howComeHeight.constant = 0

        }
    }
    
    @IBAction func btnHowComeTaxiAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnHowComeCar.isSelected = false
            self.btnHowComeTaxi.isSelected = true
            self.btnHowComeTrain.isSelected = false
            self.btnHowComeBycycle.isSelected = false
            self.btnHowComeWalk.isSelected = false
            self.btnHowComeAnother.isSelected = false
            
            self.howComeStr = "タクシー"
            
            self.txtHowCome.isHidden = true
            self.txtHowCome.text = ""
            self.howComeHeight.constant = 0

        }
    }
    
    @IBAction func btnHowComeTrainAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnHowComeCar.isSelected = false
            self.btnHowComeTaxi.isSelected = false
            self.btnHowComeTrain.isSelected = true
            self.btnHowComeBycycle.isSelected = false
            self.btnHowComeWalk.isSelected = false
            self.btnHowComeAnother.isSelected = false
            
            self.howComeStr = "電車"
            
            self.txtHowCome.isHidden = true
            self.txtHowCome.text = ""
            self.howComeHeight.constant = 0

        }
    }
    
    @IBAction func btnHowComeBycycleAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnHowComeCar.isSelected = false
            self.btnHowComeTaxi.isSelected = false
            self.btnHowComeTrain.isSelected = false
            self.btnHowComeBycycle.isSelected = true
            self.btnHowComeWalk.isSelected = false
            self.btnHowComeAnother.isSelected = false
            
            self.howComeStr = "自転車"
            
            self.txtHowCome.isHidden = true
            self.txtHowCome.text = ""
            self.howComeHeight.constant = 0

        }
    }
    
    @IBAction func btnHowComeWalkAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnHowComeCar.isSelected = false
            self.btnHowComeTaxi.isSelected = false
            self.btnHowComeTrain.isSelected = false
            self.btnHowComeBycycle.isSelected = false
            self.btnHowComeWalk.isSelected = true
            self.btnHowComeAnother.isSelected = false
            
            self.howComeStr = "徒歩"
            
            self.txtHowCome.isHidden = true
            self.txtHowCome.text = ""
            self.howComeHeight.constant = 0

        }
    }
    
    @IBAction func btnHowComeAnotherAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnHowComeCar.isSelected = false
            self.btnHowComeTaxi.isSelected = false
            self.btnHowComeTrain.isSelected = false
            self.btnHowComeBycycle.isSelected = false
            self.btnHowComeWalk.isSelected = false
            self.btnHowComeAnother.isSelected = true
            
            self.howComeStr = "その他"

            self.txtHowCome.isHidden = false
            self.txtHowCome.text = ""
            self.howComeHeight.constant = 50
        }
    }
    
    @IBAction func btnTodayCourseNailAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnTodayCourseNail.isSelected = true
            self.btnTodayCourseEsthe.isSelected = false
            self.btnTodayCourseEyelast.isSelected = false
            self.btnTodayCourseBody.isSelected = false
            self.btnTodayCourseHairRemoval.isSelected = false
            self.btnPhotoFacial.isSelected = false

            self.todayCourseStr = "1"
            
            self.btnSubmit.setTitle("登録", for: .normal)

        }
    }
    
    @IBAction func btnTodayCourseEstheAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnTodayCourseNail.isSelected = false
            self.btnTodayCourseEsthe.isSelected = true
            self.btnTodayCourseEyelast.isSelected = false
            self.btnTodayCourseBody.isSelected = false
            self.btnTodayCourseHairRemoval.isSelected = false
            self.btnPhotoFacial.isSelected = false

            self.todayCourseStr = "2"
            
            self.btnSubmit.setTitle("次", for: .normal)


        }
    }
    
    @IBAction func btnTodayCourseEyelastAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnTodayCourseNail.isSelected = false
            self.btnTodayCourseEsthe.isSelected = false
            self.btnTodayCourseEyelast.isSelected = true
            self.btnTodayCourseBody.isSelected = false
            self.btnTodayCourseHairRemoval.isSelected = false
            self.btnPhotoFacial.isSelected = false

            self.todayCourseStr = "3"
            
            self.btnSubmit.setTitle("次", for: .normal)


        }
    }
    
    @IBAction func btnTodayCourseBodyAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnTodayCourseNail.isSelected = false
            self.btnTodayCourseEsthe.isSelected = false
            self.btnTodayCourseEyelast.isSelected = false
            self.btnTodayCourseBody.isSelected = true
            self.btnTodayCourseHairRemoval.isSelected = false
            self.btnPhotoFacial.isSelected = false

            self.todayCourseStr = "4"
            
            self.btnSubmit.setTitle("次", for: .normal)


        }
    }
    
    @IBAction func btnTodayCourseHairRemovalAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnTodayCourseNail.isSelected = false
            self.btnTodayCourseEsthe.isSelected = false
            self.btnTodayCourseEyelast.isSelected = false
            self.btnTodayCourseBody.isSelected = false
            self.btnPhotoFacial.isSelected = false

            self.btnTodayCourseHairRemoval.isSelected = true
            
            self.todayCourseStr = "5"
            
            self.btnSubmit.setTitle("次", for: .normal)


        }
    }
    @IBAction func btnPhotoFacialPressed(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnTodayCourseNail.isSelected = false
            self.btnTodayCourseEsthe.isSelected = false
            self.btnTodayCourseEyelast.isSelected = false
            self.btnTodayCourseBody.isSelected = false
            self.btnTodayCourseHairRemoval.isSelected = false
            self.btnPhotoFacial.isSelected = true

            self.todayCourseStr = "6"
            
            self.btnSubmit.setTitle("次", for: .normal)
            
            
        }
    }
    
    @IBAction func btnJobPartTime(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnJobPartTime.isSelected = true
            self.btnJobStudent.isSelected = false
            self.btnJobEmployee.isSelected = false
            self.btnJobSelfEmployee.isSelected = false
            self.btnJobCompanyOfficer.isSelected = false
            self.btnJobOther.isSelected = false
            self.btnJobHouseWife.isSelected = false

            self.jobStr = "アルバイト・パート"
            
            self.txtJob.isHidden = true
            self.txtJob.text = ""

        }
    }
    @IBAction func btnJobStudent(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnJobPartTime.isSelected = false
            self.btnJobStudent.isSelected = true
            self.btnJobEmployee.isSelected = false
            self.btnJobSelfEmployee.isSelected = false
            self.btnJobCompanyOfficer.isSelected = false
            self.btnJobOther.isSelected = false
            self.btnJobHouseWife.isSelected = false

            self.jobStr = "学生"
            
            self.txtJob.isHidden = true
            self.txtJob.text = ""

        }
    }
    @IBAction func btnJobEmployee(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnJobPartTime.isSelected = false
            self.btnJobStudent.isSelected = false
            self.btnJobEmployee.isSelected = true
            self.btnJobSelfEmployee.isSelected = false
            self.btnJobCompanyOfficer.isSelected = false
            self.btnJobOther.isSelected = false
            self.btnJobHouseWife.isSelected = false

            self.jobStr = "会社員"
            
            self.txtJob.isHidden = true
            self.txtJob.text = ""

        }
    }
    @IBAction func btnJobSelfEmployee(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnJobPartTime.isSelected = false
            self.btnJobStudent.isSelected = false
            self.btnJobEmployee.isSelected = false
            self.btnJobSelfEmployee.isSelected = true
            self.btnJobCompanyOfficer.isSelected = false
            self.btnJobOther.isSelected = false
            self.btnJobHouseWife.isSelected = false

            self.jobStr = "自営業"
            
            self.txtJob.isHidden = true
            self.txtJob.text = ""

        }
    }
    @IBAction func btnJobHousewife(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnJobPartTime.isSelected = false
            self.btnJobStudent.isSelected = false
            self.btnJobEmployee.isSelected = false
            self.btnJobSelfEmployee.isSelected = false
            self.btnJobHouseWife.isSelected = true
            self.btnJobCompanyOfficer.isSelected = false
            self.btnJobOther.isSelected = false

            self.jobStr = "専業主婦"
            
            self.txtJob.isHidden = true
            self.txtJob.text = ""
            
        }
    }
    @IBAction func btnJobCompanyOfficer(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnJobPartTime.isSelected = false
            self.btnJobStudent.isSelected = false
            self.btnJobEmployee.isSelected = false
            self.btnJobSelfEmployee.isSelected = false
            self.btnJobCompanyOfficer.isSelected = true
            self.btnJobOther.isSelected = false
            self.btnJobHouseWife.isSelected = false

            self.jobStr = "会社役員"
            
            self.txtJob.isHidden = true
            self.txtJob.text = ""

        }
    }
    @IBAction func btnJobOther(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnJobPartTime.isSelected = false
            self.btnJobStudent.isSelected = false
            self.btnJobEmployee.isSelected = false
            self.btnJobSelfEmployee.isSelected = false
            self.btnJobCompanyOfficer.isSelected = false
            self.btnJobOther.isSelected = true
            self.btnJobHouseWife.isSelected = false

            self.jobStr = "その他"
            
            self.txtJob.isHidden = false
            self.txtJob.text = ""
            
        }
    }
    
    @IBAction func btnSubmitAction(_ sender: UIButton) {
        
        self.txtKana.text = self.txtKana.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.txtName.text = self.txtName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.txtJob.text = self.txtJob.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.txtEmail.text = self.txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.txtPrefecture.text = self.txtPrefecture.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.txtCity.text = self.txtCity.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.txtStreetName.text = self.txtStreetName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.txtApartment.text = self.txtApartment.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        self.txtPostalCode.text = self.txtPostalCode.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.txtPhoneNumber.text = self.txtPhoneNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.txtAge.text = self.txtAge.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.txtDob.text = self.txtDob.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        /*if self.txtName.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_NAME, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            self.txtName.becomeFirstResponder()

            return
        }*/
        if self.txtLastName.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_LNAME, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            self.txtLastName.becomeFirstResponder()
            
            return
        }
        if self.txtFirstName.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_FNAME, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            self.txtFirstName.becomeFirstResponder()
            
            return
        }
       /* if self.txtKana.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_KANA, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            self.txtKana.becomeFirstResponder()
            
            return
        }*/
        if self.txtKanaLastName.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_KANA_LNAME, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            self.txtKanaLastName.becomeFirstResponder()
            
            return
        }
        if self.txtKanaFirstName.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_KANA_FNAME, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            self.txtKanaFirstName.becomeFirstResponder()
            
            return
        }
        if self.genderStr?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_GENDER, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)

            return
        }
        if self.txtAge.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_AGE, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            self.txtAge.becomeFirstResponder()
            
            return
        }
        if self.txtPhoneNumber.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_PHONE_NO, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            self.txtPhoneNumber.becomeFirstResponder()
            
            return
        }
        /*
        if self.txtPostalCode.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_POSTALCODE, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            self.txtPostalCode.becomeFirstResponder()

            return
        }
        if self.txtPrefecture.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_PREFECTURE, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            self.txtPrefecture.becomeFirstResponder()

            return
        }
        if self.txtCity.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_CITY, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            self.txtCity.becomeFirstResponder()

            return
        }
        if self.txtStreetName.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_STREET_ADDRESS, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            self.txtStreetName.becomeFirstResponder()

            return
        }
        if self.txtApartment.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_APARTMENT_ADDRESS, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            self.txtApartment.becomeFirstResponder()

            return
        }
        if self.txtEmail.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_EMAIL, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            self.txtEmail.becomeFirstResponder()

            return
        }
        
         if !ConfigManager.validateEmail(self.txtEmail.text!) {

            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_EMAIL_INVALID, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            self.txtEmail.becomeFirstResponder()

            return
        }
        if self.canSendNewsLetterStr?.count == 0 {

            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_CAN_SEND_NEWSLETTER, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if self.areYouHouseWifeStr?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_ARE_YOU_HOUSEWIFE, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }*/
        //if self.txtJob.text?.count == 0 && self.areYouHouseWifeStr == "0"{
       
        if self.jobStr?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_JOB, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if self.txtJob.text?.count == 0 && self.jobStr == "その他"{

            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_JOB, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            self.txtJob.becomeFirstResponder()

            return
        }
        if self.howHeardStr?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_HOW_YOU_HEARD, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if self.txtIntroduceDesc.text?.count == 0 &&  self.howHeardStr == "その他" {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_HOW_YOU_HEARD, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            self.txtIntroduceDesc.becomeFirstResponder()

            return
        }
        if self.howComeStr?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_HOW_YOU_COME, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if self.howComeStr == "その他" && self.txtHowCome.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_HOW_YOU_COME, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            self.txtHowCome.becomeFirstResponder()

            return
        }
        if self.todayCourseStr?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_TODAY_COURSE, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        self.submitFormData()
    }
    
 
    func submitFormData()
    {
        self.resignTextField()
        
        ConfigManager.showLoadingHUD(to_view: self.view)

        var address:String! = ""
        
        if (self.txtApartment.text?.count)! > 0 {
        
            address = self.txtApartment.text!
        }
        if (self.txtStreetName.text?.count)! > 0 {
            
            if address.count > 0
            {
                address = address + ", "
            }
            address = address + self.txtStreetName.text!

        }
        if (self.txtCity.text?.count)! > 0 {
            
            if address.count > 0
            {
                address = address + ", "
            }
            
            address = address + self.txtCity.text!

        }
        if (self.txtPrefecture.text?.count)! > 0 {
            
            if address.count > 0
            {
                address = address + ", "
            }
            address = address + self.txtPrefecture.text!

        }
       // address = self.txtApartment.text! + ", " + self.txtStreetName.text!
       // address = address + ", " + self.txtCity.text! + ", " + self.txtPrefecture.text!
        
        let name:String! = self.txtLastName.text! + " " + self.txtFirstName.text!
        let kana:String! = self.txtKanaLastName.text! + " " + self.txtKanaFirstName.text!

        
        self.objWebServiceController = WebServiceController()
        self.objWebServiceController?.delegate = self
        
        var parameters = [String : String] ()
        
        parameters["MethodName"] = "add_customer"
        parameters["device_token"] = ConfigManager.gDeviceToken
        parameters["kana"] = kana
        parameters["name"] = name
        parameters["first_name"] = self.txtFirstName.text
        parameters["last_name"] = self.txtLastName.text

        parameters["kana_first_name"] = self.txtKanaFirstName.text
        parameters["kana_last_name"] = self.txtKanaLastName.text
        
       // parameters["dob"] = "1987-09-04"

        parameters["dob"] = self.txtDob.text
        parameters["age"] = self.txtAge.text
        parameters["tel"] = self.txtPhoneNumber.text
        parameters["zip_code"] = self.txtPostalCode.text
        parameters["address"] = address
        parameters["prefecture"] = self.txtPrefecture.text
        parameters["city"] = self.txtCity.text
        parameters["address1"] = self.txtStreetName.text
        parameters["address2"] = self.txtApartment.text

        parameters["email"] = self.txtEmail.text
        
        if self.jobStr == "その他"{

            parameters["job"] = self.txtJob.text

        }
        else
        {
            parameters["job"] = self.jobStr

        }

        parameters["gender"] = self.genderStr
        parameters["subscription_of_news"] = self.canSendNewsLetterStr
        //parameters["is_housewife"] = self.areYouHouseWifeStr
        
        if self.howHeardStr == "その他"
        {
            parameters["know_about_company"] = self.txtIntroduceDesc.text


        }
        else
        {
            parameters["know_about_company"] = self.howHeardStr

        }
        
        if self.howComeStr == "その他"
        {
            parameters["how_did_you_come"] = self.txtHowCome.text
            
            
        }
        else
        {
            parameters["how_did_you_come"] = self.howComeStr

        }

        parameters["service_id"] = self.todayCourseStr
        parameters["user_id"] = ConfigManager.gUserId
        
       
           /* if self.customerDic.count > 0
            {
                parameters["id"] = self.customerDic["id"] as? String

         }*/
        
      //  parameters["salon_id"] = ConfigManager.gSalonId

        self.objWebServiceController?.serverParameter(parameters: parameters as [String : AnyObject])
        
    }
    func serviceResponse(forURl urlString: String, response: JSON) {
        
        ConfigManager.hideLoadingHUD(for_view:self.view)
        
        if !(urlString == "server_error_handle") {
            
            let customerID:String! = String(describing: response["customer_id"])
            let serviceId:String! = String(describing:response["service_id"])
            let status:String! = String(describing:response["status"])

            if status == "success"
            {
                if customerID != nil {
                    
                    if serviceId != nil
                    {
                        if serviceId == "2"
                        {
                            self.objEstheServiceViewController = EstheServiceViewController(nibName: "EstheServiceViewController", bundle: nil)
                            self.objEstheServiceViewController.customerId = customerID!
                            self.navigationController?.pushViewController(self.objEstheServiceViewController!, animated: true)
                        }
                        else if serviceId == "3"
                        {
                            self.objEyeLastServiceViewController = EyeLastServiceViewController(nibName: "EyeLastServiceViewController", bundle: nil)
                            self.objEyeLastServiceViewController.customerId = customerID!
                            self.navigationController?.pushViewController(self.objEyeLastServiceViewController!, animated: true)
                        }
                        else if serviceId == "4"
                        {
                            self.objBodyServiceViewController = BodyServiceViewController(nibName: "BodyServiceViewController", bundle: nil)
                            self.objBodyServiceViewController.customerId = customerID!
                            self.navigationController?.pushViewController(self.objBodyServiceViewController!, animated: true)
                        }
                        else if serviceId == "5"
                        {
                            self.objHairRemovalServiceViewController = HairRemovalServiceViewController(nibName: "HairRemovalServiceViewController", bundle: nil)
                            self.objHairRemovalServiceViewController.customerId = customerID!
                            self.navigationController?.pushViewController(self.objHairRemovalServiceViewController!, animated: true)
                        }
                        else if serviceId == "6"
                        {
                            self.objPhotoFacialViewController = PhotoFacialViewController(nibName: "PhotoFacialViewController", bundle: nil)
                            self.objPhotoFacialViewController.customerId = customerID!
                            self.navigationController?.pushViewController(self.objPhotoFacialViewController!, animated: true)
                        }
                        else
                        {
                            let alert = UIAlertController(title: "", message: "サービスを正常に追加しました", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true)
                            
                            self.dismiss(animated: true) {
                                
                                self.objThankYouPageViewController = ThankYouPageViewController(nibName: "ThankYouPageViewController", bundle: nil)
                                self.navigationController?.pushViewController(self.objThankYouPageViewController!, animated: true)
                                // self.navigationController?.popViewController(animated: true)
                                
                            }
                        }
                        
                    }
                }
            }
            else
            {
                let alert = UIAlertController(title: "", message: "Error", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            

        }
        else {
            let alert = UIAlertController(title: "", message: "Error", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
     func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        self.selectedTextfield = textField

        scrollView(toCenterOfScreen: textField, textfield: textField)

        if textField == self.txtDob
        {
            self.datePickerTapped()
            textField.resignFirstResponder()
            return false
        }
        else
        {
            
            return true
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == self.txtPhoneNumber {
            
//            let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
//            let compSepByCharInSet = string.components(separatedBy: aSet)
//            let numberFiltered = compSepByCharInSet.joined(separator: "")
//            return string == numberFiltered
            
            var fullString = textField.text ?? ""
            fullString.append(string)
            if range.length == 1 {
                textField.text = ConfigManager.format(phoneNumber: fullString, shouldRemoveLastDigit: true)
            } else {
                textField.text = ConfigManager.format(phoneNumber: fullString)
            }
            return false
        }
        else
        {
            return true
        }
        
    }
    @objc func keyboardWillShow( note:NSNotification )
    {
        
        if ConfigManager.IS_IPHONE()
        {
            if self.selectedTextfield == self.txtPhoneNumber{

            self.btnKeypadReturn.isHidden = false
            let keyBoardWindow = UIApplication.shared.windows.last
            
            if ConfigManager.DeviceType.IS_IPHONE_X
            {
                self.btnKeypadReturn.frame = CGRect(x: 0, y: (keyBoardWindow?.frame.size.height)!-130, width: 106, height: 53)
                
            }
            else
            {
                self.btnKeypadReturn.frame = CGRect(x: 0, y: (keyBoardWindow?.frame.size.height)!-53, width: 106, height: 53)
                
            }
            
            keyBoardWindow?.addSubview(self.btnKeypadReturn)
            keyBoardWindow?.bringSubview(toFront: self.btnKeypadReturn)
            
            var userInfo = note.userInfo!
            var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
            print(keyboardFrame)
            
            keyboardFrame = self.view.convert(keyboardFrame, from: nil)
            
            var contentInset:UIEdgeInsets = self.scrollView.contentInset
            contentInset.bottom = keyboardFrame.size.height
            scrollView.contentInset = contentInset
                
            }
        }
        
        
        
        
        
    }
    @objc func keyboardWillHide(_ notification:Notification) {
        
        if ConfigManager.IS_IPHONE(){
            
            self.btnKeypadReturn.isHidden = true
            
            let contentInset:UIEdgeInsets = .zero
            self.scrollView.contentInset = contentInset
            
        }
    }
    @objc func Done(_ sender : UIButton){
        
        
        self.selectedTextfield.resignFirstResponder()
        self.btnKeypadReturn.isHidden = true
        
        
    }
    func datePickerTapped() {
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
                                
                                self.txtDob.text = formatter.string(from: dt)
                                
                                let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
                                
                                let ageComponents = calendar.components(.year,
                                                                        from: date!,
                                                                        to: Date(),
                                                                        options: [])
                                let age = ageComponents.year!
                                
                                print(age)
                                
                                self.txtAge.text = String(age)
                            }
        }
    }
    func scrollView(toCenterOfScreen theView: UIView, textfield: UITextField) {
        let viewCenterY: CGFloat = theView.center.y
        let applicationFrame: CGRect = UIScreen.main.bounds
        var availableHeight: CGFloat
        availableHeight = applicationFrame.size.height - 150
        
        var y: CGFloat = viewCenterY - availableHeight / 2.0
        if y < 0 {
            y = 0
        }
        if UIApplication.shared.statusBarOrientation.isPortrait == true {
            
            scrollView.setContentOffset(CGPoint(x: 0, y: y), animated: true)
            
        }
        else
        {
            if textfield != self.txtFirstName && textfield != self.txtLastName
            {
                scrollView.setContentOffset(CGPoint(x: 0, y: y+70), animated: true)

            }
            
        }
    }
   
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
            //textField.resignFirstResponder()
        
        self.resignTextField()
        return true
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(self)
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
