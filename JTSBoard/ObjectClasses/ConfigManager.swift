//
//  ConfigManager.swift
//  SalonatApp
//
//  Created by Apple on 06/04/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Reachability
import MBProgressHUD
import CoreLocation

class ConfigManager: NSObject {

    public static let sharedAppDelegate = UIApplication.shared.delegate as! AppDelegate
    var reachability: Reachability?
    
    public static let kCurrentAppVersion:String! =  Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String

    //public static let gUrl:NSString!="http://jtsboard.com/web_services/"
   // public static let gUrl:NSString!="http://jtsboard.com/web_servicesv1/"
    //public static let gUrl:NSString!="http://jtsboard.com/web_servicesv3/"
    public static let gUrl:NSString!="https://jtsboard.com/web_servicesv8/"

    public static let gImageUrl:String! = "http://jtsboard.com//uploads/note_image/original/"
    public static var gDeviceToken:String!=""
    public static var gEmployeeCode:String!=""
    public static var gEmployeeRole:String!=""

    public static var kCheckRootViewController:String!=""

    public static var googleId:String!=""
    public static var facebookId:String!=""
    
    public static var gEmail:String!=""
    public static var gUserId:String!=""
    public static var gFormNumber:String!=""
    public static var gSalonId:String!=""
    public static var gIsAdmin:String!=""
    public static var gEmployeePinNumber:String!=""
    public static var gCustomerPinNumber:String!=""
    public static var gEmployeeId:String!=""
    public static var gEmployeeName:String!=""
    public static var gEmployeeImage:String!=""

    public static var checkSourceMedia:String!
    public static var gCurrentLatitude:Double!=0.0000000
    public static var gCurrentLongitude:Double!=0.000000
    public static var isSkip:Bool! = false
    public static var isLoginAtStart:Bool! = true
    public static var isFromNote:Bool! = true

    public static var userDic = [String:Any]()
    public static var userAddressDic = [String:Any]()

    public static let ALERT_MSG_NO_INTERNET: String!="Active internet connection not found"
    
    public static let ALERT_MSG_BLANK_EMAIL: String!="メールは空白にすることはできません"
    public static let ALERT_MSG_EMAIL_ALREADY_REGISTERED: String!="すでに登録されたメール"
    public static let ALERT_MSG_EMAIL_INVALID: String!="電子メールが有効でない"

    public static let ALERT_MSG_BLANK_PASSWORD: String!="パスワードは空白にできません"
    public static let ALERT_MSG_BLANK_CONFIRM_PASSWORD: String!="パスワードの確認は空白にできません"
    public static let ALERT_MSG_MINIMUM_PASSWORD_LENGTH: String!="パスワードは6文字以上でなければなりません"
    public static let ALERT_MSG_CONFIRM_PASSWORD_NOT_MATCH: String!="パスワードと確認パスワードは同じである必要があります"
    public static let ALERT_MSG_BLANK_EMP_PIN_NUM: String!="従業員PINコードを入力して下さい。"
    public static let ALERT_MSG_MINIMUM_EMP_PIN_LENGTH: String!="ピン番号は4桁でなければなりません"
    public static let ALERT_MSG_BLANK_START_DATE: String!="Please enter start date of month"
    public static let ALERT_MSG_START_DATE_LIMIT: String!="Start date can't be greater than 31"

    public static let ALERT_MSG_BLANK_CUST_PIN_NUM: String!="顧客PINコードを入力して下さい。"
    public static let ALERT_MSG_MINIMUM_CUST_PIN_LENGTH: String!="ピン番号は4桁でなければなりません"

    public static let ALERT_MSG_BLANK_ZIPCODE: String!="郵便番号は空白にできません"
    public static let ALERT_MSG_BLANK_COMPANYNAME: String!="会社名は空白にできません"
    public static let ALERT_MSG_BLANK_PREFECTURE: String!="県は空白にできません"
    public static let ALERT_MSG_BLANK_CITY: String!="市は空白にできません"
    public static let ALERT_MSG_BLANK_STREET_ADDRESS: String!="住所を空白にすることはできません"
    public static let ALERT_MSG_BLANK_APARTMENT_ADDRESS: String!="アパートメントの住所は空白にできません"

    public static let ALERT_MSG_BLANK_EMPLOYEEID: String!="従業員IDは空白にできません"
    public static let ALERT_MSG_BLANK_ADVERTISEMENT: String!="広告を空白にすることはできません"
    public static let ALERT_MSG_BLANK_AVERAGE_USERS: String!="1か月あたりの平均ユーザー数を入力してください"
    public static let ALERT_MSG_BLANK_WEBSITEURL: String!="ウェブサイトのURLは空白にできません"
    public static let ALERT_MSG_BLANK_IS_BRANCH: String!="ブランチ名は空白にできません"

    public static let ALERT_MSG_BLANK_PHONE_NO: String!="携帯電話番号は空白にできません"
    public static let ALERT_MSG_INVALID_PHONE_NO: String!="携帯電話番号が無効です"
    
    public static let ALERT_MSG_BLANK_KANA: String!="かなは空白にできません"
    public static let ALERT_MSG_BLANK_KANA_FNAME: String!="かなファーストネームは空白にできません"
    public static let ALERT_MSG_BLANK_KANA_LNAME: String!="かな姓は空にできません"

    public static let ALERT_MSG_BLANK_NAME: String!="名前を空白にすることはできません"
    public static let ALERT_MSG_BLANK_FNAME: String!="名前を空白にすることはできません"
    public static let ALERT_MSG_BLANK_LNAME: String!="名前を空白にすることはできません"

    public static let ALERT_MSG_BLANK_GENDER: String!="性別は空白にできません"
    public static let ALERT_MSG_BLANK_DOB: String!="誕生日を空白にすることはできません"
    public static let ALERT_MSG_BLANK_ADDRESS: String!="アドレスは空白にできません"
    public static let ALERT_MSG_BLANK_POSTALCODE: String!="郵便番号は空白にできません"
    public static let ALERT_MSG_BLANK_CAN_SEND_NEWSLETTER: String!="ニュースレターオプションを選択"
    public static let ALERT_MSG_BLANK_ARE_YOU_HOUSEWIFE: String!="家の妻の選択肢を選ぶ"
    public static let ALERT_MSG_BLANK_JOB: String!="ジョブを空白にすることはできません"
    public static let ALERT_MSG_BLANK_HOW_YOU_HEARD: String!="私たちのサロンについての聞き取り方法を選択してください"
    public static let ALERT_MSG_BLANK_HOW_YOU_COME: String!="サロンに来る方法を選択してください"
    public static let ALERT_MSG_BLANK_TODAY_COURSE: String!="今日のコースを選択"
    public static let ALERT_MSG_BLANK_AGE: String!="年齢は空白にできません"

    
    public static let ALERT_MSG_BLANK_PHYSICLE_STATUS: String!="身体状態を空白にすることはできません"
    public static let ALERT_MSG_BLANK_ALLERGIES: String!="アレルギーは空白にすることはできません"
    public static let ALERT_MSG_BLANK_MEDICINE: String!="薬の状態を空白にすることはできません"
    public static let ALERT_MSG_BLANK_HOSPITAL: String!="病院のステータスを空白にすることはできません"
    public static let ALERT_MSG_BLANK_MEDICLEHISTORY: String!="医療履歴は空白にできません"
    public static let ALERT_MSG_BLANK_PERIOD: String!="心理学は空白にすることはできません"
    public static let ALERT_MSG_BLANK_BIRTHEXPERIENCE: String!="生年月日は空白にできません"
    public static let ALERT_MSG_BLANK_BOWELMOVEMENT: String!="腸の動きを空白にすることはできません"
    public static let ALERT_MSG_BLANK_SLEEPTIME: String!="スリープ開始時間ブランキングできません"
    public static let ALERT_MSG_BLANK_AVERAGE_SLEEPTIME: String!="睡眠の平均時間は空白にすることはできません"
    public static let ALERT_MSG_BLANK_SKIN_PROBLEM: String!="スキンの問題は空白にすることはできません"
    public static let ALERT_MSG_BLANK_SKIN_EXTRA_PROBLEM: String!="皮膚のトラブルは空白にすることはできません"
    public static let ALERT_MSG_BLANK_SKIN_CONCERN_DATE: String!="懸念日を入力してください"

    public static let ALERT_MSG_BLANK_COSMATIC_NAME: String!="化粧品名は空白にできません"
    public static let ALERT_MSG_BLANK_MAINTAIN_MAKEOFF: String!="日常のケア・オフを提供する"
    public static let ALERT_MSG_BLANK_MAINTAIN_WASHINGFACE: String!="毎日のケア洗浄顔番号を提供する"
    public static let ALERT_MSG_BLANK_MAINTAIN_TONER: String!="毎日のケアトナー番号を提供する"
    public static let ALERT_MSG_BLANK_MAINTAIN_SCRUM: String!="毎日のケアスクラム番号を提供する"
    public static let ALERT_MSG_BLANK_MAINTAIN_LATEX: String!="毎日ケアラテックス番号を提供する"
    public static let ALERT_MSG_BLANK_MAINTAIN_CREAM: String!="毎日のケアクリーム数を提供する"
    public static let ALERT_MSG_BLANK_MAINTAIN_MAKEPACK: String!="毎日ケアパック番号を作る "
    public static let ALERT_MSG_BLANK_MAINTAIN_PEELING_SCRUB: String!="毎日のケアピーリングスクラブ番号を提供する"

    public static let ALERT_MSG_BLANK_PEELING: String!="ピーリング状態を空白にすることはできません"
    public static let ALERT_MSG_BLANK_TREATMENT: String!="治療の状態を空白にすることはできません"
    public static let ALERT_MSG_BLANK_ESTHESTIC_EXPERIENCE: String!="エステティックの経験のステータスは空白にできません"
    public static let ALERT_MSG_BLANK_SURGERY: String!="手術の状態を空白にすることはできません"
    public static let ALERT_MSG_BLANK_CONTACT_LENSE: String!="メガネのディテールを空白にすることはできません"
    public static let ALERT_MSG_BLANK_ITCHY: String!="主要な選択肢を選択"
    
    public static let ALERT_MSG_BLANK_DRY_EYE: String!="ドライアイ状態を選択"
    public static let ALERT_MSG_BLANK_SICK_EYE: String!="病的状態を選択する"
    public static let ALERT_MSG_BLANK_CONGESION: String!="輻輳状態を選択する"
    public static let ALERT_MSG_BLANK_LASIK: String!="ラシックディテールを選択"
    public static let ALERT_MSG_BLANK_EYELUSH_PERMS: String!="アイメッシュパーマの状態を選択"
    public static let ALERT_MSG_BLANK_PRAGNANCY: String!="病状の選択"
    public static let ALERT_MSG_BLANK_CLEANSING: String!="クレンジング方法の選択"
    public static let ALERT_MSG_BLANK_TERMS: String!="利用規約に同意する"
    
  


    public static let ALERT_MSG_BLANK_PHYSICLE_STATUS_TEXT: String!="身体状態の説明を空白にすることはできません"
    public static let ALERT_MSG_BLANK_ALLERGIES_TEXT: String!="アレルギーの詳細を空白にすることはできません"
    public static let ALERT_MSG_BLANK_MEDICINE_TEXT: String!="薬の説明を空白にすることはできません"
    public static let ALERT_MSG_BLANK_HOSPITAL_TEXT: String!="病院の説明を空白にすることはできません"
    public static let ALERT_MSG_BLANK_MEDICLEHISTORY_TEXT: String!="医療記録の説明を空白にすることはできません"
    public static let ALERT_MSG_BLANK_ESTHESTIC_EXPERIENCE_TEXT: String!="エステティックな経験の詳細を空白にすることはできません"
    public static let ALERT_MSG_BLANK_SURGERY_TEXT: String!="手術の説明を空白にすることはできません"
    public static let ALERT_MSG_BLANK_ITCHY_TEXT: String!="主要なダイズのステータスの説明を選択"
    public static let ALERT_MSG_BLANK_SKIN_PROBLEM_TEXT: String!="スキンの問題は空白にすることはできません"
    public static let ALERT_MSG_BLANK_DRY_EYE_TEXT: String!="ドライアイフォーメーションは空白にすることはできません"
    public static let AALERT_MSG_BLANK_LASIK_TEXT: String!="Lasikの問題は空白にすることはできません"
    public static let ALERT_MSG_BLANK_SICK_EYE_TEXT: String!="病的状態の説明を選択"
    public static let ALERT_MSG_BLANK_CONGESION_TEXT: String!="輻輳状態の説明を選択"


    struct ScreenSize
    {
        static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    
    struct DeviceType
    {
        static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
        static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
        static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
        static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
        static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
        static let IS_IPHONE_X         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 2436.0

    }
    
    struct Version{
        static let SYS_VERSION_FLOAT = (UIDevice.current.systemVersion as NSString).floatValue
        static let iOS7 = (Version.SYS_VERSION_FLOAT < 8.0 && Version.SYS_VERSION_FLOAT >= 7.0)
        static let iOS8 = (Version.SYS_VERSION_FLOAT >= 8.0 && Version.SYS_VERSION_FLOAT < 9.0)
        static let iOS9 = (Version.SYS_VERSION_FLOAT >= 9.0 && Version.SYS_VERSION_FLOAT < 10.0)
        static let iOS10 = (Version.SYS_VERSION_FLOAT >= 10.0)
        
    }
    


    class func IS_IPHONE() -> Bool {
        
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone {
            
            return true
        } else {
            
            return false
        }
    }
    
    class func validatePassword(_ password: String) -> Bool {
        let emailRegex: String = "(?=^.{8,}$)((?=.*\\d)|(?=.*\\W+))(?![.\n])(?=.*[!@#$%^&*\\-()?:;])(?=.*[a-zA-Z]).*$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: password)
    }
    class func validateZipCode(_ zipcode: String) -> Bool {
        let zipCodeRegex: String = "/^¥d{3}¥-¥d{4}$/"
        let zipCodeTest = NSPredicate(format: "SELF MATCHES %@", zipCodeRegex)
        return zipCodeTest.evaluate(with: zipcode)
    }
    
    
    class func validateEmail(_ email: String) -> Bool {
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    
    class func validatePhoneNum(_ phoneno: String) -> Bool {
        let emailRegex: String = "\\+?[0-9]{10}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: phoneno)
    }
    
    class func validateAlphabets(_ alpha: String) -> Bool {
        let abnRegex: String = "[A-Za-z]+"
        // check for one or more occurrence of string you can also use * instead + for ignoring null value
        let abnTest = NSPredicate(format: "SELF MATCHES %@", abnRegex)
        let isValid: Bool = abnTest.evaluate(with: alpha)
        return isValid
    }
    class func showInstalledFonts() {
        let familyNames = [Any](arrayLiteral: UIFont.familyNames)
        var fontNames: [Any]
        
        for indFamily in 0..<familyNames.count {
            print("Family name: \(familyNames[indFamily])")
            fontNames = [Any](arrayLiteral: UIFont.fontNames(forFamilyName: familyNames[indFamily] as! String))
            for indFont in 0..<fontNames.count {
                print("Font name: \(fontNames[indFont])")
            }
        }
    }
    class func showLoadingHUD(to_view: UIView) {
        
        let hud = MBProgressHUD.showAdded(to: to_view, animated: true)
        hud.label.text = "Loading..."
    }
    
    class func hideLoadingHUD(for_view: UIView) {
        MBProgressHUD.hide(for: for_view, animated: true)
    }
    
    class func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    class func getAddressFromZipCode(_ zipcode: String) -> [String : String] {
        
        var state: String! = ""
        var city: String! = ""
        var country: String! = ""

        print(zipcode)
        //let location: String = "450-0003"
        let location: String = "302017"

        let geocoder: CLGeocoder = CLGeocoder()
        geocoder.geocodeAddressString(location, completionHandler: {(placemarks: [CLPlacemark]?, error: Error?) -> Void in
            
           
            if placemarks != nil
            {
                if ((placemarks?.count)! > 0) {
                    let placemark: CLPlacemark = (placemarks?[0])!
                    country = placemark.country!
                    state = placemark.administrativeArea!
                    city = placemark.locality!
                    
                    
                }
            }
            
        } )
    
    var parameters = [String : String] ()
    parameters["country"] = country!
    parameters["state"] = state!
    parameters["city"] = city!

    return parameters
    }
    class func format(phoneNumber: String, shouldRemoveLastDigit: Bool = false) -> String {
      
        let aSet = NSCharacterSet(charactersIn:"0123456789-").inverted
        let compSepByCharInSet = phoneNumber.components(separatedBy: aSet)
        let phone = compSepByCharInSet.joined(separator: "")
        
        //let newString = phoneNumber.replacingOccurrences(of: "", with: "+", options: .literal, range: nil)

        guard !phone.isEmpty else { return "" }
        guard let regex = try? NSRegularExpression(pattern: "[\\s-\\(\\)]", options: .caseInsensitive) else { return "" }
        let r = NSString(string: phoneNumber).range(of: phone)
        var number = regex.stringByReplacingMatches(in: phone, options: .init(rawValue: 0), range: r, withTemplate: "")
        
        if number.count > 11 {
            let tenthDigitIndex = number.index(number.startIndex, offsetBy: 11)
            number = String(number[number.startIndex..<tenthDigitIndex])
        }
        
        if shouldRemoveLastDigit {
            let end = number.index(number.startIndex, offsetBy: number.count-1)
            number = String(number[number.startIndex..<end])
        }
        
        if number.count < 8 {
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{3})(\\d+)", with: "$1-$2", options: .regularExpression, range: range)
            
        } else {
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{3})(\\d{4})(\\d+)", with: "$1-$2-$3", options: .regularExpression, range: range)
        }
        
        return number
    }
    class func filledImageFrom(source: UIImage, fillColor: UIColor) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(source.size, false, UIScreen.main.scale)
        
        let context = UIGraphicsGetCurrentContext()
        fillColor.setFill()
        
        context!.translateBy(x: 0, y: source.size.height)
        context!.scaleBy(x: 1.0, y: -1.0)
        
        context!.setBlendMode(CGBlendMode.colorBurn)
        let rect = CGRect(x: 0, y: 0, width: source.size.width, height: source.size.height)
        context!.draw(source.cgImage!, in: rect)
        
        context!.setBlendMode(CGBlendMode.sourceIn)
        context!.addRect(rect)
        context!.drawPath(using: CGPathDrawingMode.fill)
        
        let coloredImg : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return coloredImg
    }
    /*class func isInternetAvailable() -> Bool {
        var flag: Bool = false
        
        let _HOST = "www.google.com" as NSString
        let reachability: Reacha = InternetReachability(hostName:_HOST as String!)
        
        let status: NetworkStatus = reachability.currentReachabilityStatus()
        if status == ReachableViaWiFi || status == ReachableViaWWAN {
            flag = true
        }
        return flag
    }*/
}
struct AppUtility {
    
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }
    
    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
        
        self.lockOrientation(orientation)
        
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
    }
    
}
