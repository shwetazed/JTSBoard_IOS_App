//
//  SideMenuViewController.swift
//  JTSBoard
//
//  Created by jts on 30/08/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit
import SideMenu

class SideMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    var objSalonProfileViewController = SalonProfileViewController()
    var objEmployeeListViewController = EmployeeListViewController()

    @IBOutlet weak var tblView: UITableView!
    
    var arrMenuList:NSMutableArray! = NSMutableArray()
    let identifier = "sidemenucell"
    let logoIdentifier = "sidemenulogocell"
    var selectedIndexpath:IndexPath? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationController?.navigationBar.backgroundColor = UIColor(red: 163/255, green: 125/255, blue: 30/255, alpha: 1.0)
        //self.navigationController?.navigationBar.backgroundColor = UIColor.clear

        //self.navigationController?.navigationBar.tintColor =  UIColor.black

        self.navigationController?.navigationBar.isHidden = true

        self.tblView.register(UINib(nibName: "SideMenuTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        self.tblView.register(UINib(nibName: "SideMenuLogoTableViewCell", bundle: nil), forCellReuseIdentifier: logoIdentifier)


        //if ConfigManager.DeviceType.IS_IPAD || ConfigManager.gEmployeeRole == "1" || ConfigManager.gEmployeeRole == "2"{
            
            self.arrMenuList.add("ダッシュボード");
            self.arrMenuList.add("マイショップ");
            self.arrMenuList.add("従業員");
       // }
        
        
        guard SideMenuManager.default.menuBlurEffectStyle == nil else {
            return
        }

        NotificationCenter.default.addObserver(self, selector: #selector(self.reload(_:)), name: NSNotification.Name(rawValue: "reload_notification"), object: nil)

        // Do any additional setup after loading the view.
    }
    @objc func reload(_ notificationInfo: Notification)
    {
        self.tblView.reloadData()
    }

    // MARK: Tableview delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        /*if section == 0 {
            
            return 0;

        }
        else
        {
            let height = ConfigManager.sharedAppDelegate.window!.frame.size.height - 390
            
            return height
        }*/
        
        if section == 0 {
            
            return 0;
            
        }
        else
        {
            var height:CGFloat!
            
            if ConfigManager.DeviceType.IS_IPAD
            {
                height = ConfigManager.sharedAppDelegate.window!.frame.size.height - 390
                
            }
            else
            {
                if ConfigManager.DeviceType.IS_IPHONE_X
                {
                  //  height = ConfigManager.sharedAppDelegate.window!.frame.size.height - 200
                    height = ConfigManager.sharedAppDelegate.window!.frame.size.height - 420

                }
                else
                {
                   // height = ConfigManager.sharedAppDelegate.window!.frame.size.height - 190
                    height = ConfigManager.sharedAppDelegate.window!.frame.size.height - 399

                }
                
            }

            print(height)
            print(ConfigManager.sharedAppDelegate.window!.frame.size.height)

            return CGFloat(height)
        }
    }
   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let height:CGFloat!
        
        if ConfigManager.DeviceType.IS_IPAD
        {
            height = 390
        }
        else
        {
            if ConfigManager.DeviceType.IS_IPHONE_X
            {
                height = 420

            }
            else
            {
                height = 399

            }
        }
        let view:UIView = UIView(frame: CGRect(x: 0, y: 0, width: ConfigManager.sharedAppDelegate.window!.frame.size.width, height:ConfigManager.sharedAppDelegate.window!.frame.size.height - height ))

        view.backgroundColor = UIColor.clear
        
        let imgView = UIImageView(frame: CGRect(x: 0, y: view.frame.size.height - 1, width: ConfigManager.sharedAppDelegate.window!.frame.size.width, height: 1))
        imgView.backgroundColor = UIColor.white
        view.addSubview(imgView)
        
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return self.arrMenuList.count + 1

        }
        else
        {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension;

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 && indexPath.section == 0
        {
            var cell: SideMenuLogoTableViewCell! = (tableView.dequeueReusableCell(withIdentifier: logoIdentifier) as? SideMenuLogoTableViewCell?)!

            if cell == nil {
                
                cell = tableView.dequeueReusableCell(withIdentifier: logoIdentifier) as? SideMenuLogoTableViewCell
            }
            
            return cell
        }
        else
        {
            var cell: SideMenuTableViewCell! = (tableView.dequeueReusableCell(withIdentifier: identifier) as? SideMenuTableViewCell?)!
            
            if cell == nil {
                
                cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? SideMenuTableViewCell
            }
            
            cell.selectionStyle = .none
            
            if indexPath.section == 0
            {
                let title:String! = self.arrMenuList.object(at: indexPath.row - 1) as! String
                
                cell.lblTitle.text = title
                
                cell.backgroundColor = UIColor.clear
                cell.lblTitle.textColor = UIColor(red: 170/255, green: 171/255, blue: 175/255, alpha: 1.0)

                
                if indexPath.row == 1
                {
                    cell.imgView.image = UIImage(named: "dashboard_unselected")

                }
                else if indexPath.row == 2
                {
                    cell.imgView.image = UIImage(named: "profile_unselected")
                    
                }
                else if indexPath.row == 3
                {
                    cell.imgView.image = UIImage(named: "jts_staff_unselected")
                    
                }
                
                cell.imgSelection.isHidden = true
                
                if self.selectedIndexpath != nil
                {
                    if self.selectedIndexpath == indexPath
                    {
                        cell?.lblTitle.textColor = UIColor(red: 166/255, green: 117/255, blue: 0/255, alpha: 1.0)
                        cell.imgSelection.isHidden = false

                        if indexPath.row == 1
                        {
                            cell.imgView.image = UIImage(named: "dashboard_selected")
                            
                        }
                        else if indexPath.row == 2
                        {
                            cell.imgView.image = UIImage(named: "profile_selected")
                            
                        }
                        else if indexPath.row == 3
                        {
                            cell.imgView.image = UIImage(named: "jts_staff_selected")
                            
                        }
                    }
                }
            }
            else
            {
                cell.lblTitle.text = "ログアウト"
                cell.lblTitle.textColor = UIColor.white
                cell.imgView.image = UIImage(named: "signout")
                cell.backgroundColor = UIColor(red: 166/255, green: 117/255, blue: 0/255, alpha: 1.0)
                
            }
            
            
            return cell
        }
       
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedIndexpath = indexPath
        
        if indexPath.section == 0 {
            
            
            self.tblView.reloadData()
            
           // let cell:SideMenuTableViewCell! = tableView.cellForRow(at: indexPath) as! SideMenuTableViewCell?
            
            //cell?.lblTitle.textColor = UIColor(red: 166/255, green: 117/255, blue: 0/255, alpha: 1.0)
            

            if indexPath.row == 1
            {

                dismiss(animated: true, completion: nil)
                return
                
            }
            else if indexPath.row == 2
            {

                self.moveToProfile()
                return
            }
                
            else if indexPath.row == 3
            {

                self.moveToEmployee()
                return
            }
           
        }
        else
        {
            dismiss(animated: true, completion: nil)
            
            let center = NotificationCenter.default
            
            center.post(name: Notification.Name("logout_notification"), object: nil, userInfo: nil)
            return
        }
       
    }
    
    func moveToProfile()
    {
        if ConfigManager.gEmployeePinNumber == ""
        {
            ConfigManager.kCheckRootViewController = "myshop"
            ConfigManager.sharedAppDelegate.setLandingPage()
            
        }
        else
        {
            if ConfigManager.DeviceType.IS_IPAD || ConfigManager.gEmployeeRole == "2"
            {
                let titlePrompt = UIAlertController(title: "JTS",
                                                    message: "パスワードを入力してください",
                                                    preferredStyle: .alert)
                
                var titleTextField: UITextField?
                titlePrompt.addTextField { (textField) -> Void in
                    titleTextField = textField
                    titleTextField?.isSecureTextEntry = true
                    textField.placeholder = "パスワード"
                    textField.keyboardType = .numberPad
                    
                }
                
                let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .default, handler: nil)
                
                titlePrompt.addAction(cancelAction)
                
                titlePrompt.addAction(UIAlertAction(title: "送信", style: .destructive, handler: { (action) -> Void in
                    if let textField = titleTextField {
                        
                        if textField.text! == ConfigManager.gEmployeePinNumber!
                        {
                            
                            self.objSalonProfileViewController = SalonProfileViewController()
                            self.navigationController?.pushViewController(self.objSalonProfileViewController, animated: true)
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
            else if ConfigManager.IS_IPHONE() && ConfigManager.gEmployeeRole == "1"
            {
                self.objSalonProfileViewController = SalonProfileViewController()
                self.navigationController?.pushViewController(self.objSalonProfileViewController, animated: true)
            }
            else
            {
                let alert = UIAlertController(title: "", message: "あなたはアクセスできない", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)

            }
            
            
        }
        
    }
    func moveToEmployee()
    {
        if ConfigManager.gEmployeePinNumber == ""
        {
            self.objEmployeeListViewController = EmployeeListViewController(nibName: "EmployeeListViewController", bundle: nil)
            self.navigationController?.pushViewController(self.objEmployeeListViewController, animated: true)
        }
        else
        {
            if ConfigManager.DeviceType.IS_IPAD || ConfigManager.gEmployeeRole == "2"
            {
                let titlePrompt = UIAlertController(title: "JTS",
                                                    message: "パスワードを入力してください",
                                                    preferredStyle: .alert)
                
                var titleTextField: UITextField?
                titlePrompt.addTextField { (textField) -> Void in
                    titleTextField = textField
                    titleTextField?.isSecureTextEntry = true
                    textField.placeholder = "パスワード"
                    textField.keyboardType = .numberPad
                    
                }
                
                let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .default, handler: nil)
                
                titlePrompt.addAction(cancelAction)
                
                titlePrompt.addAction(UIAlertAction(title: "送信", style: .destructive, handler: { (action) -> Void in
                    if let textField = titleTextField {
                        
                        if textField.text! == ConfigManager.gEmployeePinNumber!
                        {
                            self.objEmployeeListViewController = EmployeeListViewController(nibName: "EmployeeListViewController", bundle: nil)
                            self.navigationController?.pushViewController(self.objEmployeeListViewController, animated: true)
                        }
                        else
                        {
                            let alert = UIAlertController(title: "", message: "間違ったパスワード", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true)
                        }
                    }
                }))
                
                self.present(titlePrompt, animated: true, completion: nil)
                
            }
            else if ConfigManager.IS_IPHONE() && ConfigManager.gEmployeeRole == "1"
            {
                self.objEmployeeListViewController = EmployeeListViewController(nibName: "EmployeeListViewController", bundle: nil)
                self.navigationController?.pushViewController(self.objEmployeeListViewController, animated: true)
            }
            else
            {
                let alert = UIAlertController(title: "", message: "あなたはアクセスできない", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)

            }
        }
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
