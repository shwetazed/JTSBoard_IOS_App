//
//  NoteDetailViewController.swift
//  JTSBoard
//
//  Created by jts on 02/08/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit
import SwiftyJSON

class NoteDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,WebServiceControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate,UIPopoverPresentationControllerDelegate  {
    
    
    var pickerView:UIPickerView!
    var objWebServiceController: WebServiceController?
    var objAddFormViewController:AddFormViewController?
    
    @IBOutlet weak var btnDeletedImages: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    var objEstheServiceViewController:EstheServiceViewController!
    var objEyeLastServiceViewController:EyeLastServiceViewController!
    var objBodyServiceViewController:BodyServiceViewController!
    var objHairRemovalServiceViewController:HairRemovalServiceViewController!
    var objPhotoFacialViewController:PhotoFacialViewController!
    var objServiceDetailViewController:ServiceDetailViewController!
    var objDeletedImageViewController:DeletedImageViewController!

    @IBOutlet weak var tblService: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var btnAddService: UIButton!
    @IBOutlet weak var txtNote: UITextView!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnUploadImage: UIButton!
    
    @IBOutlet weak var tblServieHeight: NSLayoutConstraint!
    @IBOutlet weak var serviceView: UIView!
    @IBOutlet weak var imgNote: UIImageView!
    @IBOutlet weak var imgNoteHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    var arrServiceList:NSMutableArray! = NSMutableArray()
    var arrServiceTextfield:NSMutableArray! = NSMutableArray()
    var arrSalonServices:NSMutableArray! = NSMutableArray()
    var arrPaymentMethod:NSMutableArray! = NSMutableArray()
    var arrImageList:NSMutableArray! = NSMutableArray()
    var arrUploadImageList:NSMutableArray! = NSMutableArray()
    var arrTempServiceList:NSMutableArray! = NSMutableArray()

    let picker = UIImagePickerController()
    let serviceIdentifier = "addservicecell"
    let imageCellIdentifier = "imagecellI";
    
    var cell: AddServiceTableViewCell!
    
    var tableHeight:CGFloat!
    var collectionHeight:CGFloat!
    
    var serviceCount:Int!
    var customerId:String!
    var currentDate:String!
    var dateId:String!
    var uploadedNoteImage:String!
    
    var pickerType:String!
    var keypadType:String!
    var isBackSpace:Bool!
    
    var imageDeletedIndex:Int!

    
    var selectedTextfield:UITextField!
    
    let btnKeypadReturn = UIButton(type: UIButtonType.custom)
    
    var collectionItemSize:CGSize!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ConfigManager.gEmployeeImage == nil
        {
            ConfigManager.gEmployeeImage = ""
            
        }
        if ConfigManager.gEmployeeName == nil
        {
            ConfigManager.gEmployeeName = ""
            
        }
        if ConfigManager.gEmployeeId == nil
        {
            ConfigManager.gEmployeeId = ""
            
        }
        print(self.dateId)
        
        self.setLayout()
        
        self.objWebServiceController = WebServiceController()
        self.objWebServiceController?.delegate = self
        
        self.setArrayListValues()
        
        print(self.dateId)
        if self.dateId != "" {
            
            self.getCustomerServiceDetail()
        }
        self.collectionView.reloadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(NoteDetailViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(NoteDetailViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // Do any additional setup after loading the view.
        let formButton = UIButton(type: .custom)
        formButton.setImage(UIImage(named: "form"), for: .normal) // Image can be downloaded from here below link
        formButton.setTitle("", for: .normal)
        formButton.addTarget(self, action: #selector(self.btnFormAction), for: .touchUpInside)
        formButton.setTitleColor(UIColor.black, for: .normal)
        
        if ConfigManager.DeviceType.IS_IPAD {
            
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: formButton)
            
        }
        else
        {
            if ConfigManager.gEmployeeRole == "6" || ConfigManager.gEmployeeRole == "7"
            {
                self.btnAddService.isHidden = true
            }
        }
        
        self.setHeight()
        // Do any additional setup after loading the view.
    }
    
    func setLayout()
    {
        self.btnKeypadReturn.setTitle("Return", for: UIControlState())
        self.btnKeypadReturn.setTitleColor(UIColor.black, for: UIControlState())
        self.btnKeypadReturn.frame = CGRect(x: 0, y: 163, width: 106, height: 53)
        self.btnKeypadReturn.adjustsImageWhenHighlighted = false
        self.btnKeypadReturn.addTarget(self, action: #selector(self.Done(_:)), for: UIControlEvents.touchUpInside)
        serviceCount = 1;
        picker.delegate = self
        
        self.tableHeight = 0
        self.tblServieHeight.constant = tableHeight
        self.tblService.isHidden = true
        self.serviceView.isHidden = true
        
        self.collectionHeight = 0
        self.collectionViewHeight.constant = collectionHeight
        self.collectionView.isHidden = true
        
        self.btnDeletedImages.layer.cornerRadius = 5.0
        self.btnDeletedImages.clipsToBounds = true
        self.btnDeletedImages.layer.borderWidth = 2.0
        self.btnDeletedImages.layer.borderColor = UIColor(red: 170/255, green: 171/255, blue: 175/255, alpha: 1.0).cgColor
        
        
        
        self.txtNote.layer.cornerRadius = 5.0
        self.btnSubmit.layer.cornerRadius = 5.0
        
        
        self.tblService.register(UINib(nibName: "AddServiceTableViewCell", bundle: nil), forCellReuseIdentifier: serviceIdentifier)
        
        self.collectionView.register(UINib.init(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:imageCellIdentifier)
        
        
        self.setTableHeight()
        
        self.tblServieHeight.constant = self.tableHeight
        self.tblService.isHidden = false
        self.serviceView.isHidden = false
        
        
    }
    func setHeight()
    {
        self.setTableHeight()
        
        self.tblServieHeight.constant = self.tableHeight
        self.tblService.isHidden = false
        
        self.tblService.delegate = self
        self.tblService.dataSource = self
        self.tblService.reloadData()
        self.scrollView.isHidden = false
        
        self.setCollectionHeight()
        
        self.collectionView.isHidden = false
        
        self.collectionViewHeight.constant = self.collectionHeight
        self.collectionView.isHidden = false
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()
    }
    
    func setArrayListValues()
    {
        self.arrSalonServices.add("ネイル")
        self.arrSalonServices.add("エステ")
        self.arrSalonServices.add("アイラッシュ")
        self.arrSalonServices.add("ボディ")
        self.arrSalonServices.add("脱毛")
        self.arrSalonServices.add("フェイシャル")
        
        self.arrPaymentMethod.add("現金")
        self.arrPaymentMethod.add("カード")
        self.arrPaymentMethod.add("チケット")
        
        //        self.arrImageList.add("")
        //        self.arrImageList.add("")
        //        self.arrImageList.add("")
        //        self.arrImageList.add("")
        //        self.arrImageList.add("")
        //        self.arrImageList.add("")
        //        self.arrImageList.add("")
        //        self.arrImageList.add("")
        
    }
    
    func setTableHeight()
    {
        self.tableHeight = (CGFloat(self.arrServiceList.count + serviceCount) * 260) + 20
        
        for i in 0..<self.arrServiceList.count {
            
            let serviceId = (self.arrServiceList.object(at: i) as! NSDictionary).object(forKey: "customer_service_id") as? String
            let customerServiceId = (self.arrServiceList.object(at: i) as! NSDictionary).object(forKey: "customer_service_id") as? String
            
            if serviceId == nil || customerServiceId == nil
            {
                self.tableHeight = self.tableHeight - 45
            }
            
        }
    }
    func setCollectionHeight()
    {
       /*var heightC:CGFloat!
        let floatArrayCount:Float!
        
        if ConfigManager.IS_IPHONE() {
            
            heightC = (self.collectionView.frame.size.width)/3
            floatArrayCount = Float(self.arrImageList.count + self.arrUploadImageList.count) / Float(3)
            
        }
        else
        {
            heightC = (self.collectionView.frame.size.width)/4
            floatArrayCount = Float(self.arrImageList.count + self.arrUploadImageList.count) / Float(4)
            
        }
        
        let arrayCount = ceilf(floatArrayCount)
        
        self.collectionHeight = (((CGFloat(CGFloat(arrayCount))) * heightC)) + 20*/
        
        //  self.collectionHeight = self.collectionHeight -
        
        let arrayCount:Int!
        arrayCount = self.arrImageList.count + self.arrUploadImageList.count
        self.collectionHeight = (((CGFloat(CGFloat(arrayCount))) * 300)) + 20

    }
    @objc func btnFormAction()
    {
        ConfigManager.isFromNote = true
        self.objAddFormViewController = AddFormViewController()
        self.objAddFormViewController?.customerId = self.customerId
        self.objAddFormViewController?.currentDate = self.currentDate
        self.objAddFormViewController?.dateId = self.dateId
        
        self.navigationController?.pushViewController(self.objAddFormViewController!, animated: true)
    }
    
    
    func createServicePicker(textField:UITextField)
    {
        var alertTitle:String!
        
        if textField.tag == 2 {
            
            alertTitle = "サービスを選択"
            self.pickerType = "service"
        }
        if textField.tag == 3 {
            
            alertTitle = "払いの種類"
            self.pickerType = "payment"
            
        }
        let alertView = UIAlertController(
            title: alertTitle,
            message: "\n\n\n\n\n\n\n\n\n",
            preferredStyle: .alert)
        
        self.pickerView = UIPickerView(frame:
            CGRect(x: 0, y: 50, width: 260, height: 162))
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        
        // comment this line to use white color
        self.pickerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        
        
        alertView.view.addSubview(self.pickerView)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            //  Do some action here.
            
            if textField.tag == 2 {
                
                textField.text =  self.arrSalonServices.object(at: self.pickerView.selectedRow(inComponent: 0)) as? String

               /* if textField.text == "エステ"
                {
                    self.objEstheServiceViewController = EstheServiceViewController(nibName: "EstheServiceViewController", bundle: nil)
                    self.objEstheServiceViewController.customerId = self.customerId!
                    self.objEstheServiceViewController?.currentDate = self.currentDate
                    self.objEstheServiceViewController?.dateId = self.dateId
                    ConfigManager.isFromNote = true
                    
                    textField.text = ""

                    
                    self.navigationController?.pushViewController(self.objEstheServiceViewController!, animated: true)
                }
                else if textField.text == "アイラッシュ"
                {
                    self.objEyeLastServiceViewController = EyeLastServiceViewController(nibName: "EyeLastServiceViewController", bundle: nil)
                    self.objEyeLastServiceViewController.customerId = self.customerId!
                    self.objEyeLastServiceViewController?.currentDate = self.currentDate
                    self.objEyeLastServiceViewController?.dateId = self.dateId
                    ConfigManager.isFromNote = true
                    
                    textField.text = ""

                    
                    self.navigationController?.pushViewController(self.objEyeLastServiceViewController!, animated: true)
                }
                else if textField.text == "ボディ"
                {
                    self.objBodyServiceViewController = BodyServiceViewController(nibName: "BodyServiceViewController", bundle: nil)
                    self.objBodyServiceViewController.customerId = self.customerId!
                    self.objBodyServiceViewController?.currentDate = self.currentDate
                    self.objBodyServiceViewController?.dateId = self.dateId
                    ConfigManager.isFromNote = true
                    
                    textField.text = ""

                    
                    self.navigationController?.pushViewController(self.objBodyServiceViewController!, animated: true)
                }
                else if textField.text == "脱毛"
                {
                    self.objHairRemovalServiceViewController = HairRemovalServiceViewController(nibName: "HairRemovalServiceViewController", bundle: nil)
                    self.objHairRemovalServiceViewController.customerId = self.customerId!
                    self.objHairRemovalServiceViewController?.currentDate = self.currentDate
                    self.objHairRemovalServiceViewController?.dateId = self.dateId
                    ConfigManager.isFromNote = true
                    
                    textField.text = ""

                    self.navigationController?.pushViewController(self.objHairRemovalServiceViewController!, animated: true)
                }
                else if textField.text == "フェイシャル"
                {
                    self.objPhotoFacialViewController = PhotoFacialViewController(nibName: "PhotoFacialViewController", bundle: nil)
                    self.objPhotoFacialViewController.customerId = self.customerId!
                    self.objPhotoFacialViewController?.currentDate = self.currentDate
                    self.objPhotoFacialViewController?.dateId = self.dateId
                    ConfigManager.isFromNote = true
                    
                    textField.text = ""
                    
                    self.navigationController?.pushViewController(self.objPhotoFacialViewController!, animated: true)
                }
                else
                {
                    textField.text =  self.arrSalonServices.object(at: self.pickerView.selectedRow(inComponent: 0)) as? String

                }*/
            }
            else
            {
                textField.text =  self.arrPaymentMethod.object(at: self.pickerView.selectedRow(inComponent: 0)) as? String
                
            }
        })
        
        self.pickerView.selectRow(1, inComponent: 0, animated: true)
        
        alertView.addAction(action)
        self.present(alertView, animated: true) {
            
            self.pickerView.frame.size.width = alertView.view.frame.size.width
            
        }
        
        
    }
    func getCustomerServiceDetail()
    {
        ConfigManager.showLoadingHUD(to_view: self.view)
        
        var parameters = [String : AnyObject] ()
        
        print(ConfigManager.gEmployeeId)
        
        parameters["MethodName"] = "get_customer_analysis" as AnyObject
        parameters["user_id"] = ConfigManager.gUserId as AnyObject
        parameters["customer_id"] = self.customerId as AnyObject
        parameters["id"] = self.dateId as AnyObject
        
        self.objWebServiceController?.serverParameter(parameters: parameters)
        
    }
    func saveServiceDetail()
    {
        ConfigManager.showLoadingHUD(to_view: self.view)
        
        var parameters = [String : AnyObject] ()
        
        parameters["MethodName"] = "customer_analysis" as AnyObject
        parameters["user_id"] = ConfigManager.gUserId as AnyObject
        parameters["customer_id"] = self.customerId as AnyObject
        parameters["employee_id"] = ConfigManager.gEmployeeId as AnyObject

        parameters["service_price"] = self.arrServiceList! as AnyObject
        parameters["note_text"] = self.txtNote.text as AnyObject
        parameters["date"] = self.currentDate as AnyObject
        parameters["service_status"] = "0" as AnyObject
        parameters["note_image"] = self.arrUploadImageList as AnyObject
        
        
        print(parameters)
        
        if self.dateId != "" || self.dateId != nil{
            
            parameters["id"] = self.dateId as AnyObject
            
        }
        
        print(parameters)
        
        self.objWebServiceController?.serverPostParameter(parameters: parameters)
    }
    @IBAction func btnAddServiceAction(_ sender: UIButton) {
        
        var emptyFlag = false
        
        self.arrServiceList.removeAllObjects()
        self.serviceCount = 1;
        
        for i in 0..<self.arrServiceTextfield.count {
            
            let service = ((self.arrServiceTextfield.object(at: i)) as! NSDictionary).object(forKey: "service") as! UITextField
            let price = ((self.arrServiceTextfield.object(at: i)) as! NSDictionary).object(forKey: "price") as! UITextField
            let payment = ((self.arrServiceTextfield.object(at: i)) as! NSDictionary).object(forKey: "payment") as! UITextField
            
            print(service)
            
            if (service.text?.isEmpty)!
            {
                emptyFlag = true
            }
            else
            {
                var parameters = [String : Any] ()
                
                parameters["service"] = service.text!
                parameters["price"] = price.text!
                parameters["payment"] = payment.text!
                
                if i <= (self.arrTempServiceList.count - 1)
                {
                    let serviceId = (self.arrTempServiceList.object(at: i) as! NSDictionary).object(forKey: "service_id") as? String
                    let customerServiceId = (self.arrTempServiceList.object(at: i) as! NSDictionary).object(forKey: "customer_service_id") as? String
                    
                    if customerServiceId != nil || serviceId != nil
                    {
                        parameters["service_id"] = serviceId
                        parameters["customer_service_id"] = customerServiceId
                    }
                    
                }
                
                if !(self.arrServiceList.contains(parameters))
                {
                    self.arrServiceList.add(parameters)
                    
                }
                
            }
            
        }
        if emptyFlag == false {
            
            // self.tableHeight = (CGFloat(self.arrServiceList.count + serviceCount) * 260) + 20
            
            self.tableHeight = self.tableHeight + 235 + 20
            
            self.tblServieHeight.constant = self.tableHeight
            self.tblService.isHidden = false
            self.tblService.reloadData()
        }
        else
        {
            let alert = UIAlertController(title: "", message: "空の値", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
        // print(self.arrServiceTextfield)
        
    }
    
    @IBAction func btnSubmitAction(_ sender: UIButton) {
        

        self.arrServiceList.removeAllObjects()
        
        
        for i in 0..<self.arrServiceTextfield.count {
            
            let service = ((self.arrServiceTextfield.object(at: i)) as! NSDictionary).object(forKey: "service") as! UITextField
            let price = ((self.arrServiceTextfield.object(at: i)) as! NSDictionary).object(forKey: "price") as! UITextField
            let payment = ((self.arrServiceTextfield.object(at: i)) as! NSDictionary).object(forKey: "payment") as! UITextField
            
            print(service)
            
            if (service.text?.isEmpty)! 
            {
                print("empty")
            }
            else
            {
                var parameters = [String : Any] ()
                
                parameters["service"] = service.text
                parameters["price"] = price.text
                parameters["payment"] = payment.text
                print(i)
                print(self.arrServiceTextfield.count)
                print(self.arrTempServiceList.count)

            
                if i <= (self.arrTempServiceList.count - 1)
                {
                    let serviceId = (self.arrTempServiceList.object(at: i) as! NSDictionary).object(forKey: "service_id") as? String
                    let customerServiceId = (self.arrTempServiceList.object(at: i) as! NSDictionary).object(forKey: "customer_service_id") as? String
                    
                    if customerServiceId != nil || serviceId != nil
                    {
                        parameters["service_id"] = serviceId
                        parameters["customer_service_id"] = customerServiceId
                    }
                    
                }
                
                if !(self.arrServiceList.contains(parameters))
                {
                    self.arrServiceList.add(parameters)
                    
                }
                
            }
            
        }
        
        if ConfigManager.gEmployeeRole != "6" && ConfigManager.gEmployeeRole != "7"
        {
            if self.arrServiceList.count == 0 {
                
                let alert = UIAlertController(title: "", message: "サービスの選択", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                
                return
            }
           /* if self.txtNote.text.count == 0{
                
                let alert = UIAlertController(title: "", message: "メモを入力", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                return
            }*/
        }
        
        self.saveServiceDetail()
    }
    
    @IBAction func btnUploadImageAction(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: nil, message: "写真をアップする", preferredStyle: .actionSheet)
        
        let photoLibrary = UIAlertAction(title: "アルバムから", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            //  Do some action here.
            
            self.picker.allowsEditing = false
            self.picker.delegate = self
            self.picker.sourceType = .photoLibrary
            self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.picker.modalPresentationStyle = .popover
            self.present(self.picker, animated: true, completion: nil)
            self.picker.popoverPresentationController?.sourceView = sender
            
            
        })
        
        let cemaraAction = UIAlertAction(title: "写真を撮る", style: .destructive, handler: { (alert: UIAlertAction!) -> Void in
            //  Do some destructive action here.
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.picker.allowsEditing = false
                self.picker.delegate = self
                
                self.picker.sourceType = UIImagePickerControllerSourceType.camera
                self.picker.cameraCaptureMode = .photo
                self.picker.modalPresentationStyle = .fullScreen
                self.present(self.picker,animated: true,completion: nil)
            }
        })
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: { (alert: UIAlertAction!) -> Void in
            //  Do something here upon cancellation.
        })
        
        alertController.addAction(photoLibrary)
        alertController.addAction(cemaraAction)
        alertController.addAction(cancelAction)
        
        if let popoverController = alertController.popoverPresentationController {
            
            popoverController.sourceView = sender
            
            // popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            
        }
        self.present(alertController, animated: true, completion: nil)
        
    }
    @IBAction func btnFormDisplayPressed(_ sender: UIButton) {
        
        if ConfigManager.gCustomerPinNumber == ""
        {
            self.moveToFormDetailView(sender)
        }
        else
        {
            if ConfigManager.DeviceType.IS_IPAD
            {
                self.moveToFormDetailView(sender)
            }
            else
            {
                if ConfigManager.gEmployeeRole == "2"
                {
                    self.displayPasswordAlert(sender)
                }
                else
                {
                    self.moveToFormDetailView(sender)
                    
                }
            }
            
        }
        
        
    }
    @IBAction func btnImageDeletedPressed(_ sender: UIButton) {

        self.objDeletedImageViewController = DeletedImageViewController()
        self.objDeletedImageViewController.dateId = self.dateId
        self.navigationController?.pushViewController(self.objDeletedImageViewController, animated: true)
    }
    func displayPasswordAlert(_ sender: UIButton)
    {
        let titlePrompt = UIAlertController(title: "JTS",
                                            message: "パスワードを入力してください",
                                            preferredStyle: .alert)
        
        var titleTextField: UITextField?
        titlePrompt.addTextField { (textField) -> Void in
            titleTextField = textField
            textField.placeholder = "パスワード"
            textField.keyboardType = .numberPad
            titleTextField?.isSecureTextEntry = true
            
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .default, handler: nil)
        
        titlePrompt.addAction(cancelAction)
        
        titlePrompt.addAction(UIAlertAction(title: "送信", style: .destructive, handler: { (action) -> Void in
            if let textField = titleTextField {
                
                if textField.text! == ConfigManager.gCustomerPinNumber!
                {
                    
                    self.moveToFormDetailView(sender)
                }
                else
                {
                    let alert = UIAlertController(title: "", message: "間違ったパスワード", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "はい", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }))
        
        self.present(titlePrompt, animated: true, completion: nil)
    }
    func moveToFormDetailView(_ sender: UIButton)
    {
        self.objServiceDetailViewController = ServiceDetailViewController(nibName: "ServiceDetailViewController", bundle: nil)
        self.objServiceDetailViewController?.customerId = self.customerId as String?
        self.objServiceDetailViewController?.serviceId = sender.title(for: .application)
        self.objServiceDetailViewController?.customerServiceId = sender.title(for: .reserved)
        
        self.navigationController?.pushViewController(self.objServiceDetailViewController!, animated: true)
    }
    @objc func deleteImage(_ sender: UIButton)
    {
        self.presentedViewController?.dismiss(animated: true, completion: nil)

        let imageId = sender.title(for: .reserved)
        self.imageDeletedIndex = sender.tag

        if imageId == "" {
            
            self.arrUploadImageList.removeObject(at: self.imageDeletedIndex)
            self.setCollectionHeight()
            self.collectionViewHeight.constant = self.collectionHeight

            self.collectionView.reloadData()
        }
        else
        {
            print(sender.title(for: .reserved) as Any)
            
            ConfigManager.showLoadingHUD(to_view: self.view)
            
            var parameters = [String : AnyObject] ()
            
            parameters["MethodName"] = "delete_note_image" as AnyObject
            parameters["user_id"] = ConfigManager.gUserId as AnyObject
            parameters["id"] = imageId as AnyObject
            parameters["employee_id"] = ConfigManager.gEmployeeId as AnyObject
            
            print(parameters)
            
            self.objWebServiceController?.serverParameter(parameters: parameters)
        }
       
    }
    // MARK: UIimagepicker delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //self.imgNote.image = img
        
        //self.imgNoteHeight.constant = 235
        //self.imgNote.isHidden = false
        dismiss(animated:true, completion: nil)
        
        // print(self.arrServiceList!)
        
        var parameters = [String : AnyObject] ()
        
        parameters["MethodName"] = "customer_analysis" as AnyObject
        
        parameters["note_image"] = self.uploadedNoteImage as AnyObject
        
        if self.dateId != "" {
            
            parameters["id"] = self.dateId as AnyObject
            
        }
        
        ConfigManager.showLoadingHUD(to_view: self.view)
        
        print(parameters)
        //self.objWebServiceController?.serverPostImageParameter(parameters: parameters, image: self.imgNote.image!)
        
        self.objWebServiceController?.serverImageParameter(image: img)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated:true, completion: nil)
        
    }
    
    // MARK: Uitableview delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrServiceList.count + serviceCount;
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension;
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        cell = (tableView.dequeueReusableCell(withIdentifier: serviceIdentifier) as? AddServiceTableViewCell?)!
        
        if cell == nil {
            
            cell = self.tblService.dequeueReusableCell(withIdentifier: serviceIdentifier) as? AddServiceTableViewCell
            
        }
        
        if indexPath.row <= (self.arrServiceList.count - 1)
        {
            cell.txtServiceName.text = (self.arrServiceList.object(at: indexPath.row) as! NSDictionary).object(forKey: "service") as? String
            cell.txtPrice.text = (self.arrServiceList.object(at: indexPath.row) as! NSDictionary).object(forKey: "price") as? String
            cell.txtPaymentType.text = (self.arrServiceList.object(at: indexPath.row) as! NSDictionary).object(forKey: "payment") as? String
            
            let serviceId = (self.arrServiceList.object(at: indexPath.row) as! NSDictionary).object(forKey: "service_id") as? String
            let customerServiceId = (self.arrServiceList.object(at: indexPath.row) as! NSDictionary).object(forKey: "customer_service_id") as? String
            
            if customerServiceId != nil || serviceId != nil
            {
                cell.btnForm.setTitle(customerServiceId, for: .reserved)
                cell.btnForm.setTitle(serviceId, for: .application)
                
                cell.btnForm.isHidden = false
                cell.btnFormHeight.constant = 45
                cell.btnForm.addTarget(self, action: #selector(btnFormDisplayPressed(_:)), for: .touchUpInside)
            }
            else
            {
                cell.btnForm.isHidden = true
                cell.btnFormHeight.constant = 0
                
            }
            
            cell.txtServiceName.isUserInteractionEnabled = false
            cell.txtServiceName.isEnabled = false
            
            if ConfigManager.IS_IPHONE()
            {
                if ConfigManager.gEmployeeRole == "6" || ConfigManager.gEmployeeRole == "7"
                {
                    
                    cell.txtPrice.isEnabled = false
                    cell.txtPaymentType.isEnabled = false
                    
                    cell.btnForm.isHidden = true
                    cell.btnFormHeight.constant = 0
                    
                    
                }
            }
            
            
        }
        else
        {
            cell.txtServiceName.text = ""
            cell.txtPrice.text = ""
            cell.txtPaymentType.text = ""
            
            cell.btnForm.isHidden = true
            cell.btnFormHeight.constant = 0
            cell.txtServiceName.isUserInteractionEnabled = true
            cell.txtServiceName.isEnabled = true
            
            if ConfigManager.IS_IPHONE()
            {
                if ConfigManager.gEmployeeRole == "6" || ConfigManager.gEmployeeRole == "7"
                {
                    cell.txtServiceName.isUserInteractionEnabled = false
                    cell.txtServiceName.isEnabled = false
                    cell.txtPrice.isEnabled = false
                    cell.txtPaymentType.isEnabled = false
                    
                   // cell.btnForm.isHidden = true
                   // cell.btnFormHeight.constant = 0
                    
                }
            }
            
            
        }
        cell.txtPrice.addTarget(self, action: #selector(myTextFieldDidchange), for: .editingChanged)
        
        cell.txtServiceName.delegate = self;
        cell.txtPrice.delegate = self
        cell.txtPaymentType.delegate = self
        
        cell.txtServiceName.tag = 2
        cell.txtPaymentType.tag = 3
        cell.txtPrice.tag = 1
        
        var parameters = [String : Any] ()
        
        parameters["service"] = cell.txtServiceName!
        parameters["price"] = cell.txtPrice!
        parameters["payment"] = cell.txtPaymentType!
        
        if !(self.arrServiceTextfield.contains(parameters))
        {
            self.arrServiceTextfield.add(parameters)
            
        }
        
        return cell
        
    }
    // MARK: Collection view delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        
        return 8;
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
       /* if ConfigManager.IS_IPHONE() {
            
            return CGSize(width: (self.collectionView.frame.size.width - 20)/3, height: (self.collectionView.frame.size.width)/3)
            
        }
        else
        {
            return CGSize(width: (self.collectionView.frame.size.width)/5, height: (self.collectionView.frame.size.width)/4)
            
        }*/
        
        return CGSize(width: self.collectionView.frame.size.width , height:300)

        
        
    }
    
    //UICollectionViewDatasource methods
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.arrImageList.count + self.arrUploadImageList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCellIdentifier, for: indexPath) as! ImageCollectionViewCell
                        
        let imageFullUrl:String!
        let postedByFullUrl:String!

        if indexPath.row <= (self.arrImageList.count - 1)
        {
            let img = (self.arrImageList.object(at: indexPath.row) as! NSDictionary).object(forKey: "image") as? String
            var imgPostedBy = (self.arrImageList.object(at: indexPath.row) as! NSDictionary).object(forKey: "posted_by_image") as? String
            var postedByName:String! = (self.arrImageList.object(at: indexPath.row) as! NSDictionary).object(forKey: "posted_by_name") as? String
            var postedByDate:String! = (self.arrImageList.object(at: indexPath.row) as! NSDictionary).object(forKey: "posted_by_date") as? String
            var imageId = (self.arrImageList.object(at: indexPath.row) as! NSDictionary).object(forKey: "id") as? String


            if imageId == nil
            {
                imageId = ""
            }
            
            if postedByName == nil
            {
                postedByName = ""
            }
            if postedByDate == nil
            {
                postedByDate = ""

            }
            if imgPostedBy == nil
            {
                imgPostedBy = ""
                
            }
            cell.lblName.text = String(format: "%@", postedByName!)
            cell.lblPostedByDate.text = String(format: "Image Posted . %@", postedByDate!)
           
            imageFullUrl = ConfigManager.gImageUrl + img!
            postedByFullUrl = ConfigManager.gImageUrl + imgPostedBy!

           
        }
        else
        {
            imageFullUrl = ConfigManager.gImageUrl + (self.arrUploadImageList.object(at: indexPath.row - (self.arrImageList.count)) as? String)!
            
            postedByFullUrl = ConfigManager.gImageUrl + ConfigManager.gEmployeeImage
            
            cell.lblName.text = String(format: "%@", ConfigManager.gEmployeeName!)
            
            cell.imgUser.image = UIImage(named: ConfigManager.gImageUrl + ConfigManager.gEmployeeImage);
            
           
        }
        
        
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress(_:)))

        longPressGesture.minimumPressDuration = 1.0 // 1 second press
        longPressGesture.allowableMovement = 15 // 15 points
        longPressGesture.delegate = self
        cell.addGestureRecognizer(longPressGesture)


        URLSession.shared.dataTask(with: NSURL(string: imageFullUrl)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error as Any)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                
                if image != nil
                {
                    cell.imgNoteView.image = image
                    
                }
                
            })
            
        }).resume()
        
        URLSession.shared.dataTask(with: NSURL(string: postedByFullUrl)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error as Any)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                
                if image != nil
                {
                    cell.imgUser.image = image
                    
                }
                
            })
            
        }).resume()
        
        return cell
        
        
    }
   /* @objc func handleLongPress(_ cell: ImageCollectionViewCell)
    {
        
        if let indexPath = self.collectionView.indexPath(for: cell)
        {
            let empId = (self.arrImageList.object(at: indexPath.row) as! NSDictionary).object(forKey: "employee_id") as? String

            if ConfigManager.gEmployeeId == empId
            {
                cell.btnDelete.isHidden = false
                
            }
        }

    }*/

    @objc func handleLongPress(_ sender: UILongPressGestureRecognizer)
    {
        print("longpressed")
        
        if sender.state == UIGestureRecognizerState.began {
            
            let touchPoint = sender.location(in: self.collectionView)
            
            print(touchPoint)
            
            if let indexPath = self.collectionView.indexPathForItem(at: touchPoint) {
                
                print(indexPath.row)
                
                let cell:ImageCollectionViewCell = self.collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell
                
                var imageId:String! = ""
                
                if indexPath.row <= (self.arrImageList.count - 1)
                {
                    let empId = (self.arrImageList.object(at: indexPath.row) as! NSDictionary).object(forKey: "employee_id") as? String
                    
                    if ConfigManager.gEmployeeId == empId
                    {
                        let btn:UIButton! = UIButton.init(type: .custom)
                        btn.frame = CGRect(x: 0, y: 0, width: 100, height: 50);
                        btn.backgroundColor = UIColor.black
                        btn.setTitle("Delete", for: .normal);
                        btn.setTitleColor(UIColor.white, for: .normal);
                        btn.addTarget(self, action: #selector(deleteImage(_:)), for: .touchUpInside)
                        imageId = (self.arrImageList.object(at: indexPath.row) as! NSDictionary).object(forKey: "id") as? String
                        btn.tag = indexPath.row
                        btn.setTitle(imageId, for: .reserved)
                        
                        let popoverContent = UIViewController()
                        popoverContent.view.addSubview(btn)
                    
                        
                        popoverContent.modalPresentationStyle = .popover
                        popoverContent.view.backgroundColor = UIColor.black
                        
                        if ConfigManager.IS_IPHONE()
                        {
                            popoverContent.view.frame = CGRect(x: cell.imgNoteView.frame.origin.x, y: cell.imgNoteView.frame.origin.y, width: 100, height: 50)
                        }
                        
                        let popover: UIPopoverPresentationController? = popoverContent.popoverPresentationController
                        popover?.permittedArrowDirections = .down
                        //popover!.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
                        popover?.backgroundColor = UIColor.black
                        popoverContent.preferredContentSize = CGSize(width: 100, height: 50)
                        popover?.delegate = self
                        popoverContent.presentationController?.delegate = self

                        popover?.sourceView = cell.imgNoteView
                        popover?.sourceRect = cell.imgNoteView.bounds
                        
                        present(popoverContent, animated: true)

                    }
                   
                }
                else
                {
                    let btn:UIButton! = UIButton.init(type: .custom)
                    btn.frame = CGRect(x: 0, y: 0, width: 100, height: 50);
                    btn.backgroundColor = UIColor.black
                    btn.setTitle("Delete", for: .normal);
                    btn.setTitleColor(UIColor.white, for: .normal);
                    btn.addTarget(self, action: #selector(deleteImage(_:)), for: .touchUpInside)
                    imageId = ""
                    btn.tag = indexPath.row - (self.arrImageList.count)
                    btn.setTitle("", for: .reserved)
                    
                    let popoverContent = UIViewController()
                    popoverContent.view.addSubview(btn)
                    
                    popoverContent.modalPresentationStyle = .popover
                    
                    popoverContent.view.backgroundColor = UIColor.black
                    
                    if ConfigManager.IS_IPHONE()
                    {
                        popoverContent.view.frame = CGRect(x: cell.imgNoteView.frame.origin.x, y: cell.imgNoteView.frame.origin.y, width: 100, height: 50)
                    }
                    
                    let popover: UIPopoverPresentationController? = popoverContent.popoverPresentationController
                    popover?.permittedArrowDirections = .down
                    //popover!.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
                    popover?.backgroundColor = UIColor.black
                    popoverContent.preferredContentSize = CGSize(width: 100, height: 50)
                    popoverContent.presentationController?.delegate = self
                    popover?.sourceView = cell.imgNoteView
                    popover?.sourceRect = cell.imgNoteView.bounds
                    present(popoverContent, animated: true)

                }
                
                
                

                // your code here, get the row for the indexPath or do whatever you want
            }
            
        }
    }
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        // Return no adaptive presentation style, use default presentation behaviour
        return .none
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    // MARK: Webservice delegate
    
    func serviceImageResponse(forURl urlString: String, response: NSDictionary) {
        
        ConfigManager.hideLoadingHUD(for_view: self.view)
        
        if !(urlString == "server_error_handle") {
            
            if urlString == "upload_note_image"
            {
                if let resData = response["response_data"] {
                    
                    let dict:NSDictionary = resData as! NSDictionary
                    
                    let image:String! = String(describing:dict["image"]!)
                    
                    self.uploadedNoteImage = image!
                    
                    self.arrUploadImageList.add(self.uploadedNoteImage)
                    
                    self.setCollectionHeight()
                    
                    self.collectionView.isHidden = false
                    
                    self.collectionViewHeight.constant = self.collectionHeight
                    self.collectionView.isHidden = false
                    self.collectionView.delegate = self
                    self.collectionView.dataSource = self
                    self.collectionView.reloadData()
                    
                    
                    print(self.uploadedNoteImage!);
                    
                }
            }
        }
    }
    
    
    func serviceResponse(forURl urlString: String, response: JSON) {
        
        ConfigManager.hideLoadingHUD(for_view: self.view)
        
        if !(urlString == "server_error_handle") {
            
            if urlString == "get_customer_analysis"
            {
                if let resData = response["service_price"].arrayObject {
                    
                    self.arrServiceList = (resData as NSArray).mutableCopy() as! NSMutableArray
                    self.arrTempServiceList = (resData as NSArray).mutableCopy() as! NSMutableArray

                }
                if let resData = response["note_text"].string {
                    
                    self.txtNote.text = resData
                }
                if let resData = response["note_image"].arrayObject {
                    
                    self.arrImageList = (resData as NSArray).mutableCopy() as! NSMutableArray
                    
                    /* self.uploadedNoteImage = resData
                     
                     self.uploadedNoteImage = self.uploadedNoteImage.replacingOccurrences(of: ConfigManager.gImageUrl, with: "")
                     
                     let imageFullUrl = ConfigManager.gImageUrl + self.uploadedNoteImage
                     
                     self.arrImageList.add(imageFullUrl)
                     
                     URLSession.shared.dataTask(with: NSURL(string: imageFullUrl)! as URL, completionHandler: { (data, response, error) -> Void in
                     
                     if error != nil {
                     print(error as Any)
                     return
                     }
                     DispatchQueue.main.async(execute: { () -> Void in
                     let image = UIImage(data: data!)
                     
                     if image != nil
                     {
                     //self.imgNote.image = image
                     
                     // self.imgNoteHeight.constant = 235
                     //self.imgNote.isHidden = false
                     }
                     
                     
                     
                     })
                     
                     }).resume()*/
                }
                
                
                // if self.arrServiceList.count > 0
                // {
                self.serviceCount = 0;
                
                if self.arrServiceList.count == 0
                {
                    self.serviceCount = 1;
                    
                }
                
                
                self.arrServiceTextfield.removeAllObjects()
                
                self.setTableHeight()
                
                self.tblServieHeight.constant = self.tableHeight
                self.tblService.isHidden = false
                
                self.tblService.delegate = self
                self.tblService.dataSource = self
                self.tblService.reloadData()
                self.scrollView.isHidden = false
                
                self.setCollectionHeight()
                
                self.collectionView.isHidden = false
                
                self.collectionViewHeight.constant = self.collectionHeight
                self.collectionView.isHidden = false
                self.collectionView.delegate = self
                self.collectionView.dataSource = self
                self.collectionView.reloadData()
                
                //}
            }
            else if urlString == "customer_analysis"
            {
                let status:String! = String(describing:response["status"])
                let msg:String! = String(describing:response["msg"])
                
                if msg != nil
                {
                    let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    
                }
                if status != nil
                {
                    if status == "success"
                    {
                        self.dismiss(animated: true) {
                            self.navigationController?.popViewController(animated: true)
                            
                        }
                    }
                }
                
            }
            else if urlString == "delete_note_image"
            {
                let status:String! = String(describing:response["status"])
                let msg:String! = String(describing:response["msg"])
                
                if msg != nil
                {
                    let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    
                }
                if status != nil
                {
                    if status == "success"
                    {
                        self.arrImageList.removeObject(at: self.imageDeletedIndex)
                        self.setCollectionHeight()
                        self.collectionViewHeight.constant = self.collectionHeight

                        self.collectionView.reloadData()
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
    
    // MARK: Picker view delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if self.pickerType == "service"
        {
            return self.arrSalonServices.count
            
        }
        else
        {
            return self.arrPaymentMethod.count
            
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        if self.pickerType == "service"
        {
            return self.arrSalonServices.object(at: row) as? String
            
        }
        else
        {
            return self.arrPaymentMethod.object(at: row) as? String
            
        }
    }
    // MARK: Uitextfield delegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        
        if textField.tag == 2 || textField.tag == 3
        {
            
            self.createServicePicker(textField: textField)

            textField.resignFirstResponder()
            return false
            
        }
        else
        {
            self.selectedTextfield = textField
            return true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.keypadType = "textfield"
        self.selectedTextfield = textField
        
        
    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        self.keypadType = "textview"
        scrollView(toCenterOfScreen: textView, textfield: textView)

        return true
    }
    func scrollView(toCenterOfScreen theView: UIView, textfield: UITextView) {
        let viewCenterY: CGFloat = theView.center.y
        let applicationFrame: CGRect = UIScreen.main.bounds
        var availableHeight: CGFloat
        availableHeight = applicationFrame.size.height - 150
        
        var y: CGFloat = viewCenterY - availableHeight / 2.0
        if y < 0 {
            y = 0
        }
        
        y = y + 130
        
        if UIApplication.shared.statusBarOrientation.isPortrait == true {
            
            scrollView.setContentOffset(CGPoint(x: 0, y: y), animated: true)
            
        }
        else
        {
            scrollView.setContentOffset(CGPoint(x: 0, y: y+70), animated: true)
                
            
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    @objc func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        
        
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == Notification.Name.UIKeyboardWillHide {
            self.scrollView.contentInset = UIEdgeInsets.zero
        } else {
            self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        self.scrollView.scrollIndicatorInsets = self.scrollView.contentInset
        
        //let selectedRange = self.scrollView.selectedRange
        //self.scrollView.scrollRangeToVisible(selectedRange)
    }
    
    /* @objc func keyboardWillShow(_ notification:Notification) {
     
     if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
     // self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.height, 0)
     self.scrollView.setContentOffset(CGPoint(x: 0, y: keyboardSize.height), animated: true)
     }
     }*/
    
    @objc func keyboardWillShow( note:NSNotification )
    {
        
        if ConfigManager.IS_IPHONE()
        {
            if self.keypadType == "textfield" {

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
                
            }
        }
        
        var userInfo = note.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        print(keyboardFrame)
        if self.keypadType == "textview" {
            
            if ConfigManager.IS_IPHONE(){

                keyboardFrame.origin.y = keyboardFrame.origin.y + 80
                
            }
           
        }
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }
    @objc func keyboardWillHide(_ notification:Notification) {
        
        self.btnKeypadReturn.isHidden = true
        
        let contentInset:UIEdgeInsets = .zero
        self.scrollView.contentInset = contentInset

    }
    @objc func Done(_ sender : UIButton){
        
        
        self.selectedTextfield.resignFirstResponder()
        self.btnKeypadReturn.isHidden = true
   
        
    }
    
    @objc func myTextFieldDidchange(_ textField: UITextField) {
        
        if self.isBackSpace == false {
            
            
            let currencyFormatter = NumberFormatter()
            currencyFormatter.usesGroupingSeparator = true
            currencyFormatter.numberStyle = .currency
            currencyFormatter.currencySymbol = ""
            
            var amountStr = textField.text?.replacingOccurrences(of: ",", with: "")
            amountStr = amountStr?.replacingOccurrences(of: "円", with: "")
            
            let trimmedString = amountStr?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            var priceString:String! = currencyFormatter.string(from: NSNumber(value: Int(trimmedString!)!))
            priceString = priceString.replacingOccurrences(of: ".00", with: "")
                
            print(priceString!)
                
            textField.text = String(format: "%@円", priceString!)
           
          
        }
       
        
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        textField.text = textField.text?.replacingOccurrences(of: "円", with: "")
        textField.text = String(format: "%@円", textField.text!)
        
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let  char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        
        if (isBackSpace == -92) {
            print("Backspace was pressed")
            
            self.isBackSpace = true
        }
        else
        {
            self.isBackSpace = false
        }
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
        return true
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    func cleanDollars(_ value: String?) -> String {
        guard value != nil else { return "$0.00" }
        let doubleValue = Double(value!) ?? 0.0
        let formatter = NumberFormatter()
        formatter.currencyCode = "JPY"
        formatter.currencySymbol = "0"
        formatter.minimumFractionDigits = (value!.contains(".00")) ? 0 : 2
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .currencyAccounting
        return formatter.string(from: NSNumber(value: doubleValue)) ?? "¥\(doubleValue)"
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        // textField.text = textField.text?.replacingOccurrences(of: ".00", with: "")
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
            
           self.collectionView.reloadData()
            
            
        } else {
            print("Portrait")
            self.collectionView.reloadData()

            
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
      
        NotificationCenter.default.removeObserver(self)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension String {
    
    // formatting text for currency textField
    func currencyInputFormatting() -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "¥"
        
        var amountWithPrefix = self
        
        // remove from String: "$", ".", ","
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        //let price:Int = regex.numberOfMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count))
        
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        
        print(amountWithPrefix)
        
        
        let double = (amountWithPrefix as NSString).doubleValue
        
        print(double)
        
        
        number = NSNumber(value: (double/100))
        print(number!)
        
        guard number != 0 as NSNumber else {
            return ""
        }
        
        // print(number)
        //   let num = NSNumber(value: 100);
        
        // let numb = number * num
        
        
        return formatter.string(from: number)!
    }
}
