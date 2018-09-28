//
//  ServiceDetailViewController.swift
//  JTSBoard
//
//  Created by jts on 17/07/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit
import SwiftyJSON

class ServiceDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,WebServiceControllerDelegate {
   
    @IBOutlet weak var tblView: UITableView!
    
    let identifier = "servicedetailcell"
    let agreeIdentifier = "agreecell"

    
    var arrServieData = [String : AnyObject] ()
    
    var arrTitleList:NSMutableArray! = NSMutableArray()
    var arrValueList:NSMutableArray! = NSMutableArray()

    var objWebServiceController: WebServiceController?

    var customerId:String!
    var serviceId:String!
    var customerServiceId:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "サービスの詳細"

        self.objWebServiceController = WebServiceController()
        self.objWebServiceController?.delegate = self
        
        self.tblView.register(UINib(nibName: "ServiceDetailTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        self.tblView.register(UINib(nibName: "AgreeTableViewCell", bundle: nil), forCellReuseIdentifier: agreeIdentifier)

        self.getServiceData()
        // Do any additional setup after loading the view.
       
        
        // Do any additional setup after loading the view.
    }
   
    func setEstheTitleArrayValue()
    {
        self.arrTitleList.add("本日のご体調") // physicle status
        self.arrTitleList.add("アレルギー") // Allegy
        self.arrTitleList.add("常用薬（サプリメント含む）") // medicine
        
        self.arrTitleList.add("現在通院中・治療中ですか？") // hospital
       // self.arrTitleList.add("既住歴　過去に大きな病気や手術の経験はありますか？") // Medicle history
        
        self.arrTitleList.add("過去にかかった病気　過去に大きな病気や手術の経験はありますか？") // Medicle history

        self.arrTitleList.add("生理") // period
        
        self.arrTitleList.add("出産経験") // Birth experience
        self.arrTitleList.add("便通") // Bowl movement
        self.arrTitleList.add("睡眠　就寝時間") // sleep time
        
        self.arrTitleList.add("睡眠時間　平均") // sleep average time
        self.arrTitleList.add("お肌のお悩み") // skin concern
        self.arrTitleList.add("お肌の悩み　その他") // skin concern extra
        self.arrTitleList.add("いつ頃から気になり始めましたか？") //skin concern date
        self.arrTitleList.add("化粧品カブレ") //itchy
        
        self.arrTitleList.add("現在使用中の化粧品　メーカー名：") // cosmatic name
        self.arrTitleList.add("毎日のお手入れ方法  1から順番をお付けください。") // maintain
        self.arrTitleList.add("１週間以内にピーリングを行なっていますか？") // peeling
        self.arrTitleList.add("1ヶ月以内に肌活性トリートメント（光フェイシャルや超音波機器など）を行なっていますか？") //treatment
        self.arrTitleList.add("今までにエステサロンに行かれたことはありますか？") // esthe experience
        self.arrTitleList.add("今までに美容整形手術を受けたことはありますか？") //surgery
        self.arrTitleList.add("コンタクトレンズ着用") // contace lense

    }
    func setEstheArrayValue()
    {
        var status = ""
        
        if let statusStr = self.arrServieData["status"] as? String
        {
            status = statusStr
        }
        if let statusDescStr = self.arrServieData["status_text"] as? String
        {
            status = status + " " + statusDescStr
        }
        
        self.arrValueList.add(status) // physicle status
        
        var allegy = ""
        
        if let allegyStr = self.arrServieData["allegy"] as? String
        {
            allegy = allegyStr
        }
        if let allegyDescStr = self.arrServieData["allegy_text"] as? String
        {
            allegy = allegy + " " + allegyDescStr
        }
        self.arrValueList.add(allegy) // Allegy
        
        
        var medicine = ""
        
        if let medicineStr = self.arrServieData["medicine"] as? String
        {
            medicine = medicineStr
        }
        if let medicineDescStr = self.arrServieData["medicine_text"] as? String
        {
            medicine = medicine + " " + medicineDescStr
        }
      
        self.arrValueList.add(medicine) // medicine
        
        var hospital = ""
        
        if let hospitalStr = self.arrServieData["hospital"] as? String
        {
            hospital = hospitalStr
        }
        if let hospitalDescStr = self.arrServieData["hospital_text"] as? String
        {
            hospital = hospital + " " + hospitalDescStr
        }
        
        self.arrValueList.add(hospital) // hospital
        
        var medical_history = ""
        
        if let medical_historyStr = self.arrServieData["medical_history"] as? String
        {
            medical_history = medical_historyStr
        }
        if let medical_historyDescStr = self.arrServieData["medical_history_text"] as? String
        {
            medical_history = medical_history + " " + medical_historyDescStr
        }
        
        self.arrValueList.add(medical_history) // Medicle history
        
        if let period = self.arrServieData["period"] as? String
        {
            self.arrValueList.add(period) // period
        }
        else
        {
            self.arrValueList.add("") // period

        }
        if let experience_of_birth = self.arrServieData["experience_of_birth"] as? String
        {
            self.arrValueList.add(experience_of_birth) // period
        }
        else
        {
            self.arrValueList.add("") // period
            
        }
        if let bowel_movement = self.arrServieData["bowel_movement"] as? String
        {
            self.arrValueList.add(bowel_movement) // period
        }
        else
        {
            self.arrValueList.add("") // period
            
        }
        
        if let sleep_start_time = self.arrServieData["sleep_start_time"] as? String
        {
            self.arrValueList.add(sleep_start_time) // period
        }
        else
        {
            self.arrValueList.add("") // period
            
        }
        if let sleep_time_avg = self.arrServieData["sleep_time_avg"] as? String
        {
            self.arrValueList.add(sleep_time_avg) // period
        }
        else
        {
            self.arrValueList.add("") // period
            
        }
        
        if let concern = self.arrServieData["concern"] as? String
        {
            self.arrValueList.add(concern) // period
        }
        else
        {
            self.arrValueList.add("") // period
            
        }
        
        if let concern_extra = self.arrServieData["concern_extra"] as? String
        {
            self.arrValueList.add(concern_extra) // period
        }
        else
        {
            self.arrValueList.add("") // period
            
        }
        
        if let concern_date = self.arrServieData["concern_date"] as? String
        {
            self.arrValueList.add(concern_date) // period
        }
        else
        {
            self.arrValueList.add("") // period
            
        }
        
        
        var itchy = ""
        
        if let itchyStr = self.arrServieData["itchy"] as? String
        {
            itchy = itchyStr
        }
        if let itchyDescStr = self.arrServieData["itchy_text"] as? String
        {
            itchy = itchy + " " + itchyDescStr
        }
        
        self.arrValueList.add(itchy) //cosmatic name

        if let cosmetic_name = self.arrServieData["cosmetic_name"] as? String
        {
            self.arrValueList.add(cosmetic_name) // period
        }
        else
        {
            self.arrValueList.add("") // period
            
        }
        
        var maintainStr:String! = ""

        if (self.arrServieData["how_to_maintain"] != nil) {
            
            if self.arrServieData["how_to_maintain"] != nil {

            let maintainDic = self.arrServieData["how_to_maintain"]! as! NSDictionary
            
            let maintainKeyArray = maintainDic.allKeys
            
            for i in 0..<maintainKeyArray.count {
                
                let maintainTitle:String! = maintainKeyArray[i] as! String
                let maintainValue = String(describing: maintainDic[maintainTitle]!)
                
                maintainStr = maintainStr + maintainTitle + " = " + maintainValue
                
                if i != maintainKeyArray.count - 1
                {
                    maintainStr = maintainStr + " , "
                }
            }
            }
            
        }
        
        self.arrValueList.add(maintainStr) //maintain
        
        if let peeling = self.arrServieData["peeling"] as? String
        {
            self.arrValueList.add(peeling) // period
        }
        else
        {
            self.arrValueList.add("") // period
            
        }
        if let treatment = self.arrServieData["treatment"] as? String
        {
            self.arrValueList.add(treatment) // period
        }
        else
        {
            self.arrValueList.add("") // period
            
        }
        
        var esthe_experience = ""
        
        if let esthe_experienceStr = self.arrServieData["esthe_experience"] as? String
        {
            esthe_experience = esthe_experienceStr
        }
        if let esthe_experienceDescStr = self.arrServieData["esthe_experience_text"] as? String
        {
            esthe_experience = esthe_experience + " " + esthe_experienceDescStr
        }
     
        self.arrValueList.add(esthe_experience) // esthe experience
        
        var surgery = ""
        
        if let surgeryStr = self.arrServieData["surgery"] as? String
        {
            surgery = surgeryStr
        }
        if let surgeryDescStr = self.arrServieData["surgery_text"] as? String
        {
            surgery = surgery + " " + surgeryDescStr
        }
        
        self.arrValueList.add(surgery) // surgery
        
        var contact_lense = ""
       
        if let contactLense = self.arrServieData["contact_lense"] as? String
        {
            contact_lense = contactLense
        }
        if let contactLenseDesc = self.arrServieData["contact_lense_text"] as? String
        {
            contact_lense = contact_lense + " " + contactLenseDesc
        }
        
        self.arrValueList.add(contact_lense) // contace lense
        
    }
    func setEyelushTitleArrayValue()
    {
        self.arrTitleList.add("コンタクトレンズを使用していますか？") // contact lense
        self.arrTitleList.add("日常生活で、目の乾燥・かすみを感じることはありますか？") // Dryness
        self.arrTitleList.add("目や目元周りの病気にかかったことがありますか？") // Eys sickness
        
        self.arrTitleList.add("日常生活において、充血、ものもらい等になりやすいですか？") // congession
        self.arrTitleList.add("クリニック・病院において目に関する手術を受けたことがありますか？（美容整形を含む）") // Eys surgery
        self.arrTitleList.add("レーシック（近視手術等）受けたことがありますか？") // lasik
        
        self.arrTitleList.add("まつ毛パーマをしていますか？") // Eyelush param
        self.arrTitleList.add("現在、妊娠中、授乳中、整理中、いずれかに該当しますか？") // pragnancy
        self.arrTitleList.add("これまでにアレルギー症状が出たことはありますか？") // Alegy
        
        self.arrTitleList.add("クレンジングはどのタイプを使用していますか？") // cleansing
        
    }
    func setEyelushArrayValue()
    {
        var contact_lense = ""
        
        if let contactLense = self.arrServieData["contact_lense"] as? String
        {
            contact_lense = contactLense
        }
        if let contactLenseDesc = self.arrServieData["contact_lense_text"] as? String
        {
            contact_lense = contact_lense + " " + contactLenseDesc
        }
        self.arrValueList.add(contact_lense) // contace lense
        
        var dry_eye = ""
        
        if let dry_eyeStr = self.arrServieData["dry_eye"] as? String
        {
            dry_eye = dry_eyeStr
        }
        if let dry_eyeDesc = self.arrServieData["dry_eye_text"] as? String
        {
            dry_eye = dry_eye + " " + dry_eyeDesc
        }
        self.arrValueList.add(dry_eye) // Dry eye
        
        var sick_eye = ""
        
        if let sick_eyeStr = self.arrServieData["sick_eye"] as? String
        {
            sick_eye = sick_eyeStr
        }
        if let sick_eyeDesc = self.arrServieData["sick_eye_extra"] as? String
        {
            sick_eye = sick_eye + " " + sick_eyeDesc
        }
        self.arrValueList.add(sick_eye) // sick eye
        
        var congestion = ""
        
        if let congestionStr = self.arrServieData["congestion"] as? String
        {
            congestion = congestionStr
        }
        if let congestionDesc = self.arrServieData["congestion_extra"] as? String
        {
            congestion = congestion + " " + congestionDesc
        }
        self.arrValueList.add(congestion) // congestion
        
        var surgery = ""
        
        if let surgeryStr = self.arrServieData["surgery"] as? String
        {
            surgery = surgeryStr
        }
        if let surgeryDesc = self.arrServieData["surgery_text"] as? String
        {
            surgery = surgery + " " + surgeryDesc
        }
        self.arrValueList.add(surgery) // surgery
        
        var lasik = ""
        
        if let lasikStr = self.arrServieData["lasik"] as? String
        {
            lasik = lasikStr
        }
        if let lasikDesc = self.arrServieData["lasik_text"] as? String
        {
            lasik = lasik + " " + lasikDesc
        }
        self.arrValueList.add(lasik) // lasik
        
        var eye_perm = ""
        
        if let eye_permStr = self.arrServieData["eye_perm"] as? String
        {
            eye_perm = eye_permStr
        }
        if let eye_permDesc = self.arrServieData["lasik_text"] as? String
        {
            eye_perm = eye_perm + " " + eye_permDesc
        }
        self.arrValueList.add(eye_perm) // eye_perm
        
        if let allegy = self.arrServieData["allegy"] as? String
        {
            self.arrValueList.add(allegy) // eye_perm
        }
        else
        {
            self.arrValueList.add("") // eye_perm

        }
        if let cleansing = self.arrServieData["cleansing"] as? String
        {
            self.arrValueList.add(cleansing) // eye_perm
        }
        else
        {
            self.arrValueList.add("") // eye_perm
            
        }
        if let pragnancy = self.arrServieData["pragnancy"] as? String
        {
            self.arrValueList.add(pragnancy) // eye_perm
        }
        else
        {
            self.arrValueList.add("") // eye_perm
            
        }

    }
    func setBodyTitleArrayValue()
    {
        self.arrTitleList.add("本日のご体調") // Physicle status
        self.arrTitleList.add("アレルギー") // Alergy
        self.arrTitleList.add("常用薬（サプリメント含む）") // medicine
        
        self.arrTitleList.add("現在通院中・治療中ですか？") // hospital
        //self.arrTitleList.add("既住歴") // live
        self.arrTitleList.add("過去にかかった大きな病気") // live

        
        self.arrTitleList.add("生理") // psycology period
        
        self.arrTitleList.add("出産経験") // Birth experience
        self.arrTitleList.add("便通") // bowl movement
        self.arrTitleList.add("就寝時間") // sleep time
        
        self.arrTitleList.add("1日あたりの平均睡眠時間") // slepp average time
    }
    func setBodyArrayValue()
    {
        var status = ""
        
        if let statusStr = self.arrServieData["status"] as? String
        {
            status = statusStr
        }
        if let statusDescStr = self.arrServieData["status_text"] as? String
        {
            status = status + " " + statusDescStr
        }
        
        self.arrValueList.add(status) // physicle status
        
        var allegy = ""
        
        if let allegyStr = self.arrServieData["allegy"] as? String
        {
            allegy = allegyStr
        }
        if let allegyDescStr = self.arrServieData["allegy_text"] as? String
        {
            allegy = allegy + " " + allegyDescStr
        }
        
        self.arrValueList.add(allegy) // allegy
        
        var medicine = ""
        
        if let medicineStr = self.arrServieData["medicine"] as? String
        {
            medicine = medicineStr
        }
        if let medicineDescStr = self.arrServieData["medicine_text"] as? String
        {
            medicine = medicine + " " + medicineDescStr
        }
        
        self.arrValueList.add(medicine) // medicine
        
        var hospital = ""
        
        if let hospitalStr = self.arrServieData["hospital"] as? String
        {
            hospital = hospitalStr
        }
        if let hospitalDescStr = self.arrServieData["hospital_text"] as? String
        {
            hospital = hospital + " " + hospitalDescStr
        }
        
        self.arrValueList.add(hospital) // hospital
        
        var medical_history = ""
        
        if let medical_historyStr = self.arrServieData["medical_history"] as? String
        {
            medical_history = medical_historyStr
        }
        if let medical_historyDescStr = self.arrServieData["medical_history_text"] as? String
        {
            medical_history = medical_history + " " + medical_historyDescStr
        }
        
        self.arrValueList.add(medical_history) // medical_history
        
        if let period = self.arrServieData["period"] as? String
        {
            self.arrValueList.add(period) // experience_of_birth
        }
        else
        {
            self.arrValueList.add("") // experience_of_birth
            
        }
        if let experience_of_birth = self.arrServieData["experience_of_birth"] as? String
        {
            self.arrValueList.add(experience_of_birth) // experience_of_birth
        }
        else
        {
            self.arrValueList.add("") // experience_of_birth
            
        }
        if let bowel_movement = self.arrServieData["bowel_movement"] as? String
        {
            self.arrValueList.add(bowel_movement) // bowel_movement
        }
        else
        {
            self.arrValueList.add("") // bowel_movement
            
        }
        if let sleep_start_time = self.arrServieData["sleep_start_time"] as? String
        {
            self.arrValueList.add(sleep_start_time) // sleep_start_time
        }
        else
        {
            self.arrValueList.add("") // sleep_start_time
            
        }
        if let sleep_time_avg = self.arrServieData["sleep_time_avg"] as? String
        {
            self.arrValueList.add(sleep_time_avg) // sleep_time_avg
        }
        else
        {
            self.arrValueList.add("") // sleep_time_avg
            
        }
    }
    func setHairRemovalTitleArrayValue()
    {
        self.arrTitleList.add("本日のご体調") // Physicle status
        self.arrTitleList.add("アレルギー") // Alergy
        self.arrTitleList.add("常用薬（サプリメント含む）") // medicine
        
        self.arrTitleList.add("現在通院中・治療中ですか？") // hospital
       // self.arrTitleList.add("既住歴") // live
        self.arrTitleList.add("過去にかかった大きな病気") // live

        self.arrTitleList.add("気になるところ") // concern
        
        self.arrTitleList.add("生理") // period
        self.arrTitleList.add("今までにエステサロンに行かれたことはありますか？") // esthe experience
        self.arrTitleList.add("今までに美容整形手術を受けたことはありますか？") // surgery
        
    }
    func setHairRemovalArrayValue()
    {
        var status = ""
        
        if let statusStr = self.arrServieData["status"] as? String
        {
            status = statusStr
        }
        if let statusDescStr = self.arrServieData["status_text"] as? String
        {
            status = status + " " + statusDescStr
        }
        
        self.arrValueList.add(status) // physicle status
        
        var allegy = ""
        
        if let allegyStr = self.arrServieData["allegy"] as? String
        {
            allegy = allegyStr
        }
        if let allegyDescStr = self.arrServieData["allegy_text"] as? String
        {
            allegy = allegy + " " + allegyDescStr
        }
        
        self.arrValueList.add(allegy) // allegy
        
        var medicine = ""
        
        if let medicineStr = self.arrServieData["medicine"] as? String
        {
            medicine = medicineStr
        }
        if let medicineDescStr = self.arrServieData["medicine_text"] as? String
        {
            medicine = medicine + " " + medicineDescStr
        }
        
        self.arrValueList.add(medicine) // medicine
        
        var hospital = ""
        
        if let hospitalStr = self.arrServieData["hospital"] as? String
        {
            hospital = hospitalStr
        }
        if let hospitalDescStr = self.arrServieData["hospital_text"] as? String
        {
            hospital = hospital + " " + hospitalDescStr
        }
        
        self.arrValueList.add(hospital) // hospital
        
        var medical_history = ""
        
        if let medical_historyStr = self.arrServieData["medical_history"] as? String
        {
            medical_history = medical_historyStr
        }
        if let medical_historyDescStr = self.arrServieData["medical_history_text"] as? String
        {
            medical_history = medical_history + " " + medical_historyDescStr
        }
        
        self.arrValueList.add(medical_history) // medical_history
        
        if let concern = self.arrServieData["concern"] as? String
        {
            self.arrValueList.add(concern) // concern
        }
        else
        {
            self.arrValueList.add("") // concern
            
        }
        if let period = self.arrServieData["period"] as? String
        {
            self.arrValueList.add(period) // period
        }
        else
        {
            self.arrValueList.add("") // period
            
        }
        
        var esthe_experience = ""
        
        if let esthe_experienceStr = self.arrServieData["esthe_experience"] as? String
        {
            esthe_experience = esthe_experienceStr
        }
        if let esthe_experienceDescStr = self.arrServieData["esthe_experience_text"] as? String
        {
            esthe_experience = esthe_experience + " " + esthe_experienceDescStr
        }
        
        self.arrValueList.add(esthe_experience) // esthe_experience
        
        var surgery = ""
        
        if let surgeryStr = self.arrServieData["surgery"] as? String
        {
            surgery = surgeryStr
        }
        if let surgeryDescStr = self.arrServieData["surgery_text"] as? String
        {
            surgery = surgery + " " + surgeryDescStr
        }
        
        self.arrValueList.add(surgery) // surgery
        
    }
    func setFacialTitleArrayValue()
    {
        self.arrTitleList.add("本日のご体調") // physicle status
        self.arrTitleList.add("アレルギー") // Allegy
        self.arrTitleList.add("常用薬（サプリメント含む）") // medicine
        
        self.arrTitleList.add("現在通院中・治療中ですか？") // hospital
        // self.arrTitleList.add("既住歴　過去に大きな病気や手術の経験はありますか？") // Medicle history
        
        self.arrTitleList.add("過去にかかった病気　過去に大きな病気や手術の経験はありますか？") // Medicle history
        
        self.arrTitleList.add("生理") // period
        
        self.arrTitleList.add("出産経験") // Birth experience
        self.arrTitleList.add("便通") // Bowl movement
        self.arrTitleList.add("睡眠　就寝時間") // sleep time
        
        self.arrTitleList.add("睡眠時間　平均") // sleep average time
        self.arrTitleList.add("お肌のお悩み") // skin concern
        self.arrTitleList.add("お肌の悩み　その他") // skin concern extra
        self.arrTitleList.add("いつ頃から気になり始めましたか？") //skin concern date
        self.arrTitleList.add("化粧品カブレ") //itchy
        
        self.arrTitleList.add("現在使用中の化粧品　メーカー名：") // cosmatic name
 
        
    }
    func setFacialArrayValue()
    {
        var status = ""
        
        if let statusStr = self.arrServieData["status"] as? String
        {
            status = statusStr
        }
        if let statusDescStr = self.arrServieData["status_text"] as? String
        {
            status = status + " " + statusDescStr
        }
        
        self.arrValueList.add(status) // physicle status
        
        var allegy = ""
        
        if let allegyStr = self.arrServieData["allegy"] as? String
        {
            allegy = allegyStr
        }
        if let allegyDescStr = self.arrServieData["allegy_text"] as? String
        {
            allegy = allegy + " " + allegyDescStr
        }
        self.arrValueList.add(allegy) // Allegy
        
        
        var medicine = ""
        
        if let medicineStr = self.arrServieData["medicine"] as? String
        {
            medicine = medicineStr
        }
        if let medicineDescStr = self.arrServieData["medicine_text"] as? String
        {
            medicine = medicine + " " + medicineDescStr
        }
        
        self.arrValueList.add(medicine) // medicine
        
        var hospital = ""
        
        if let hospitalStr = self.arrServieData["hospital"] as? String
        {
            hospital = hospitalStr
        }
        if let hospitalDescStr = self.arrServieData["hospital_text"] as? String
        {
            hospital = hospital + " " + hospitalDescStr
        }
        
        self.arrValueList.add(hospital) // hospital
        
        var medical_history = ""
        
        if let medical_historyStr = self.arrServieData["medical_history"] as? String
        {
            medical_history = medical_historyStr
        }
        if let medical_historyDescStr = self.arrServieData["medical_history_text"] as? String
        {
            medical_history = medical_history + " " + medical_historyDescStr
        }
        
        self.arrValueList.add(medical_history) // Medicle history
        
        if let period = self.arrServieData["period"] as? String
        {
            self.arrValueList.add(period) // period
        }
        else
        {
            self.arrValueList.add("") // period
            
        }
        if let experience_of_birth = self.arrServieData["experience_of_birth"] as? String
        {
            self.arrValueList.add(experience_of_birth) // period
        }
        else
        {
            self.arrValueList.add("") // period
            
        }
        if let bowel_movement = self.arrServieData["bowel_movement"] as? String
        {
            self.arrValueList.add(bowel_movement) // period
        }
        else
        {
            self.arrValueList.add("") // period
            
        }
        
        if let sleep_start_time = self.arrServieData["sleep_start_time"] as? String
        {
            self.arrValueList.add(sleep_start_time) // period
        }
        else
        {
            self.arrValueList.add("") // period
            
        }
        if let sleep_time_avg = self.arrServieData["sleep_time_avg"] as? String
        {
            self.arrValueList.add(sleep_time_avg) // period
        }
        else
        {
            self.arrValueList.add("") // period
            
        }
        
        if let concern = self.arrServieData["concern"] as? String
        {
            self.arrValueList.add(concern) // period
        }
        else
        {
            self.arrValueList.add("") // period
            
        }
        
        if let concern_extra = self.arrServieData["concern_extra"] as? String
        {
            self.arrValueList.add(concern_extra) // period
        }
        else
        {
            self.arrValueList.add("") // period
            
        }
        
        if let concern_date = self.arrServieData["concern_date"] as? String
        {
            self.arrValueList.add(concern_date) // period
        }
        else
        {
            self.arrValueList.add("") // period
            
        }
        
        
        var itchy = ""
        
        if let itchyStr = self.arrServieData["itchy"] as? String
        {
            itchy = itchyStr
        }
        if let itchyDescStr = self.arrServieData["itchy_text"] as? String
        {
            itchy = itchy + " " + itchyDescStr
        }
        
        self.arrValueList.add(itchy) //cosmatic name
        
        if let cosmetic_name = self.arrServieData["cosmetic_name"] as? String
        {
            self.arrValueList.add(cosmetic_name) // period
        }
        else
        {
            self.arrValueList.add("") // period
            
        }
        
        
    }
    func getServiceData() {
        
        ConfigManager.showLoadingHUD(to_view: self.view)
        
        var parameters = [String : AnyObject] ()
        
        parameters["MethodName"] = "service_detail" as AnyObject
        parameters["customer_id"] = self.customerId as AnyObject
        parameters["service_id"] = self.serviceId as AnyObject
        parameters["customer_service_id"] = self.customerServiceId as AnyObject
       
        self.objWebServiceController?.serverParameter(parameters: parameters)
        
        
    }
    
    // MARK:  Tableview Bar delegate

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.arrServieData.count > 0 {
            
            if self.serviceId == "5" || self.serviceId == "6"
            {
                return self.arrTitleList.count + 1;

            }
            else
            {
                return self.arrTitleList.count;

            }
            
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
        
       
        if indexPath.row == self.arrTitleList.count
        {
            var cell: AgreeTableViewCell! = (tableView.dequeueReusableCell(withIdentifier: agreeIdentifier) as? AgreeTableViewCell?)!
                
            if cell == nil {
                    
                cell = tableView.dequeueReusableCell(withIdentifier: agreeIdentifier) as? AgreeTableViewCell
            }
                
            return cell
           
        }
        else
        {
            var cell: ServiceDetailTableViewCell! = (tableView.dequeueReusableCell(withIdentifier: identifier) as? ServiceDetailTableViewCell?)!
            
            if cell == nil {
                
                cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? ServiceDetailTableViewCell
            }
            
            cell.lblTitle.text = self.arrTitleList.object(at: indexPath.row) as? String
            cell.lblValue.text = self.arrValueList.object(at: indexPath.row) as? String
            
            return cell

        }
        
        
        
        
      /*  let keyArray:Array! = Array(self.arrServieData.keys)
        
        var title:String! = keyArray[indexPath.row]
        let value = String(describing: self.arrServieData[title]!)
        
        if title == "how_to_maintain" {
            
            let maintainDic = self.arrServieData[title]! as! NSDictionary

            let maintainKeyArray = maintainDic.allKeys
            
            var maintainStr:String! = ""
            
            for i in 0..<maintainKeyArray.count {
            
                let maintainTitle:String! = maintainKeyArray[i] as! String
                let maintainValue = String(describing: maintainDic[maintainTitle]!)
                
                maintainStr = maintainStr + maintainTitle + " = " + maintainValue
                
                if i != maintainKeyArray.count - 1
                {
                    maintainStr = maintainStr + " , "
                }
            }
            
            cell.lblValue.text = maintainStr

        }
        else
        {
            cell.lblValue.text = value

        }
        
        print(value)

        title = title.replacingOccurrences(of: "_", with: " ")
        
        print(self.arrServieData[keyArray[indexPath.row]]! as Any)
        
        cell.lblTitle.text = title.capitalized
        */
       
        

        
        
        
    }
    // MARK:  Webservice  delegate

    func serviceResponse(forURl urlString: String, response: JSON) {
        
        ConfigManager.hideLoadingHUD(for_view: self.view)
        
        if !(urlString == "server_error_handle") {
            
            if let resData = response["Service"].dictionaryObject {
                
                self.arrServieData = resData as [String : AnyObject]
            }
            
            if self.arrServieData.count > 0
            {

                if self.serviceId == "2"
                {
                    self.setEstheArrayValue()
                    self.setEstheTitleArrayValue()
                    self.tblView.reloadData()
                    
                }
                else if self.serviceId == "3"
                {
                    self.setEyelushArrayValue()
                    self.setEyelushTitleArrayValue()
                    self.tblView.reloadData()
                    
                }
                else if self.serviceId == "4"
                {
                    self.setBodyArrayValue()
                    self.setBodyTitleArrayValue()
                    self.tblView.reloadData()
                    
                }
                else if self.serviceId == "5"
                {
                    self.setHairRemovalArrayValue()
                    self.setHairRemovalTitleArrayValue()
                    self.tblView.reloadData()
                    
                }
                else if self.serviceId == "6"
                {
                    self.setFacialArrayValue()
                    self.setFacialTitleArrayValue()
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
