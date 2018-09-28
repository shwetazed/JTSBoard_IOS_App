//
//  EyeLastServiceViewController.swift
//  JTSBoard
//
//  Created by jts on 03/07/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit
import SwiftyJSON

class EyeLastServiceViewController: UIViewController,WebServiceControllerDelegate,UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    var objWebServiceController: WebServiceController?
    var objTermsViewController: TermsViewController?
    var objThankYouPageViewController: ThankYouPageViewController?

    @IBOutlet weak var txtDryNessDesc: FloatLabelTextField!
    @IBOutlet weak var txtEyeSurgeryDesc: FloatLabelTextField!
    @IBOutlet weak var txtLasikDesc: FloatLabelTextField!

    @IBOutlet weak var txtSickEyeDesc: FloatLabelTextField!
    @IBOutlet weak var txtCongestionDesc: FloatLabelTextField!
    
    @IBOutlet weak var btnContactLenseNo: UIButton!
    @IBOutlet weak var btnContactLense1Day: UIButton!
    @IBOutlet weak var btnContactLenseHard: UIButton!
    @IBOutlet weak var btnContactLenseSoft: UIButton!

    @IBOutlet weak var btnDryNessYes: UIButton!
    @IBOutlet weak var btnDryNessNo: UIButton!

    @IBOutlet weak var btnEyeSicknessYes: UIButton!
    @IBOutlet weak var btnEyeSicknessNo: UIButton!
    
    @IBOutlet weak var btnCongesionYes: UIButton!
    @IBOutlet weak var btnCongesionNo: UIButton!
    
    @IBOutlet weak var btnEyeSurgeryYes: UIButton!
    @IBOutlet weak var btnEyeSurgeryNo: UIButton!

    @IBOutlet weak var btnLasikYes: UIButton!
    @IBOutlet weak var btnLasikNo: UIButton!

    @IBOutlet weak var btnEyslushPermsYes: UIButton!
    @IBOutlet weak var btnEyslushPermsNo: UIButton!
    
    @IBOutlet weak var btnPregnancyYes: UIButton!
    @IBOutlet weak var btnPregnancyNo: UIButton!
    
    @IBOutlet weak var btnAlagyAtopy: UIButton!
    @IBOutlet weak var btnAlagyHayFever: UIButton!
    @IBOutlet weak var btnAlagyRhinitis: UIButton!
    @IBOutlet weak var btnAlagyAsthama: UIButton!
    @IBOutlet weak var btnAlagyMetal: UIButton!
    @IBOutlet weak var btnAlagyFood: UIButton!
    @IBOutlet weak var btnAlagyMedicine: UIButton!
    @IBOutlet weak var btnAlagyCosmetic: UIButton!
    @IBOutlet weak var btnAlagyAdhesive: UIButton!
    @IBOutlet weak var btnAlagyTap: UIButton!
    @IBOutlet weak var btnAlagyAlcohal: UIButton!
    @IBOutlet weak var btnAlagyOthers: UIButton!
    
    @IBOutlet weak var btnCleansingGel: UIButton!
    @IBOutlet weak var btnCleansingOil: UIButton!
    @IBOutlet weak var btnCleansingCream: UIButton!
    @IBOutlet weak var btnCleansingLotion: UIButton!
    @IBOutlet weak var btnCleansingWipe: UIButton!

    
    @IBOutlet weak var btnAgree: UIButton!
    @IBOutlet weak var btnTermsCondition: UIButton!
    
    var customerId:String! = ""
    var contactLenseStr:String! = ""
    var drynessStr:String! = ""
    var sickEyeStr:String! = ""
    var congesionStr:String! = ""
    var surgeryStr:String! = ""
    var lasikStr:String! = ""
    var eyelushPermsStr:String! = ""
    var pragnancyStr:String! = ""
    var cleansingStr:String! = ""
    var termsStr:String! = ""

    var arrAlergyList = NSMutableArray()
  //  var arrCleansingList = NSMutableArray()
    
    var currentDate:String!
    var dateId:String!

    
    @IBOutlet weak var btnSubmit: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationItem.title = "アイユルサービス"
        self.navigationItem.title = "アイラッシュサービス"

       
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
        
       // self.resignTextField()
        
    }
    func resignTextField()
    {
        txtLasikDesc.resignFirstResponder()
        txtEyeSurgeryDesc.resignFirstResponder()
        txtDryNessDesc.resignFirstResponder()
        txtSickEyeDesc.resignFirstResponder()
        txtCongestionDesc.resignFirstResponder()

        
        
        UIView.beginAnimations("anim", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(0.25)
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        UIView.commitAnimations()
        
    }

    @IBAction func btnContactLenseNoAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnContactLenseNo.isSelected = true
            self.btnContactLense1Day.isSelected = false
            self.btnContactLenseHard.isSelected = false
            self.btnContactLenseSoft.isSelected = false

            self.contactLenseStr = "いいえ"
        }
    }
    @IBAction func btnContactLenseDayAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnContactLense1Day.isSelected = true
            self.btnContactLenseNo.isSelected = false
            self.btnContactLenseHard.isSelected = false
            self.btnContactLenseSoft.isSelected = false
            
            self.contactLenseStr = "1day"
        }
    }
    @IBAction func btnContactLenseHardAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnContactLenseHard.isSelected = true
            self.btnContactLenseNo.isSelected = false
            self.btnContactLense1Day.isSelected = false
            self.btnContactLenseSoft.isSelected = false
            
            self.contactLenseStr = "ハード"
        }
    }
    @IBAction func btnContactLenseSoftAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnContactLenseSoft.isSelected = true
            self.btnContactLenseNo.isSelected = false
            self.btnContactLense1Day.isSelected = false
            self.btnContactLenseHard.isSelected = false
            
            self.contactLenseStr = "ソフト"
        }
    }
    
    
    @IBAction func btnDrynessYesAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnDryNessYes.isSelected = true
            self.btnDryNessNo.isSelected = false
            
            self.txtDryNessDesc.isHidden = false
            self.txtDryNessDesc.text = ""
           
            self.drynessStr = "はい"
        }
    }
    @IBAction func btnDrynessNoAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnDryNessNo.isSelected = true
            self.btnDryNessYes.isSelected = false
            
            self.txtDryNessDesc.isHidden = true
            self.txtDryNessDesc.text = ""
            
            self.drynessStr = "いいえ"
        }
    }
    
    @IBAction func btnSicknessYesAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnEyeSicknessYes.isSelected = true
            self.btnEyeSicknessNo.isSelected = false
            
            self.sickEyeStr = "はい"
            
            self.txtSickEyeDesc.isHidden = false
            self.txtSickEyeDesc.text = ""
        }
    }
    @IBAction func btnSicknessNoAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnEyeSicknessNo.isSelected = true
            self.btnEyeSicknessYes.isSelected = false
            
            self.sickEyeStr = "いいえ"
            
            self.txtSickEyeDesc.isHidden = true
            self.txtSickEyeDesc.text = ""
        }
    }
    
    @IBAction func btnCongesionYesAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnCongesionYes.isSelected = true
            self.btnCongesionNo.isSelected = false
            
            self.congesionStr = "はい"
            
            self.txtCongestionDesc.isHidden = false
            self.txtCongestionDesc.text = ""
        }
    }
    @IBAction func btnCongesionNoAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnCongesionNo.isSelected = true
            self.btnCongesionYes.isSelected = false
            
            self.congesionStr = "いいえ"
            
            self.txtCongestionDesc.isHidden = true
            self.txtCongestionDesc.text = ""
        }
    }
    
    @IBAction func btnSurgeryYesAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnEyeSurgeryYes.isSelected = true
            self.btnEyeSurgeryNo.isSelected = false
            
            self.txtEyeSurgeryDesc.isHidden = false
            self.txtEyeSurgeryDesc.text = ""
            
            self.surgeryStr = "はい"
        }
    }
    @IBAction func btnSurgeryNoAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnEyeSurgeryNo.isSelected = true
            self.btnEyeSurgeryYes.isSelected = false
            
            self.txtEyeSurgeryDesc.isHidden = true
            self.txtEyeSurgeryDesc.text = ""
            
            self.surgeryStr = "いいえ"
        }
    }
    
    @IBAction func btnLasikYesAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnLasikYes.isSelected = true
            self.btnLasikNo.isSelected = false
            
            self.txtLasikDesc.isHidden = false
            self.txtLasikDesc.text = ""
            
            self.lasikStr = "はい"
        }
    }
    @IBAction func btnLasikNoAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnLasikNo.isSelected = true
            self.btnLasikYes.isSelected = false
            
            self.txtLasikDesc.isHidden = true
            self.txtLasikDesc.text = ""
            
            self.lasikStr = "いいえ"
        }
    }
    
    @IBAction func btnEyelushPermsYesAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnEyslushPermsYes.isSelected = true
            self.btnEyslushPermsNo.isSelected = false
            
            self.eyelushPermsStr = "はい"
        }
    }
    @IBAction func btnEyelushPermsNoAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnEyslushPermsNo.isSelected = true
            self.btnEyslushPermsYes.isSelected = false
            
            self.eyelushPermsStr = "いいえ"
        }
    }
    
    @IBAction func btnPregnancyYesAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnPregnancyYes.isSelected = true
            self.btnPregnancyNo.isSelected = false
            
            self.pragnancyStr = "はい"
        }
    }
    @IBAction func btnPregnancyNoAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnPregnancyNo.isSelected = true
            self.btnPregnancyYes.isSelected = false
            
            self.pragnancyStr = "いいえ"
        }
    }
    
    @IBAction func btnAlegyAtopyAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            sender.isSelected = true
            
            self.arrAlergyList.add("アトピー")
        }
        else
        {
            sender.isSelected = false
            self.arrAlergyList.remove("アトピー")
            
        }
    }
    @IBAction func btnAlegyHayFeverAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            sender.isSelected = true
            
            self.arrAlergyList.add("花粉症")
        }
        else
        {
            sender.isSelected = false
            self.arrAlergyList.remove("花粉症")
            
        }
    }
    @IBAction func btnAlegyRhinitisAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            sender.isSelected = true
            
            self.arrAlergyList.add("鼻炎")
        }
        else
        {
            sender.isSelected = false
            self.arrAlergyList.remove("鼻炎")
            
        }
    }
    @IBAction func btnAlegyAsthmaAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            sender.isSelected = true
            
            self.arrAlergyList.add("喘息")
        }
        else
        {
            sender.isSelected = false
            self.arrAlergyList.remove("喘息")
            
        }
    }
    @IBAction func btnAlegyMetalAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            sender.isSelected = true
            
            self.arrAlergyList.add("金属")
        }
        else
        {
            sender.isSelected = false
            self.arrAlergyList.remove("金属")
            
        }
    }
    @IBAction func btnAlegyFoodAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            sender.isSelected = true
            
            self.arrAlergyList.add("フード")
        }
        else
        {
            sender.isSelected = false
            self.arrAlergyList.remove("フード")
            
        }
    }
    @IBAction func btnAlegyMedicineAction(_ sender: UIButton) {
       
        if  sender.isSelected == false
        {
            sender.isSelected = true
            
            self.arrAlergyList.add("医学")
        }
        else
        {
            sender.isSelected = false
            self.arrAlergyList.remove("医学")
            
        }
    }
    @IBAction func btnAlegyCosmeticAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            sender.isSelected = true
            
            self.arrAlergyList.add("化粧品")
        }
        else
        {
            sender.isSelected = false
            self.arrAlergyList.remove("化粧品")
            
        }
    }
    @IBAction func btnAlegyAdhesiveAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            sender.isSelected = true
            
            self.arrAlergyList.add("接着剤")
        }
        else
        {
            sender.isSelected = false
            self.arrAlergyList.remove("接着剤")
            
        }
    }
    @IBAction func btnAlegyTapeAction(_ sender: UIButton) {
      
        if  sender.isSelected == false
        {
            sender.isSelected = true
            
            self.arrAlergyList.add("テープ")
        }
        else
        {
            sender.isSelected = false
            self.arrAlergyList.remove("テープ")
            
        }
    }
    @IBAction func btnAlegyAlcohalAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            sender.isSelected = true
            
            self.arrAlergyList.add("アルコール")
        }
        else
        {
            sender.isSelected = false
            self.arrAlergyList.remove("アルコール")
            
        }
    }
    @IBAction func btnAlegyOtherAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            sender.isSelected = true
            
            self.arrAlergyList.add("その他")
        }
        else
        {
            sender.isSelected = false
            self.arrAlergyList.remove("その他")
            
        }
    }
    
    @IBAction func btnAgreeTermsAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            sender.isSelected = true
            
            self.termsStr = "はい"
            
        }
        else
        {
            sender.isSelected = false
            self.termsStr = "いいえ"

            
        }
    }
    
    @IBAction func btnCleansingGelAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnCleansingGel.isSelected = true
            self.btnCleansingOil.isSelected = false
            self.btnCleansingCream.isSelected = false
            self.btnCleansingWipe.isSelected = false
            self.btnCleansingLotion.isSelected = false


            self.cleansingStr = "ジェル"
        }
       
    }
    @IBAction func btnCleansingOilAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnCleansingGel.isSelected = false
            self.btnCleansingOil.isSelected = true
            self.btnCleansingCream.isSelected = false
            self.btnCleansingWipe.isSelected = false
            self.btnCleansingLotion.isSelected = false
            
            
            self.cleansingStr = "オイル"
        }
    }
    @IBAction func btnCleansingCreamAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnCleansingGel.isSelected = false
            self.btnCleansingOil.isSelected = false
            self.btnCleansingCream.isSelected = true
            self.btnCleansingWipe.isSelected = false
            self.btnCleansingLotion.isSelected = false
            
            
            self.cleansingStr = "クリーム"
        }
    }
    @IBAction func btnCleansingLotionAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnCleansingGel.isSelected = false
            self.btnCleansingOil.isSelected = false
            self.btnCleansingCream.isSelected = false
            self.btnCleansingWipe.isSelected = false
            self.btnCleansingLotion.isSelected = true
            
            
            self.cleansingStr = "ローション"
        }
    }
    @IBAction func btnTCleansingWipeAction(_ sender: UIButton) {
        
        if  sender.isSelected == false
        {
            self.btnCleansingGel.isSelected = false
            self.btnCleansingOil.isSelected = false
            self.btnCleansingCream.isSelected = false
            self.btnCleansingWipe.isSelected = true
            self.btnCleansingLotion.isSelected = false
            
            
            self.cleansingStr = " 拭き取り"
        }
    }
    
    @IBAction func btnTermsConditionAction(_ sender: UIButton) {
        
        self.objTermsViewController = TermsViewController(nibName: "TermsViewController", bundle: nil)
        self.navigationController?.pushViewController(self.objTermsViewController!, animated: true)
    }
    
    @IBAction func btnSubmitAction(_ sender: UIButton) {
        
        self.txtLasikDesc.text = self.txtLasikDesc.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.txtEyeSurgeryDesc.text = self.txtEyeSurgeryDesc.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        self.txtDryNessDesc.text = self.txtDryNessDesc.text?.trimmingCharacters(in: .whitespacesAndNewlines)

        if self.contactLenseStr?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_CONTACT_LENSE, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if self.drynessStr?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_DRY_EYE, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if self.txtDryNessDesc.text?.count == 0 && self.drynessStr == "はい"{
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_DRY_EYE_TEXT, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            self.txtDryNessDesc.becomeFirstResponder()
            
            return
        }
        if self.sickEyeStr?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_SICK_EYE, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if self.txtSickEyeDesc.text?.count == 0 && self.sickEyeStr == "はい"{
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_SICK_EYE_TEXT, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            self.txtSickEyeDesc.becomeFirstResponder()
            
            return
        }
        if self.congesionStr?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_CONGESION, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if self.txtCongestionDesc.text?.count == 0 && self.congesionStr == "はい"{
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_CONGESION_TEXT, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            self.txtCongestionDesc.becomeFirstResponder()
            
            return
        }
        if self.surgeryStr?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_SURGERY, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if self.txtEyeSurgeryDesc.text?.count == 0 && self.surgeryStr?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_SURGERY_TEXT, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            self.txtEyeSurgeryDesc.becomeFirstResponder()

            return
        }
        if self.lasikStr?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_LASIK, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if self.txtLasikDesc.text?.count == 0 && self.lasikStr?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.AALERT_MSG_BLANK_LASIK_TEXT, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            self.txtLasikDesc.becomeFirstResponder()

            return
        }
        if self.eyelushPermsStr?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_EYELUSH_PERMS, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if self.pragnancyStr?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_PRAGNANCY, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        /*if self.arrAlergyList.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_ALLERGIES, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }*/
        if self.cleansingStr.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_CLEANSING, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        if self.termsStr?.count == 0 {
            
            let alert = UIAlertController(title: "", message: ConfigManager.ALERT_MSG_BLANK_TERMS, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        self.submitFormData()
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
        
        paramService["service"] = "アイラッシュ"
        paramService["price"] = ""
        paramService["payment"] = ""
        paramService["customer_service_id"] = custServiceId as AnyObject
        paramService["service_id"] = "3" as AnyObject
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

        var commaSeparatedAlegyString:String! = ""
      
        if self.arrAlergyList.count > 0
        {
            commaSeparatedAlegyString = self.arrAlergyList.componentsJoined(by: ",")

        }
       
        
        var parameters = [String : AnyObject] ()
        
        parameters["MethodName"] = "eyelush_service" as AnyObject
        parameters["customer_id"] = self.customerId as AnyObject
        parameters["contact_lense"] = self.contactLenseStr! as AnyObject
        parameters["dry_eye"] = self.drynessStr! as AnyObject
        parameters["dry_eye_text"] = self.txtDryNessDesc.text! as AnyObject
        parameters["sick_eye"] = self.sickEyeStr! as AnyObject
        parameters["sick_eye_extra"] = self.txtSickEyeDesc.text! as AnyObject

        parameters["congestion"] = self.congesionStr! as AnyObject
        parameters["congestion_extra"] = self.txtCongestionDesc.text! as AnyObject

        parameters["surgery"] = self.surgeryStr! as AnyObject
        parameters["surgery_text"] = self.txtEyeSurgeryDesc.text! as AnyObject
        parameters["lasik"] = self.lasikStr! as AnyObject
       
        parameters["lasik_text"] = self.txtLasikDesc.text! as AnyObject
        parameters["eye_perm"] = self.eyelushPermsStr! as AnyObject
        parameters["eye_perm_text"] = self.txtEyeSurgeryDesc.text! as AnyObject
        parameters["allegy"] = commaSeparatedAlegyString as AnyObject
        parameters["cleansing"] = self.cleansingStr as AnyObject
        parameters["pragnancy"] = self.pragnancyStr! as AnyObject
        parameters["agreement"] = self.termsStr as AnyObject
        
        print(parameters)
        
        self.objWebServiceController?.serverParameter(parameters: parameters)
        
    }
    func serviceResponse(forURl urlString: String, response: JSON) {
        
        ConfigManager.hideLoadingHUD(for_view: self.view)
        
        if !(urlString == "server_error_handle") {
            
            if urlString == "eyelush_service" {

            let customerID:String! = String(describing: response["customer_id"])
            let eyelushId:String! = String(describing:response["eyelush_id"])
            
            if customerID != nil {
                
                if eyelushId != nil
                {
                    let alert = UIAlertController(title: "", message: "サービスを正常に追加しました", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    self.dismiss(animated: true) {
                        
                        if ConfigManager.isFromNote == true
                        {
                            self.saveServiceDetailToNote(custServiceId: eyelushId)
                            
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
        
       
          //  textField.resignFirstResponder()
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
