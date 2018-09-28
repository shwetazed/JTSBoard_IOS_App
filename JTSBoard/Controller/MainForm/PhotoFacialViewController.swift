//
//  PhotoFacialViewController.swift
//  JTSBoard
//
//  Created by jts on 30/08/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit
import SwiftyJSON

class PhotoFacialViewController: UIViewController,WebServiceControllerDelegate,UITextFieldDelegate {
    
    var objWebServiceController: WebServiceController?
    var objThankYouPageViewController: ThankYouPageViewController?
    var objTermPolicyView: TermPolicyView!
    @IBOutlet weak var backgroundView: UIView!
    var isAgreementVisible:Bool! = false

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtPhysicleStatusDesc: FloatLabelTextField!
    @IBOutlet weak var txtAlergyDesc: FloatLabelTextField!
    @IBOutlet weak var txtMedicineDesc: FloatLabelTextField!
    @IBOutlet weak var txtHospitalDesc: FloatLabelTextField!
    @IBOutlet weak var txtMedicalHistoryDesc: FloatLabelTextField!
    @IBOutlet weak var txtSleepTime: UITextField!
    @IBOutlet weak var txtAverageSleepTime: UITextField!
    @IBOutlet weak var txtSkinConcernExtra: FloatLabelTextField!
    @IBOutlet weak var txtSkinConcernDate: FloatLabelTextField!
    @IBOutlet weak var txtItchyName: FloatLabelTextField!
    @IBOutlet weak var txtCosmaticName: FloatLabelTextField!

    
    @IBOutlet weak var imgConcernBottom: UIImageView!
    @IBOutlet weak var btnPhysicleStatusGood: UIButton!
    @IBOutlet weak var btnPhysicleStatusBad: UIButton!
    
    @IBOutlet weak var btnAllergyYes: UIButton!
    @IBOutlet weak var btnAlergyNo: UIButton!
    
    @IBOutlet weak var btnMedicineYes: UIButton!
    @IBOutlet weak var btnMedicineNo: UIButton!
    
    @IBOutlet weak var btnHospitalYes: UIButton!
    @IBOutlet weak var btnHospitalNo: UIButton!
    
    @IBOutlet weak var btnMedicalHistoryYes: UIButton!
    @IBOutlet weak var btnMedicalHistoryNo: UIButton!
    
    @IBOutlet weak var btnPeriodGood: UIButton!
    @IBOutlet weak var btnPeriodBad: UIButton!
    @IBOutlet weak var btnPeriodMenopause: UIButton!
    
    @IBOutlet weak var btnBirtExperiencePregnant: UIButton!
    @IBOutlet weak var btnBirthExperienceYes: UIButton!
    @IBOutlet weak var btnBirthExperienceNone: UIButton!
    
    @IBOutlet weak var btnSkinConsernSpots: UIButton!
    @IBOutlet weak var btnSkinConcernWrinkles: UIButton!
    @IBOutlet weak var btnSkinConcernSagging: UIButton!
    @IBOutlet weak var btnSkinConcernDullness: UIButton!
    @IBOutlet weak var btnSkinConcernDryness: UIButton!
    @IBOutlet weak var btnSkinConcernAcnescar: UIButton!
    @IBOutlet weak var btnSkinConcernPoreOpening: UIButton!
    @IBOutlet weak var btnSkinConcernDarkning: UIButton!
    @IBOutlet weak var btnSkinConcernRedFace: UIButton!
    @IBOutlet weak var btnSkinConcernSensitiveSkin: UIButton!
    @IBOutlet weak var btnSkinConcernOther: UIButton!
    
    @IBOutlet weak var skinConcernTextfieldHeight: NSLayoutConstraint!
    @IBOutlet weak var skinConcernDateHeight: NSLayoutConstraint!
    
    @IBOutlet weak var btnItchyYes: UIButton!
    @IBOutlet weak var btnItchyNo: UIButton!
    
    @IBOutlet weak var btnPeelingYes: UIButton!
    @IBOutlet weak var btnPeelingNo: UIButton!
    
    @IBOutlet weak var btnTreatmentYes: UIButton!
    @IBOutlet weak var btnTreatmentNo: UIButton!
    
    @IBOutlet weak var btnBowelMovementGood: UIButton!
    @IBOutlet weak var btnBowlMovementConstipation: UIButton!
    @IBOutlet weak var btnEstheExperienceNo: UIButton!
    @IBOutlet weak var btnEsthyExperienceYes: UIButton!
    @IBOutlet weak var btnEstheExpereinceOnly: UIButton!
    
    @IBOutlet weak var btnSurgeryNo: UIButton!
    @IBOutlet weak var btnSurgeryYes: UIButton!
    @IBOutlet weak var btnSurgeryExperienceOnly: UIButton!
    
    @IBOutlet weak var btnContactLensesNo: UIButton!
    
    @IBOutlet weak var btnContactLensesYesSoft: UIButton!
    
    @IBOutlet weak var btnContactLensesYesHard: UIButton!
    
    var physicleStatusStr:String! = ""
    var alergyStr:String! = ""
    var medicineStr:String! = ""
    var hospitalStr:String! = ""
    var medicleHistoryStr:String! = ""
    var periodStr:String! = ""
    var birthExperienceStr:String! = ""
    var itchyStr:String! = ""
    var peelingStr:String! = ""
    var treatmentStr:String! = ""
    var bowlMovementStr:String! = ""
    var esthyExperienceStr:String! = ""
    var surgeryStr:String! = ""
    var contactLenseStr:String! = ""
    var customerId:String! = ""
    
    var arrSkinConcernList = NSMutableArray()
    @IBOutlet weak var btnSubmit: UIButton!
    
    var currentDate:String!
    var dateId:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "フェイシャル"
        
        self.btnSubmit.layer.cornerRadius = 5.0
        self.btnSubmit.clipsToBounds = true
        
        // unsafeBitCast(0x7fc05e479660, to: UIView.self).backgroundColor = UIColor.red
        // unsafeBitCast(0x00000001160e9070, to: UIView.self).backgroundColor = UIColor.blue
        
        self.backgroundView.alpha = 0.3
        
        self.txtSkinConcernExtra.isHidden = true
        self.txtSkinConcernExtra.text = ""
        self.skinConcernTextfieldHeight.constant = 0
        self.skinConcernDateHeight.constant = 0
        
        txtPhysicleStatusDesc.text = ""
        txtAlergyDesc.text = ""
        txtMedicineDesc.text = ""
        txtHospitalDesc.text = ""
        txtMedicalHistoryDesc.text = ""
        txtSleepTime.text = ""
        txtAverageSleepTime.text = ""
        txtSkinConcernExtra.text = ""
        txtSkinConcernDate.text = ""
        txtItchyName.text = ""
        txtCosmaticName.text = ""
        
        
        
        self.objWebServiceController = WebServiceController()
        self.objWebServiceController?.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTapFrom))
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 163/255, green: 125/255, blue: 30/255, alpha: 1.0)
        
        
        // Do any additional setup after loading the view.
    }
    @objc func handleTapFrom(recognizer : UITapGestureRecognizer ) {
        
        //self.resignTextField()
        
    }
    func resignTextField()
    {
        txtAverageSleepTime.resignFirstResponder()
        txtSleepTime.resignFirstResponder()
        self.txtAverageSleepTime.resignFirstResponder()
        txtMedicineDesc.resignFirstResponder()
        txtHospitalDesc.resignFirstResponder()
        txtAlergyDesc.resignFirstResponder()
        txtItchyName.resignFirstResponder()
        txtCosmaticName.resignFirstResponder()
        self.txtPhysicleStatusDesc.resignFirstResponder()
        
        self.txtSkinConcernDate.resignFirstResponder()
        self.txtSkinConcernExtra.resignFirstResponder()
        
        
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
    @IBAction func btnAllergyYesAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnAllergyYes.isSelected = true
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
            self.btnAllergyYes.isSelected = false
            self.alergyStr = "いいえ"
            self.txtAlergyDesc.isHidden = true
            self.txtAlergyDesc.text = ""
            
        }
    }
    @IBAction func btnMedicineYesAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnMedicineYes.isSelected = true
            self.btnMedicineNo.isSelected = false
            self.medicineStr = "はい"
            self.txtMedicineDesc.isHidden = false
            self.txtMedicineDesc.text = ""
            
        }
    }
    @IBAction func btnMedicineNoAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnMedicineNo.isSelected = true
            self.btnMedicineYes.isSelected = false
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
    @IBAction func btnMedicalHistoryYesAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnMedicalHistoryYes.isSelected = true
            self.btnMedicalHistoryNo.isSelected = false
            self.medicleHistoryStr = "はい"
            self.txtMedicalHistoryDesc.isHidden = false
            self.txtMedicalHistoryDesc.text = ""
        }
    }
    @IBAction func btnMedicalHistoryNoAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnMedicalHistoryNo.isSelected = true
            self.btnMedicalHistoryYes.isSelected = false
            self.medicleHistoryStr = "いいえ"
            self.txtMedicalHistoryDesc.isHidden = true
            self.txtMedicalHistoryDesc.text = ""
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
    @IBAction func btnBirtExperiencePregnantAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnBirtExperiencePregnant.isSelected = true
            self.btnBirthExperienceYes.isSelected = false
            self.btnBirthExperienceNone.isSelected = false
            
            self.birthExperienceStr = "妊娠中"
        }
    }
    @IBAction func btnBirthExperienceYesAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnBirthExperienceYes.isSelected = true
            self.btnBirtExperiencePregnant.isSelected = false
            self.btnBirthExperienceNone.isSelected = false
            
            self.birthExperienceStr = "はい"
        }
    }
    @IBAction func btnBirthExperienceNoneAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnBirthExperienceNone.isSelected = true
            self.btnBirtExperiencePregnant.isSelected = false
            self.btnBirthExperienceYes.isSelected = false
            
            self.birthExperienceStr = "いいえ"
        }
    }
    @IBAction func btnBowelMovementGoodAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnBowelMovementGood.isSelected = true
            self.btnBowlMovementConstipation.isSelected = false
            
            self.bowlMovementStr = "良好"
        }
    }
    
    @IBAction func btnBowlMovementConstipationAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnBowlMovementConstipation.isSelected = true
            self.btnBowelMovementGood.isSelected = false
            
            self.bowlMovementStr = "便秘"
        }
    }
    @IBAction func btnSkinConsernSpotsAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            sender.isSelected = true
            
            self.arrSkinConcernList.add("シミ")
            
        }
        else
        {
            sender.isSelected = false
            self.arrSkinConcernList.remove("シミ")
            
        }
        
        
    }
    @IBAction func btnSkinConcernWrinklesAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            sender.isSelected = true
            
            self.arrSkinConcernList.add("しわ")
        }
        else
        {
            sender.isSelected = false
            self.arrSkinConcernList.remove("しわ")
            
        }
        
    }
    @IBAction func btnSkinConcernSaggingAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            sender.isSelected = true
            
            self.arrSkinConcernList.add("たるみ")
        }
        else
        {
            sender.isSelected = false
            self.arrSkinConcernList.remove("たるみ")
            
        }
    }
    @IBAction func btnSkinConcernDullnessAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            sender.isSelected = true
            
            self.arrSkinConcernList.add("くすみ")
        }
        else
        {
            sender.isSelected = false
            self.arrSkinConcernList.remove("くすみ")
            
        }
    }
    @IBAction func btnSkinConcernDrynessAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            sender.isSelected = true
            
            self.arrSkinConcernList.add("乾燥")
        }
        else
        {
            sender.isSelected = false
            self.arrSkinConcernList.remove("乾燥")
            
        }
    }
    @IBAction func btnSkinConcernAcnescarAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            sender.isSelected = true
            
            self.arrSkinConcernList.add("乾燥, ニキビ・ニキビ跡")
        }
        else
        {
            sender.isSelected = false
            self.arrSkinConcernList.remove("乾燥, ニキビ・ニキビ跡")
            
        }
    }
    @IBAction func btnSkinConcernPoreOpeningAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            sender.isSelected = true
            
            self.arrSkinConcernList.add("毛穴の開き")
        }
        else
        {
            sender.isSelected = false
            self.arrSkinConcernList.remove("毛穴の開き")
            
        }
    }
    @IBAction func btnSkinConcernDarkningAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            sender.isSelected = true
            
            self.arrSkinConcernList.add("毛穴の黒ずみ・ざらつき")
        }
        else
        {
            sender.isSelected = false
            self.arrSkinConcernList.remove("毛穴の黒ずみ・ざらつき")
            
        }
    }
    @IBAction func btnSkinConcernRedFaceAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            sender.isSelected = true
            
            self.arrSkinConcernList.add("赤ら顔")
        }
        else
        {
            sender.isSelected = false
            self.arrSkinConcernList.remove("赤ら顔")
            
        }
    }
    @IBAction func btnSkinConcernSensitiveSkinAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            sender.isSelected = true
            
            self.arrSkinConcernList.add("敏感肌")
        }
        else
        {
            sender.isSelected = false
            self.arrSkinConcernList.remove("敏感肌")
            
        }
    }
    @IBAction func btnSkinConcernOtherAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            sender.isSelected = true
            
            self.arrSkinConcernList.add("その他")
            
            self.txtSkinConcernExtra.isHidden = false
            self.txtSkinConcernExtra.text = ""
            self.txtSkinConcernDate.isHidden = false
            self.imgConcernBottom.isHidden = false
            
            self.txtSkinConcernDate.text = ""
            self.skinConcernTextfieldHeight.constant = 50
            self.skinConcernDateHeight.constant = 50
            
        }
        else
        {
            sender.isSelected = false
            self.arrSkinConcernList.remove("その他")
            self.imgConcernBottom.isHidden = true
            
            self.txtSkinConcernExtra.isHidden = true
            self.txtSkinConcernExtra.text = ""
            self.txtSkinConcernDate.isHidden = true
            self.txtSkinConcernDate.text = ""
            self.skinConcernTextfieldHeight.constant = 0
            self.skinConcernDateHeight.constant = 0
        }
    }
    @IBAction func btnItchyYesAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnItchyYes.isSelected = true
            self.btnItchyNo.isSelected = false
            
            self.itchyStr = "はい"
            
            self.txtItchyName.isHidden = false
            self.txtItchyName.text = ""
        }
    }
    @IBAction func btnItchyNoAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnItchyNo.isSelected = true
            self.btnItchyYes.isSelected = false
            
            self.itchyStr = "いいえ"
            
            self.txtItchyName.isHidden = true
            self.txtItchyName.text = ""
        }
    }
   
    
    @IBAction func btnSubmitAction(_ sender: UIButton) {
        
        self.txtPhysicleStatusDesc.text = self.txtPhysicleStatusDesc.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.txtAlergyDesc.text = self.txtAlergyDesc.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.txtMedicineDesc.text = self.txtMedicineDesc.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.txtMedicalHistoryDesc.text = self.txtMedicalHistoryDesc.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.txtHospitalDesc.text = self.txtHospitalDesc.text?.trimmingCharacters(in: .whitespacesAndNewlines)
             self.txtItchyName.text = self.txtItchyName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.txtSleepTime.text = self.txtSleepTime.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.txtCosmaticName.text = self.txtCosmaticName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
      
        
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
        if self.txtMedicalHistoryDesc.text?.count == 0 && self.medicleHistoryStr == "はい"{
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_MEDICLEHISTORY_TEXT, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            self.txtMedicalHistoryDesc.becomeFirstResponder()
            
            return
        }
        if self.periodStr?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_PERIOD, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if self.birthExperienceStr?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_BIRTHEXPERIENCE, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if self.bowlMovementStr?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_BOWELMOVEMENT, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if self.txtSleepTime.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_SLEEPTIME, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            self.txtSleepTime.becomeFirstResponder()
            
            return
        }
        if self.txtAverageSleepTime.text?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_AVERAGE_SLEEPTIME, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            self.txtAverageSleepTime.becomeFirstResponder()
            
            return
        }
        if self.arrSkinConcernList.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_SKIN_PROBLEM, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if self.txtSkinConcernExtra.text?.count == 0 && self.arrSkinConcernList.contains("その他"){
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_SKIN_PROBLEM_TEXT, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            self.txtSkinConcernExtra.becomeFirstResponder()
            
            return
        }
        /* if self.txtSkinConcernExtra.text?.count == 0 {
         
         let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_SKIN_EXTRA_PROBLEM, preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
         self.present(alert, animated: true)
         self.txtSkinConcernExtra.becomeFirstResponder()
         
         return
         }*/
        if self.txtSkinConcernDate.text?.count == 0 && self.arrSkinConcernList.contains("その他"){
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_SKIN_CONCERN_DATE, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            self.txtSkinConcernDate.becomeFirstResponder()
            
            return
        }
        if self.itchyStr?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_ITCHY, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if self.txtItchyName.text?.count == 0 && self.itchyStr == "はい"{
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_ITCHY_TEXT, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            self.txtItchyName.becomeFirstResponder()
            
            return
        }
        if self.txtCosmaticName.text?.count == 0{
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_COSMATIC_NAME, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            self.txtCosmaticName.becomeFirstResponder()
            
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
    @objc func btnCancelAgreeAction()
    {
        self.isAgreementVisible = false
        
        self.backgroundView.isHidden = true
        
        self.objTermPolicyView.removeFromSuperview()
    }
    @objc func btnSubmitAgreeAction()
    {
        if self.objTermPolicyView.btnAgree.isSelected == true {
            
            self.isAgreementVisible = false
            
            self.backgroundView.isHidden = true
            
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
    func submitFormData()
    {
        ConfigManager.showLoadingHUD(to_view: self.view)
        
        var commaSeparatedString = self.arrSkinConcernList.componentsJoined(by: ",")
        
        if (self.txtSkinConcernExtra.text?.count)! > 0 {
            
            commaSeparatedString = commaSeparatedString + "," + self.txtSkinConcernExtra.text!
            
        }
        
        var parameters = [String : AnyObject] ()
        
        parameters["MethodName"] = "facial_service" as AnyObject
        parameters["customer_id"] = self.customerId as AnyObject
        parameters["status"] = self.physicleStatusStr! as AnyObject
        parameters["status_text"] = self.txtPhysicleStatusDesc.text! as AnyObject
        parameters["allegy"] = self.alergyStr! as AnyObject
        parameters["allegy_text"] = self.txtAlergyDesc.text! as AnyObject
        parameters["medicine"] = self.medicineStr! as AnyObject
        parameters["medicine_text"] = self.txtMedicalHistoryDesc.text! as AnyObject
        parameters["hospital"] = self.hospitalStr! as AnyObject
        parameters["hospital_text"] = self.txtHospitalDesc.text! as AnyObject
        parameters["medical_history"] = self.medicleHistoryStr! as AnyObject
        parameters["medical_history_text"] = self.txtMedicalHistoryDesc.text! as AnyObject
        parameters["period"] = self.periodStr! as AnyObject
        parameters["experience_of_birth"] = self.birthExperienceStr! as AnyObject
        parameters["bowel_movement"] = self.bowlMovementStr! as AnyObject
        parameters["sleep_start_time"] = self.txtSleepTime.text! as AnyObject
        parameters["sleep_time_avg"] = self.txtAverageSleepTime.text! as AnyObject
        parameters["concern"] = commaSeparatedString as AnyObject
        parameters["concern_extra"] = self.txtSkinConcernExtra.text! as AnyObject
        parameters["concern_date"] = self.txtSkinConcernDate.text! as AnyObject
        parameters["itchy"] = self.itchyStr! as AnyObject
        parameters["itchy_text"] = self.txtItchyName.text! as AnyObject
        parameters["cosmetic_name"] = self.txtCosmaticName.text! as AnyObject
        
        
        print(parameters)
        
        self.objWebServiceController?.serverParameter(parameters: parameters)
        
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
        
        paramService["service"] = "フェイシャル"
        paramService["price"] = ""
        paramService["payment"] = ""
        paramService["customer_service_id"] = custServiceId as AnyObject
        paramService["service_id"] = "6" as AnyObject
        
        let arrServiceList:NSMutableArray! = NSMutableArray()
        
        arrServiceList.add(paramService)
        
        parameters["service_price"] = arrServiceList! as AnyObject
        
        if self.dateId != "" {
            
            parameters["id"] = self.dateId as AnyObject
            
        }
        
        print(parameters)
        
        self.objWebServiceController?.serverPostParameter(parameters: parameters)
    }
    func serviceResponse(forURl urlString: String, response: JSON) {
        
        ConfigManager.hideLoadingHUD(for_view: self.view)
        
        if !(urlString == "server_error_handle") {
            
            if urlString == "facial_service"
            {
                let customerID:String! = String(describing: response["customer_id"])
                let facialId:String! = String(describing:response["facial_id"])
                
                if customerID != nil {
                    
                    if facialId != nil
                    {
                        let alert = UIAlertController(title: "", message: "サービスを正常に追加しました", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true)
                        
                        self.dismiss(animated: true) {
                            
                            if ConfigManager.isFromNote == true
                            {
                                self.saveServiceDetailToNote(custServiceId: facialId)
                                
                            }
                            else
                            {
                                
                                self.objThankYouPageViewController = ThankYouPageViewController(nibName: "ThankYouPageViewController", bundle: nil)
                                self.navigationController?.pushViewController(self.objThankYouPageViewController!, animated: true)
                                
                            }
                            
                            // self.navigationController?.popViewController(animated: true)
                            
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.txtSkinConcernDate {
            
            textField.resignFirstResponder()
            let alert = UIAlertController(style: .actionSheet, source: textField, title: "Date Picker", message: "Select Date of Birth", tintColor: UIColor.white)
            
            alert.addDatePicker(mode: .date, date: Date(), minimumDate: nil, maximumDate: nil) { date in
                print(date)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                let date1: Date? = date
                print(dateFormatter.string(from: date1!))
                
                self.txtSkinConcernDate.text = (dateFormatter.string(from: date1!))
            }
            
            alert.addAction(UIAlertAction(title: "Done", style: .destructive, handler: { (action) -> Void in
                if let textField = self.txtSkinConcernDate {
                    
                }
            }))
            
            // alert.addAction(title: "Done", style: .cancel)
            alert.show()
            
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
                self.objTermPolicyView.txtView.scrollRangeToVisible(NSMakeRange(0, 0))

                self.view.addSubview(self.objTermPolicyView)
                
                
            } else {
                print("Portrait")
                
                self.objTermPolicyView = TermPolicyView(frame: CGRect(x: 10, y: 60, width: 728, height: 737))
                self.objTermPolicyView.btnAgree.addTarget(self, action: #selector(self.btnAgreeAction), for: .touchUpInside)
                self.objTermPolicyView.btnSubmit.addTarget(self, action: #selector(self.btnSubmitAgreeAction), for: .touchUpInside)
                self.objTermPolicyView.btnCancel.addTarget(self, action: #selector(self.btnCancelAgreeAction), for: .touchUpInside)
                self.objTermPolicyView.txtView.scrollRangeToVisible(NSMakeRange(0, 0))

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
