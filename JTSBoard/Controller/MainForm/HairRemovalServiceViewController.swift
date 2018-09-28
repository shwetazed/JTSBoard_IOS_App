//
//  HairRemovalServiceViewController.swift
//  JTSBoard
//
//  Created by jts on 03/07/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit
import SwiftyJSON

class HairRemovalServiceViewController: UIViewController,WebServiceControllerDelegate,UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    var objWebServiceController: WebServiceController?
    var objThankYouPageViewController: ThankYouPageViewController?
    var objTermPolicyView: TermPolicyView!

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var btnPhysicleStatusGood: UIButton!
    @IBOutlet weak var btnPhysicleStatusBad: UIButton!
    
    @IBOutlet weak var txtPhysicleStatusDesc: FloatLabelTextField!
    
    @IBOutlet weak var btnAlergyYes: UIButton!
    @IBOutlet weak var btnAlergyNo: UIButton!
    
    @IBOutlet weak var txtAlergyDesc: FloatLabelTextField!
    
    @IBOutlet weak var btnMedicinYes: UIButton!
    @IBOutlet weak var btnMedicineyNo: UIButton!
    
    @IBOutlet weak var txtMedicineDesc: FloatLabelTextField!
    
    
    @IBOutlet weak var btnHospitalYes: UIButton!
    @IBOutlet weak var btnHospitalNo: UIButton!
    
    @IBOutlet weak var txtHospitalDesc: FloatLabelTextField!
    
    @IBOutlet weak var btnLiveYes: UIButton!
    @IBOutlet weak var btnLiveNo: UIButton!
    
    @IBOutlet weak var txtLiveDesc: FloatLabelTextField!
    
//    @IBOutlet weak var btnPsycologiclePeriodGood: UIButton!
//    @IBOutlet weak var btnPsycologiclePeriodBad: UIButton!
//    @IBOutlet weak var btnPsycologiclePeriodMenopause: UIButton!
    
    @IBOutlet weak var btnConcernWaki: UIButton!
    @IBOutlet weak var btnConcernKnee: UIButton!
    @IBOutlet weak var btnConcernThigh: UIButton!
    @IBOutlet weak var btnConcernElbow: UIButton!
    @IBOutlet weak var btnConcernUpperArm: UIButton!
    @IBOutlet weak var btnConcernBack: UIButton!
    @IBOutlet weak var btnConcernChestHair: UIButton!
    @IBOutlet weak var btnConcernLimbs: UIButton!
    @IBOutlet weak var btnConcernNape: UIButton!
    @IBOutlet weak var btnConcernFace: UIButton!
    
    @IBOutlet weak var btnPeriodGood: UIButton!
    @IBOutlet weak var btnPeriodBad: UIButton!
    @IBOutlet weak var btnPeriodMenopause: UIButton!

    
    @IBOutlet weak var btnEsthicExperienceNo: UIButton!
    @IBOutlet weak var btnEsthicExperienceOnly: UIButton!
    @IBOutlet weak var btnEsthicExperienceYes: UIButton!
    @IBOutlet weak var txtEsthicExperienceDesc: FloatLabelTextField!

    
    @IBOutlet weak var btnSurgeryNo: UIButton!
    @IBOutlet weak var btnSurgeryYes: UIButton!
    @IBOutlet weak var txtSurgeryDesc: FloatLabelTextField!


    var customerId:String! = ""
    var physicleStatusStr:String! = ""
    var alergyStr:String! = ""
    var medicineStr:String! = ""
    var hospitalStr:String! = ""
    var periodStr:String! = ""
    var medicleHistoryStr:String! = ""
    var estheticExperienceStr:String! = ""
    var surgeryStr:String! = ""

    var isAgreementVisible:Bool! = false

    var currentDate:String!
    var dateId:String!

    var arrConcernList = NSMutableArray()
    
    @IBOutlet weak var btnSubmit: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.objWebServiceController = WebServiceController()
        self.objWebServiceController?.delegate = self
        
        self.backgroundView.alpha = 0.3
        
        self.isAgreementVisible = false
    
        
        self.btnSubmit.layer.cornerRadius = 5.0
        self.btnSubmit.clipsToBounds = true
        
        self.navigationItem.title = "脱毛サービス"
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 163/255, green: 125/255, blue: 30/255, alpha: 1.0)

        // Do any additional setup after loading the view.
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTapFrom))
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        // Do any additional setup after loading the view.
    }
    @objc func handleTapFrom(recognizer : UITapGestureRecognizer ) {
        
       // self.resignTextField()
        
    }
    func resignTextField()
    {
        txtAlergyDesc.resignFirstResponder()
        txtLiveDesc.resignFirstResponder()
        txtSurgeryDesc.resignFirstResponder()
        txtMedicineDesc.resignFirstResponder()
        txtEsthicExperienceDesc.resignFirstResponder()
        txtMedicineDesc.resignFirstResponder()
        txtPhysicleStatusDesc.resignFirstResponder()
        txtHospitalDesc.resignFirstResponder()
        
        
        UIView.beginAnimations("anim", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(0.25)
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        UIView.commitAnimations()
        
    }
    
    @IBAction func btnPhysicleStatusGoodAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnPhysicleStatusGood.isSelected = true
            self.btnPhysicleStatusBad.isSelected = false
            self.physicleStatusStr = "良好"
            self.txtPhysicleStatusDesc.isHidden = true
            self.txtPhysicleStatusDesc.text = ""
            
        }
    }
    @IBAction func btnPhysicleStatusBadAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnPhysicleStatusBad.isSelected = true
            self.btnPhysicleStatusGood.isSelected = false
            self.physicleStatusStr = "不調"
            self.txtPhysicleStatusDesc.isHidden = false
            self.txtPhysicleStatusDesc.text = ""
            
        }
    }
    
    @IBAction func btnAlergyYesAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnAlergyYes.isSelected = true
            self.btnAlergyNo.isSelected = false
            self.alergyStr = "はい"
            self.txtAlergyDesc.isHidden = false
            self.txtAlergyDesc.text = ""
            
        }
    }
    @IBAction func btnAlergyNoAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnAlergyNo.isSelected = true
            self.btnAlergyYes.isSelected = false
            self.alergyStr = "いいえ"
            self.txtAlergyDesc.isHidden = true
            self.txtAlergyDesc.text = ""
            
        }
    }
    
    @IBAction func btnMedineYesAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnMedicinYes.isSelected = true
            self.btnMedicineyNo.isSelected = false
            self.medicineStr = "はい"
            self.txtMedicineDesc.isHidden = false
            self.txtMedicineDesc.text = ""
            
        }
    }
    @IBAction func btnMedicineNoAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnMedicineyNo.isSelected = true
            self.btnMedicinYes.isSelected = false
            self.medicineStr = "いいえ"
            self.txtMedicineDesc.isHidden = true
            self.txtMedicineDesc.text = ""
            
        }
    }
    
    @IBAction func btnHospitalYesAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnHospitalYes.isSelected = true
            self.btnHospitalNo.isSelected = false
            self.hospitalStr = "はい"
            self.txtHospitalDesc.isHidden = false
            self.txtHospitalDesc.text = ""
        }
    }
    @IBAction func btnHospitalNoAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnHospitalNo.isSelected = true
            self.btnHospitalYes.isSelected = false
            self.hospitalStr = "いいえ"
            self.txtHospitalDesc.isHidden = true
            self.txtHospitalDesc.text = ""
        }
    }
    
    @IBAction func btnLiveYesAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnLiveYes.isSelected = true
            self.btnLiveNo.isSelected = false
            self.medicleHistoryStr = "はい"
            self.txtLiveDesc.isHidden = false
            self.txtLiveDesc.text = ""
        }
    }
    @IBAction func btnLiveNoAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnLiveNo.isSelected = true
            self.btnLiveYes.isSelected = false
            self.medicleHistoryStr = "いいえ"
            self.txtLiveDesc.isHidden = true
            self.txtLiveDesc.text = ""
        }
    }
    
    /*@IBAction func btnPsycologicalGoodAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnPsycologiclePeriodGood.isSelected = true
            self.btnPsycologiclePeriodBad.isSelected = false
            self.btnPsycologiclePeriodMenopause.isSelected = false
            
            self.periodStr = "good"
        }
    }
    @IBAction func btnPsycologicalBadction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnPsycologiclePeriodBad.isSelected = true
            self.btnPsycologiclePeriodGood.isSelected = false
            self.btnPsycologiclePeriodMenopause.isSelected = false
            
            self.periodStr = "bad"
        }
    }
    @IBAction func btnPsycologicleMenopauseAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnPsycologiclePeriodMenopause.isSelected = true
            self.btnPsycologiclePeriodGood.isSelected = false
            self.btnPsycologiclePeriodBad.isSelected = false
            
            self.periodStr = "manopause"
        }
    }*/
    
    @IBAction func btnConcernWikiAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            sender.isSelected = true
            
            self.arrConcernList.add("ワキ")
        }
        else
        {
            sender.isSelected = false
            self.arrConcernList.remove("ワキ")
            
        }
    }
    @IBAction func btnConcernKneeAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            sender.isSelected = true
            
            self.arrConcernList.add("ひざ下")
        }
        else
        {
            sender.isSelected = false
            self.arrConcernList.remove("ひざ下")
            
        }
    }
    @IBAction func btnConcernThighAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            sender.isSelected = true
            
            self.arrConcernList.add("太もも")
        }
        else
        {
            sender.isSelected = false
            self.arrConcernList.remove("太もも")
            
        }
    }
    @IBAction func btnConcernElbowAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            sender.isSelected = true
            
            self.arrConcernList.add("ひじ下")
        }
        else
        {
            sender.isSelected = false
            self.arrConcernList.remove("ひじ下")
            
        }
    }
    @IBAction func btnConcernUpperArmAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            sender.isSelected = true
            
            self.arrConcernList.add("二の腕")
        }
        else
        {
            sender.isSelected = false
            self.arrConcernList.remove("二の腕")
            
        }
    }
    @IBAction func btnConcernBackAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            sender.isSelected = true
            
            self.arrConcernList.add("背中")
        }
        else
        {
            sender.isSelected = false
            self.arrConcernList.remove("背中")
            
        }
    }
    @IBAction func btnConcernChestHairAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            sender.isSelected = true
            
            self.arrConcernList.add("胸毛")
        }
        else
        {
            sender.isSelected = false
            self.arrConcernList.remove("胸毛")
            
        }
    }
    @IBAction func btnConcernLimbsAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            sender.isSelected = true
            
            self.arrConcernList.add("手足")
        }
        else
        {
            sender.isSelected = false
            self.arrConcernList.remove("手足")
            
        }
    }
    @IBAction func btnConcernNapeAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            sender.isSelected = true
            
            self.arrConcernList.add("うなじ")
        }
        else
        {
            sender.isSelected = false
            self.arrConcernList.remove("うなじ")
            
        }
    }
    @IBAction func btnConcernFaceAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            sender.isSelected = true
            
            self.arrConcernList.add("顔")
        }
        else
        {
            sender.isSelected = false
            self.arrConcernList.remove("顔")
            
        }
    }
    
    @IBAction func btnPeriodGoodAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnPeriodGood.isSelected = true
            self.btnPeriodBad.isSelected = false
            self.btnPeriodMenopause.isSelected = false
            
            self.periodStr = "良好"
        }
    }
    @IBAction func btnPeriodBadAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnPeriodBad.isSelected = true
            self.btnPeriodGood.isSelected = false
            self.btnPeriodMenopause.isSelected = false
            
            self.periodStr = "不調"
        }
    }
    @IBAction func btnPeriodMenopauseAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnPeriodMenopause.isSelected = true
            self.btnPeriodGood.isSelected = false
            self.btnPeriodBad.isSelected = false
            
            self.periodStr = "閉経"
        }
    }
    
    @IBAction func btnEsthicExperienceNoAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnEsthicExperienceNo.isSelected = true
            self.btnEsthicExperienceYes.isSelected = false
            self.btnEsthicExperienceOnly.isSelected = false

            self.estheticExperienceStr = "いいえ"
            
            self.txtEsthicExperienceDesc.isHidden = true
            self.txtEsthicExperienceDesc.text = ""
        }
    }
    @IBAction func btnEsthicExperienceOnlyAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnEsthicExperienceOnly.isSelected = true
            self.btnEsthicExperienceYes.isSelected = false
            self.btnEsthicExperienceNo.isSelected = false
            
            self.estheticExperienceStr = "体験のみ"
            
            self.txtEsthicExperienceDesc.isHidden = true
            self.txtEsthicExperienceDesc.text = ""
        }
    }
    @IBAction func btnEsthicExperienceYesAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnEsthicExperienceYes.isSelected = true
            self.btnEsthicExperienceNo.isSelected = false
            self.btnEsthicExperienceOnly.isSelected = false
            
            self.estheticExperienceStr = "はい"
            
            self.txtEsthicExperienceDesc.isHidden = false
            self.txtEsthicExperienceDesc.text = ""
        }
    }
    
    @IBAction func btnSurgeryNoAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnSurgeryNo.isSelected = true
            self.btnSurgeryYes.isSelected = false
            
            self.surgeryStr = "いいえ"
            
            self.txtSurgeryDesc.isHidden = true
            self.txtSurgeryDesc.text = ""
        }
    }
    @IBAction func btnSurgeryYesAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnSurgeryYes.isSelected = true
            self.btnSurgeryNo.isSelected = false
            
            self.surgeryStr = "はい"
            
            self.txtSurgeryDesc.isHidden = false
            self.txtSurgeryDesc.text = ""
        }
    }
    
    @IBAction func btnSubmitAction(_ sender: UIButton) {
    

        self.txtLiveDesc.text = self.txtLiveDesc.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.txtSurgeryDesc.text = self.txtSurgeryDesc.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.txtAlergyDesc.text = self.txtAlergyDesc.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.txtHospitalDesc.text = self.txtHospitalDesc.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.txtMedicineDesc.text = self.txtMedicineDesc.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.txtPhysicleStatusDesc.text = self.txtPhysicleStatusDesc.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.txtEsthicExperienceDesc.text = self.txtEsthicExperienceDesc.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if self.physicleStatusStr?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_PHYSICLE_STATUS, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if self.txtPhysicleStatusDesc.text?.count == 0 && self.physicleStatusStr == "不調"{
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_PHYSICLE_STATUS_TEXT, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            self.txtPhysicleStatusDesc.becomeFirstResponder()
            
            return
        }
        if self.alergyStr?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_ALLERGIES, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if self.txtAlergyDesc.text?.count == 0 && self.alergyStr == "はい"{
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_ALLERGIES_TEXT, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            self.txtAlergyDesc.becomeFirstResponder()
            
            return
        }
        if self.medicineStr?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_MEDICINE, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if self.txtMedicineDesc.text?.count == 0 && self.medicineStr == "はい"{
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_MEDICINE_TEXT, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            self.txtMedicineDesc.becomeFirstResponder()
            
            return
        }
        if self.hospitalStr?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_HOSPITAL, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if self.txtHospitalDesc.text?.count == 0 && self.hospitalStr == "はい"{
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_HOSPITAL_TEXT, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            self.txtHospitalDesc.becomeFirstResponder()
            
            return
        }
        if self.medicleHistoryStr?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_MEDICLEHISTORY, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if self.txtLiveDesc.text?.count == 0 && self.medicleHistoryStr == "はい"{
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_MEDICLEHISTORY_TEXT, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            self.txtLiveDesc.becomeFirstResponder()
            
            return
        }
        if self.periodStr?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_PERIOD, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if self.estheticExperienceStr?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_ESTHESTIC_EXPERIENCE, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if self.txtEsthicExperienceDesc.text?.count == 0 && self.estheticExperienceStr == "はい"{
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_ESTHESTIC_EXPERIENCE_TEXT, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            self.txtEsthicExperienceDesc.becomeFirstResponder()
            
            return
        }
        if self.surgeryStr?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_SURGERY, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if self.txtSurgeryDesc.text?.count == 0 && self.surgeryStr == "はい"{
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_SURGERY_TEXT, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            self.txtSurgeryDesc.becomeFirstResponder()
            
            return
        }
        
        self.showAgreement()

    }
    func showAgreement()
    {
        self.isAgreementVisible = true
        self.backgroundView.isHidden = false
        if UIApplication.shared.statusBarOrientation.isPortrait == true
        {
            self.objTermPolicyView = TermPolicyView(frame: CGRect(x: 10, y: 60, width: 728, height: 737))
            
        }
        else
        {
            self.objTermPolicyView = TermPolicyView(frame: CGRect(x: 10, y: 60, width: 984, height: 628))
            
        }
        self.objTermPolicyView.txtView.scrollRangeToVisible(NSMakeRange(0, 0))

        self.objTermPolicyView.btnAgree.addTarget(self, action: #selector(self.btnAgreeAction), for: .touchUpInside)
        self.objTermPolicyView.btnSubmit.addTarget(self, action: #selector(self.btnSubmitAgreeAction), for: .touchUpInside)
        self.objTermPolicyView.btnCancel.addTarget(self, action: #selector(self.btnCancelAgreeAction), for: .touchUpInside)

        self.view.addSubview(self.objTermPolicyView)
    }
   
    @objc func btnAgreeAction()
    {
        if self.objTermPolicyView.btnAgree.isSelected {
            
            self.objTermPolicyView.btnAgree.isSelected = false
        }
        else
        {
            self.objTermPolicyView.btnAgree.isSelected = true
            
        }
    }
    @objc func btnSubmitAgreeAction()
    {

        if self.objTermPolicyView.btnAgree.isSelected == true {
            
            self.backgroundView.isHidden = true
            self.isAgreementVisible = false

            self.objTermPolicyView.removeFromSuperview()
            self.submitFormData()
        }
       else
        {
            let alert = UIAlertController(title: "", message: "利用規約に同意してください", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    @objc func btnCancelAgreeAction()
    {
        self.isAgreementVisible = false

        self.backgroundView.isHidden = true
        
        self.objTermPolicyView.removeFromSuperview()
    }
    func saveServiceDetailToNote(custServiceId: String)
    {
        ConfigManager.showLoadingHUD(to_view: self.view)
        
        var parameters = [String : AnyObject] ()
        
        parameters["MethodName"] = "customer_analysis" as AnyObject
        parameters["user_id"] = ConfigManager.gUserId as AnyObject
        parameters["customer_id"] = self.customerId as AnyObject
        parameters["date"] = self.currentDate as AnyObject
        parameters["service_status"] = "1" as AnyObject

        var paramService = [String : Any] ()
        
        paramService["service"] = "脱毛"
        paramService["price"] = ""
        paramService["payment"] = ""
        paramService["customer_service_id"] = custServiceId as AnyObject
        paramService["service_id"] = "5" as AnyObject
        
        let arrServiceList:NSMutableArray! = NSMutableArray()
        
        arrServiceList.add(paramService)
        
        parameters["service_price"] = arrServiceList! as AnyObject
        
        if self.dateId != "" {
            
            parameters["id"] = self.dateId as AnyObject
            
        }
        
        print(parameters)
        
        self.objWebServiceController?.serverPostParameter(parameters: parameters)
    }
    func submitFormData()
    {
        
        ConfigManager.showLoadingHUD(to_view: self.view)

        let commaSeparatedString = self.arrConcernList.componentsJoined(by: ",")
        
        var parameters = [String : AnyObject] ()
        
        parameters["MethodName"] = "hairremoval_service" as AnyObject
        parameters["customer_id"] = self.customerId as AnyObject
        parameters["status"] = self.physicleStatusStr! as AnyObject
        parameters["status_text"] = self.txtPhysicleStatusDesc.text! as AnyObject
        parameters["allegy"] = self.alergyStr! as AnyObject
        parameters["allegy_text"] = self.txtAlergyDesc.text! as AnyObject
        parameters["medicine"] = self.medicineStr! as AnyObject
        parameters["medicine_text"] = self.txtMedicineDesc.text! as AnyObject
        parameters["hospital"] = self.hospitalStr! as AnyObject
        parameters["hospital_text"] = self.txtHospitalDesc.text! as AnyObject
        
        parameters["medical_history"] = self.medicineStr! as AnyObject
        parameters["medical_history_text"] = self.txtMedicineDesc.text! as AnyObject
        parameters["concern"] = commaSeparatedString as AnyObject
        parameters["period"] = self.periodStr as AnyObject
        parameters["esthe_experience"] = self.estheticExperienceStr! as AnyObject
        parameters["esthe_experience_text"] = self.txtEsthicExperienceDesc.text as AnyObject
        parameters["surgery"] = self.surgeryStr as AnyObject
        parameters["surgery_text"] = self.txtSurgeryDesc.text as AnyObject

        print(parameters)
        
        self.objWebServiceController?.serverParameter(parameters: parameters)
        
    }
    
    func serviceResponse(forURl urlString: String, response: JSON) {
        
        ConfigManager.hideLoadingHUD(for_view: self.view)
        
        if !(urlString == "server_error_handle") {
            
            if urlString == "hairremoval_service" {

            let customerID:String! = String(describing: response["customer_id"])
            let hairremovalId:String! = String(describing:response["hair_removal_id"])
            
            if customerID != nil {
                
                if hairremovalId != nil
                {
                    let alert = UIAlertController(title: "", message: "サービスを正常に追加しました", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    self.dismiss(animated: true) {
                        
                        if ConfigManager.isFromNote == true
                        {
                            self.saveServiceDetailToNote(custServiceId: hairremovalId)
                            
                        }
                        else
                        {
                            self.objThankYouPageViewController = ThankYouPageViewController(nibName: "ThankYouPageViewController", bundle: nil)
                            self.navigationController?.pushViewController(self.objThankYouPageViewController!, animated: true)
                            
                        }
                    }
                }
            }
                
            }
            else if urlString == "customer_analysis"
            {
                let status:String! = String(describing:response["status"])
                let msg:String! = String(describing:response["msg"])
                
                if status != nil
                {
                    if status == "success"
                    {
                        let controllers = self.navigationController?.viewControllers
                        for vc in controllers! {
                            if vc is AddNoteViewController {
                                _ = self.navigationController?.popToViewController(vc as! AddNoteViewController, animated: true)
                            }
                        }
                    }
                    else
                    {
                        if msg != nil
                        {
                            let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true)
                            
                        }
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
            scrollView.setContentOffset(CGPoint(x: 0, y: y+70), animated: true)
            
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        scrollView(toCenterOfScreen: textField, textfield: textField)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
            //textField.resignFirstResponder()
        self.resignTextField()

        return true
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        
        if self.isAgreementVisible == true {
            
            self.objTermPolicyView.removeFromSuperview()

            if UIDevice.current.orientation.isLandscape {
                print("Landscape")
                
                self.objTermPolicyView = TermPolicyView(frame: CGRect(x: 10, y: 60, width: 984, height: 628))
                self.objTermPolicyView.btnAgree.addTarget(self, action: #selector(self.btnAgreeAction), for: .touchUpInside)
                self.objTermPolicyView.btnSubmit.addTarget(self, action: #selector(self.btnSubmitAgreeAction), for: .touchUpInside)
                self.objTermPolicyView.btnCancel.addTarget(self, action: #selector(self.btnCancelAgreeAction), for: .touchUpInside)
                
                self.view.addSubview(self.objTermPolicyView)
                
                
            } else {
                print("Portrait")
                
                self.objTermPolicyView = TermPolicyView(frame: CGRect(x: 10, y: 60, width: 728, height: 737))
                self.objTermPolicyView.btnAgree.addTarget(self, action: #selector(self.btnAgreeAction), for: .touchUpInside)
                self.objTermPolicyView.btnSubmit.addTarget(self, action: #selector(self.btnSubmitAgreeAction), for: .touchUpInside)
                self.objTermPolicyView.btnCancel.addTarget(self, action: #selector(self.btnCancelAgreeAction), for: .touchUpInside)
                
                self.view.addSubview(self.objTermPolicyView)
                
            }
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
