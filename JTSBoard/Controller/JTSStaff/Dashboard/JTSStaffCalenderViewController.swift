//
//  JTSStaffCalenderViewController.swift
//  JTSBoard
//
//  Created by jts on 24/09/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit
import SwiftyJSON

class JTSStaffCalenderViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate,WebServiceControllerDelegate {
    
    var objWebServiceController: WebServiceController?

    @IBOutlet
    weak var calendar: FSCalendar!
    
    @IBOutlet
    weak var calendarHeightConstraint: NSLayoutConstraint!
    
    var arrEventList:NSMutableArray! = NSMutableArray()
    
    fileprivate var lunar: Bool = false {
        didSet {
            self.calendar.reloadData()
        }
    }
  
    
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    fileprivate let gregorian: NSCalendar! = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)
    
    fileprivate let datesWithCat = ["2015/05/05","2015/06/05","2015/07/05","2015/08/05","2015/09/05","2015/10/05","2015/11/05","2015/12/05","2016/01/06",
                                    "2016/02/06","2016/03/06","2016/04/06","2016/05/06","2016/06/06","2016/07/06"]
    
    
    // MARK:- Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.objWebServiceController = WebServiceController()
        self.objWebServiceController?.delegate = self
                
        self.arrEventList.add("My Holiday")
        self.arrEventList.add("My Holiday")
        self.arrEventList.add("My Holiday")
        self.arrEventList.add("My Holiday")
        
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.groupTableViewBackground
        self.view = view
        
        //let height: CGFloat = UIDevice.current.model.hasPrefix("iPad") ? 400 : 300
        let height: CGFloat = self.view.frame.size.height - self.navigationController!.navigationBar.frame.maxY
        
        let calendar = FSCalendar(frame: CGRect(x: 0, y: self.navigationController!.navigationBar.frame.maxY, width: self.view.bounds.width, height: height))
        calendar.dataSource = self
        calendar.delegate = self
        calendar.backgroundColor = UIColor.white
        self.view.addSubview(calendar)
        self.calendar = calendar
        
        self.calendar.headerHeight = 0 // shweta
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        let dateStr:String! = formatter.string(from: calendar.currentPage)
        
        print(dateStr!)
        
        self.navigationItem.title = dateStr!
        
        self.getCalenderData()
        
        
    }
    
    func getCalenderData()
    {
        
        ConfigManager.showLoadingHUD(to_view: self.view)
        
        var parameters = [String : AnyObject] ()
        
        parameters["MethodName"] = "reservation_calendar_iphone" as AnyObject
        parameters["user_id"] = ConfigManager.gUserId as AnyObject
        
        self.objWebServiceController?.serverParameter(parameters: parameters)
        
    }
    
    // MARK:- FSCalendarDataSource
    
    /* func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
     return self.gregorian.isDateInToday(date) ? "今天" : nil
     
     }*/ // shweta
    
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        /* guard self.lunar else {
         return nil
         }
         return self.lunarFormatter.string(from: date)*/
        
        let day: Int! = self.gregorian.component(.day, from: date)
        
        print(day);
        
        return ("Shweta");
        
        // return (day % 5 == 0 ? "Shweta" : nil);
        
    }
    func calendar(_ calendar: FSCalendar, subtitleListFor date: Date) -> NSMutableArray? {
        
        let day: Int! = self.gregorian.component(.day, from: date)
        
        print(day);
        return (self.arrEventList);
        
        //  return (day % 5 == 0 ? self.arrEventList : nil);
        //return self.arrEventList
    }
    
    
    /* func maximumDate(for calendar: FSCalendar) -> Date {
     return self.formatter.date(from: "2017/10/30")!
     }*/ // shweta
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        print(date);
        
        let day: Int! = self.gregorian.component(.day, from: date)
        
        print(day);
        
        return day % 5 == 0 ? day/5 : 0;
        
        // return 10;
        
    }
    
    /* func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
     let day: Int! = self.gregorian.component(.day, from: date)
     return [13,24].contains(day) ? UIImage(named: "icon_cat") : nil
     
     }*/ //shweta
    
    // MARK:- FSCalendarDelegate
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        let dateStr:String! = formatter.string(from: calendar.currentPage)
        
        print(dateStr!)
        
        self.navigationItem.title = dateStr! // shweta
        
        print("change page to \(self.formatter.string(from: calendar.currentPage))")
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("calendar did select date \(self.formatter.string(from: date))")
        if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    // MARK:  Webservice Bar delegate
    
    func serviceResponse(forURl urlString: String, response: JSON) {
        
        ConfigManager.hideLoadingHUD(for_view: self.view)
        
        if !(urlString == "server_error_handle") {
            
            if urlString == "reservation_calendar_iphone"
            {
                if let resData = response["Employee"].dictionaryObject {
                    
                    let status:String! = String(describing:resData["status"]!)
                    let msg:String! = String(describing:resData["msg"]!)
                    
                    if status == "success"
                    {
                      
                    }
                    else
                    {
                        let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true)
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
    func serviceImageResponse(forURl urlString: String, response: NSDictionary) {
        
    }
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
       // self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    
    // MARK:- Navigation
    
    
    
    
}
