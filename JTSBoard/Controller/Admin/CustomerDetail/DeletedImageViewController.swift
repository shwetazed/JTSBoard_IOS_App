//
//  DeletedImageViewController.swift
//  JTSBoard
//
//  Created by jts on 12/09/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher

class DeletedImageViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,WebServiceControllerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var objWebServiceController: WebServiceController?

    var arrImageList:NSMutableArray! = NSMutableArray()
    let imageCellIdentifier = "imagecellI";
    
    var dateId:String!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.objWebServiceController = WebServiceController()
        self.objWebServiceController?.delegate = self
        
        self.collectionView.register(UINib.init(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier:imageCellIdentifier)

        self.getDeletedImagesList()
        // Do any additional setup after loading the view.
    }
    
    func getDeletedImagesList()
    {
        ConfigManager.showLoadingHUD(to_view: self.view)
        
        var parameters = [String : AnyObject] ()
        
        parameters["MethodName"] = "get_deleted_images" as AnyObject
        parameters["user_id"] = ConfigManager.gUserId as AnyObject
        parameters["id"] = self.dateId as AnyObject
        
        self.objWebServiceController?.serverParameter(parameters: parameters)
        
    }
    // MARK: Collection view delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        
        return 8;
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.collectionView.frame.size.width , height:100)
        
        
        
    }
    
    //UICollectionViewDatasource methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.arrImageList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCellIdentifier, for: indexPath) as! ImageCollectionViewCell
        
       // let imageFullUrl:String!
        let postedByFullUrl:String!
        
      
            let img = (self.arrImageList.object(at: indexPath.row) as! NSDictionary).object(forKey: "image") as? String
            var imgPostedBy = (self.arrImageList.object(at: indexPath.row) as! NSDictionary).object(forKey: "deleted_by_image") as? String
            var postedByName:String! = (self.arrImageList.object(at: indexPath.row) as! NSDictionary).object(forKey: "deleted_by_name") as? String
            var postedByDate:String! = (self.arrImageList.object(at: indexPath.row) as! NSDictionary).object(forKey: "deleted_by_date") as? String
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
            cell.lblPostedByDate.text = String(format: "Image Deleted . %@", postedByDate!)
            
        
            
         //   imageFullUrl = ConfigManager.gImageUrl + img!
            postedByFullUrl = ConfigManager.gImageUrl + imgPostedBy!
        
        cell.imageNoteHeight.constant = 0
        cell.imgNoteView.isHidden = true
        
       /* URLSession.shared.dataTask(with: NSURL(string: imageFullUrl)! as URL, completionHandler: { (data, response, error) -> Void in
            
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
            
        }).resume()*/
        
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
   
    
    // MARK: Webservice delegate
    
    func serviceImageResponse(forURl urlString: String, response: NSDictionary) {
        
        ConfigManager.hideLoadingHUD(for_view: self.view)
        
    }
    
    
    func serviceResponse(forURl urlString: String, response: JSON) {
        
        ConfigManager.hideLoadingHUD(for_view: self.view)
        
        if !(urlString == "server_error_handle") {
            
            if urlString == "get_deleted_images" {
            
                if let resData = response["note_image"].arrayObject {
                    
                    self.arrImageList = (resData as NSArray).mutableCopy() as! NSMutableArray
                  
                }
            
                self.collectionView.reloadData()
            
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
