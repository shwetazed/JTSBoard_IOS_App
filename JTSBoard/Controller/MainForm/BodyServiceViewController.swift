//
//  BodyServiceViewController.swift
//  JTSBoard
//
//  Created by jts on 03/07/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit
import SwiftyJSON

class BodyServiceViewController: UIViewController,WebServiceControllerDelegate,UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    var objWebServiceController: WebServiceController?
    var objThankYouPageViewController: ThankYouPageViewController?

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
    
    @IBOutlet weak var btnPsycologiclePeriodGood: UIButton!
    @IBOutlet weak var btnPsycologiclePeriodBad: UIButton!
    @IBOutlet weak var btnPsycologiclePeriodMenopause: UIButton!

    
    @IBOutlet weak var btnBirthExperiencePregnant: UIButton!
    @IBOutlet weak var btnBirthExperienceYes: UIButton!
    @IBOutlet weak var btnBirthExperienceNo: UIButton!
    
    @IBOutlet weak var btnBowelMovementGood: UIButton!
    @IBOutlet weak var btnBowlMovementConstipation: UIButton!
    
    @IBOutlet weak var txtSleepTime: UITextField!
    @IBOutlet weak var txtAverageSleepTime: UITextField!

    var customerId:String! = ""
    var physicleStatusStr:String! = ""
    var alergyStr:String! = ""
    var medicineStr:String! = ""
    var hospitalStr:String! = ""
    var periodStr:String! = ""
    var birthExperienceStr:String! = ""
    var bowlMovementStr:String! = ""
    var medicleHistoryStr:String! = ""
    @IBOutlet weak var btnSubmit: UIButton!
    
    var currentDate:String!
    var dateId:String!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "ボディサービス"
        
        self.btnSubmit.layer.cornerRadius = 5.0
        self.btnSubmit.clipsToBounds = true

        self.objWebServiceController = WebServiceController()
        self.objWebServiceController?.delegate = self
        // Do any additional setup after loading the view.
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
        txtPhysicleStatusDesc.resignFirstResponder()
        txtSleepTime.resignFirstResponder()
        txtMedicineDesc.resignFirstResponder()
        txtHospitalDesc.resignFirstResponder()
        txtAlergyDesc.resignFirstResponder()
        txtLiveDesc.resignFirstResponder()
        txtAverageSleepTime.resignFirstResponder()
        
        
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
    
    @IBAction func btnPsycologicalGoodAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnPsycologiclePeriodGood.isSelected = true
            self.btnPsycologiclePeriodBad.isSelected = false
            self.btnPsycologiclePeriodMenopause.isSelected = false
            
            self.periodStr = "良好"
        }
    }
    @IBAction func btnPsycologicalBadction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnPsycologiclePeriodBad.isSelected = true
            self.btnPsycologiclePeriodGood.isSelected = false
            self.btnPsycologiclePeriodMenopause.isSelected = false
            
            self.periodStr = "不調"
        }
    }
    @IBAction func btnPsycologicleMenopauseAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnPsycologiclePeriodMenopause.isSelected = true
            self.btnPsycologiclePeriodGood.isSelected = false
            self.btnPsycologiclePeriodBad.isSelected = false
            
            self.periodStr = "閉経"
        }
    }
    
    @IBAction func btnBirthExperiencePragnantAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnBirthExperiencePregnant.isSelected = true
            self.btnBirthExperienceYes.isSelected = false
            self.btnBirthExperienceNo.isSelected = false
            
            self.birthExperienceStr = "妊娠中"
        }
    }
    @IBAction func btnBirthExperienceYesction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnBirthExperienceYes.isSelected = true
            self.btnBirthExperiencePregnant.isSelected = false
            self.btnBirthExperienceNo.isSelected = false
            
            self.birthExperienceStr = "はい"
        }
    }
    @IBAction func btnBirthExperienceNoAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnBirthExperienceNo.isSelected = true
            self.btnBirthExperiencePregnant.isSelected = false
            self.btnBirthExperienceYes.isSelected = false
            
            self.birthExperienceStr = "いいえ"
        }
    }
    
    @IBAction func btnBowlMovementAction(_ sender: UIButton) {
        
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
        
        paramService["service"] = "ボディ"
        paramService["price"] = ""
        paramService["payment"] = ""
        paramService["customer_service_id"] = custServiceId as AnyObject
        paramService["service_id"] = "4" as AnyObject
        
        let arrServiceList:NSMutableArray! = NSMutableArray()
        
        arrServiceList.add(paramService)
        
        parameters["service_price"] = arrServiceList! as AnyObject
        
        if self.dateId != "" {
            
            parameters["id"] = self.dateId as AnyObject
            
        }
        
        print(parameters)
        
        self.objWebServiceController?.serverPostParameter(parameters: parameters)
    }
    @IBAction func btnSubmitAction(_ sender: UIButton) {
        
        self.txtLiveDesc.text = self.txtLiveDesc.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.txtSleepTime.text = self.txtSleepTime.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.txtAlergyDesc.text = self.txtAlergyDesc.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.txtHospitalDesc.text = self.txtHospitalDesc.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.txtAverageSleepTime.text = self.txtAverageSleepTime.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.txtSleepTime.text = self.txtSleepTime.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.txtMedicineDesc.text = self.txtMedicineDesc.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.txtPhysicleStatusDesc.text = self.txtPhysicleStatusDesc.text?.trimmingCharacters(in: .whitespacesAndNewlines)

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
        self.submitFormData()
    }
    func submitFormData()
    {
        
        ConfigManager.showLoadingHUD(to_view: self.view)
        
        var parameters = [String : AnyObject] ()
        
        parameters["MethodName"] = "body_service" as AnyObject
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
        parameters["period"] = self.periodStr! as AnyObject
        parameters["experience_of_birth"] = self.birthExperienceStr as AnyObject
        parameters["bowel_movement"] = self.bowlMovementStr as AnyObject
        parameters["sleep_start_time"] = self.txtSleepTime.text! as AnyObject
        parameters["sleep_time_avg"] = self.txtAverageSleepTime.text as AnyObject
        
        print(parameters)
        
        self.objWebServiceController?.serverParameter(parameters: parameters)
        
    }
    
    func serviceResponse(forURl urlString: String, response: JSON) {
        
        ConfigManager.hideLoadingHUD(for_view: self.view)
        
        if !(urlString == "server_error_handle") {
            
            if urlString == "body_service" {

            let customerID:String! = String(describing: response["customer_id"])
            let bodyserviceId:String! = String(describing:response["body_id"])
            
            if customerID != nil {
                
                if bodyserviceId != nil
                {
                    let alert = UIAlertController(title: "", message: "サービスを正常に追加しました", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    self.dismiss(animated: true) {
                        
                        if ConfigManager.isFromNote == true
                        {
                            self.saveServiceDetailToNote(custServiceId: bodyserviceId)
                            
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
        
       
           // textField.resignFirstResponder()
        self.resignTextField()

        
        return true
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
