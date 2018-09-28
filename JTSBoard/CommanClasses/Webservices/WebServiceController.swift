//
//  WebServiceController.swift
//  SalonatApp
//
//  Created by Apple on 06/04/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol WebServiceControllerDelegate {
    
    func serviceResponse(forURl urlString: String, response:JSON)
    
    func serviceImageResponse(forURl urlString: String, response:NSDictionary)

}
class WebServiceController: NSObject {
   
    var delegate: WebServiceControllerDelegate?

     func serverParameter(parameters: [String: AnyObject]) {

        let headers = ["Content-Type":"Application/json"]
        
        var urlStr = String(format: "%@%@",ConfigManager.gUrl,parameters["MethodName"]! as! CVarArg)
        
        urlStr = urlStr.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        
        Alamofire.request(urlStr, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { response in

            print(urlStr)
            print(parameters)
            
            print(String(format: "%@",response.request! as CVarArg))
            
            print("RESPONSE \(response.result)")
            print("RESPONSE \(response)")
            
            if let json = response.result.value {
                
                let swiftyJsonVar = JSON(json)

                self.delegate?.serviceResponse(forURl: parameters["MethodName"]! as! String, response: swiftyJsonVar)
                
            }
            else
            {
                self.delegate?.serviceResponse(forURl: "server_error_handle", response:JSON.null)
                
            }
        }
    }
    
    func serverPostParameter(parameters: [String: AnyObject]) {
        
        let headers = ["Content-Type":"Application/json"]
       // let headers = [:]

        var urlStr = String(format: "%@%@",ConfigManager.gUrl,parameters["MethodName"]! as! CVarArg)
        
        urlStr = urlStr.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        
        
        let data = try! JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        if let json = json {
          //  print(json)
        }
      
        Alamofire.request(urlStr, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            
            //print(urlStr)
            print(parameters)
            print(NSString(data: (response.request?.httpBody)!, encoding: String.Encoding.utf8.rawValue)! as Any)

            print(String(format: "%@",response.request! as CVarArg))
            
            print("RESPONSE \(response.result)")
            print("RESPONSE \(response)")
            
            if let json = response.result.value {
                
                let swiftyJsonVar = JSON(json)
                
                self.delegate?.serviceResponse(forURl: parameters["MethodName"]! as! String, response: swiftyJsonVar)
                
            }
            else
            {
                self.delegate?.serviceResponse(forURl: "server_error_handle", response:JSON.null)
                
            }
        }
    }
    func serverImageParameter(image:UIImage) {
        
        let headers = ["Content-Type":"Application/json"]
        // let headers = [:]
        
        var urlStr = String(format: "%@%@",ConfigManager.gUrl,"upload_note_image")
        
        urlStr = urlStr.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        
        let imgData = UIImageJPEGRepresentation(image , 0.2)!
        
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "note_image",fileName: "file.jpg", mimeType: "image/jpg")
    
        }, to:urlStr)
        { (result) in
            switch result {
                
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.responseJSON
                    { response in
                        //print response.result
                        
                        print(response)
                        
                        print(response.result)
                        
                        print(response.result.value)
                        
                        if response.result.value != nil
                        {
                            let dict :NSDictionary = response.result.value! as! NSDictionary

                            
                            self.delegate?.serviceImageResponse(forURl: "upload_note_image" , response: dict)

                          
                        }
                        else
                        {
                            self.delegate?.serviceImageResponse(forURl: "server_error_handle", response:NSDictionary())

                        }
                }
                
            case .failure(let encodingError):
                print(encodingError)
            }
        }
        
        
    }
    func serverPostImageParameter(parameters: [String: AnyObject], image:UIImage) {
        
        let headers = ["Content-Type":"Application/json"]
        // let headers = [:]
        
        var urlStr = String(format: "%@%@",ConfigManager.gUrl,parameters["MethodName"]! as! CVarArg)
        
        urlStr = urlStr.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        
        let imgData = UIImageJPEGRepresentation(image , 0.2)!
        
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "note_image",fileName: "file.jpg", mimeType: "image/jpg")
            for (key, value) in parameters {

                multipartFormData.append(value.data(using: String.Encoding.utf8.rawValue)!, withName: key)

            } //Optional for extra parameters
        }, to:urlStr)
        { (result) in
            switch result {
                
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    //print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.responseJSON
                    { response in
                        //print response.result
                        
                        print(response)

                        print(response.result)

                        print(response.result.value)
                        
                        if response.result.value != nil
                        {
                            let dict :NSDictionary = response.result.value! as! NSDictionary
                           /* let status = dict.value(forKey: "status")as! String
                            if status=="1"
                            {
                                print("DATA UPLOAD SUCCESSFULLY")
                            }*/
                        }
                }
                
            case .failure(let encodingError):
                print(encodingError)
            }
        }
      
       
    }
    func jsonToDictionary(from text: String) -> [String: Any]? {
        guard let data = text.data(using: .utf8) else { return nil }
        let anyResult = try? JSONSerialization.jsonObject(with: data, options: [])
        return anyResult as? [String: Any]
    }
}
