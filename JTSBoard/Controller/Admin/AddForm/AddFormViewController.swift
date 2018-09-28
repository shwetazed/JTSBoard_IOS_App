//
//  AddFormViewController.swift
//  JTSBoard
//
//  Created by jts on 30/08/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit

class AddFormViewController: UIViewController {

    @IBOutlet weak var btnEsthe: UIButton!
    @IBOutlet weak var btnEyelush: UIButton!
    @IBOutlet weak var btnBodyService: UIButton!
    @IBOutlet weak var btnHairRemoval: UIButton!
    @IBOutlet weak var btnPhotoFacial: UIButton!
    
    var objEstheServiceViewController:EstheServiceViewController!
    var objEyeLastServiceViewController:EyeLastServiceViewController!
    var objBodyServiceViewController:BodyServiceViewController!
    var objHairRemovalServiceViewController:HairRemovalServiceViewController!
    var objPhotoFacialViewController:PhotoFacialViewController!

    var currentDate:String!
    var customerId:String!
    var dateId:String!

    @IBAction func btnEstheAction(_ sender: Any) {
        
        self.objEstheServiceViewController = EstheServiceViewController(nibName: "EstheServiceViewController", bundle: nil)
        self.objEstheServiceViewController.customerId = customerId!
        self.objEstheServiceViewController?.currentDate = self.currentDate
        self.objEstheServiceViewController?.dateId = self.dateId

        self.navigationController?.pushViewController(self.objEstheServiceViewController!, animated: true)
    }
    @IBAction func btnEyelushAction(_ sender: Any) {
        
        self.objEyeLastServiceViewController = EyeLastServiceViewController(nibName: "EyeLastServiceViewController", bundle: nil)
        self.objEyeLastServiceViewController.customerId = customerId!
        self.objEyeLastServiceViewController?.currentDate = self.currentDate
        self.objEyeLastServiceViewController?.dateId = self.dateId

        self.navigationController?.pushViewController(self.objEyeLastServiceViewController!, animated: true)
    }
    @IBAction func btnBodyServiceAction(_ sender: Any) {
        
        self.objBodyServiceViewController = BodyServiceViewController(nibName: "BodyServiceViewController", bundle: nil)
        self.objBodyServiceViewController.customerId = customerId!
        self.objBodyServiceViewController?.currentDate = self.currentDate
        self.objBodyServiceViewController?.dateId = self.dateId

        self.navigationController?.pushViewController(self.objBodyServiceViewController!, animated: true)
    }
    @IBAction func btnHairRemovalAction(_ sender: Any) {
        
        self.objHairRemovalServiceViewController = HairRemovalServiceViewController(nibName: "HairRemovalServiceViewController", bundle: nil)
        self.objHairRemovalServiceViewController.customerId = customerId!
        self.objHairRemovalServiceViewController?.currentDate = self.currentDate
        self.objHairRemovalServiceViewController?.dateId = self.dateId

        self.navigationController?.pushViewController(self.objHairRemovalServiceViewController!, animated: true)
    }
    @IBAction func btnPhotoFacialAction(_ sender: Any) {
        
        self.objPhotoFacialViewController = PhotoFacialViewController(nibName: "PhotoFacialViewController", bundle: nil)
        self.objPhotoFacialViewController.customerId = customerId!
        self.objPhotoFacialViewController?.currentDate = self.currentDate
        self.objPhotoFacialViewController?.dateId = self.dateId

        self.navigationController?.pushViewController(self.objPhotoFacialViewController!, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setBorderOnButton()
        // Do any additional setup after loading the view.
    }
    func setBorderOnButton()
    {
        self.btnEsthe.layer.cornerRadius = 10.0
        self.btnEsthe.clipsToBounds = true
        self.btnEsthe.layer.borderColor = (UIColor(red: 184/255, green: 134/255, blue: 30/255, alpha: 1.0)).cgColor
        self.btnEsthe.layer.borderWidth = 1.0
        
        self.btnEyelush.layer.cornerRadius = 10.0
        self.btnEyelush.clipsToBounds = true
        self.btnEyelush.layer.borderColor = (UIColor(red: 184/255, green: 134/255, blue: 30/255, alpha: 1.0)).cgColor
        self.btnEyelush.layer.borderWidth = 1.0
        
        self.btnBodyService.layer.cornerRadius = 10.0
        self.btnBodyService.clipsToBounds = true
        self.btnBodyService.layer.borderColor = (UIColor(red: 184/255, green: 134/255, blue: 30/255, alpha: 1.0)).cgColor
        self.btnBodyService.layer.borderWidth = 1.0
        
        self.btnHairRemoval.layer.cornerRadius = 10.0
        self.btnHairRemoval.clipsToBounds = true
        self.btnHairRemoval.layer.borderColor = (UIColor(red: 184/255, green: 134/255, blue: 30/255, alpha: 1.0)).cgColor
        self.btnHairRemoval.layer.borderWidth = 1.0
        
        self.btnPhotoFacial.layer.cornerRadius = 10.0
        self.btnPhotoFacial.clipsToBounds = true
        self.btnPhotoFacial.layer.borderColor = (UIColor(red: 184/255, green: 134/255, blue: 30/255, alpha: 1.0)).cgColor
        self.btnPhotoFacial.layer.borderWidth = 1.0
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
