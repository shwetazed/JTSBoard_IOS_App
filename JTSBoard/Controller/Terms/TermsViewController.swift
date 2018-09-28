//
//  TermsViewController.swift
//  JTSBoard
//
//  Created by jts on 05/07/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit
import WebKit

class TermsViewController: UIViewController,WKNavigationDelegate {

    @IBOutlet weak var webVIew: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webVIew.scrollView.bounces = false
        
        let backbutton = UIButton(type: .custom)
        backbutton.setImage(UIImage(named: "back_icon"), for: .normal) // Image can be downloaded from here below link
        backbutton.setTitle("利用規約", for: .normal)
        backbutton.addTarget(self, action: #selector(TermsViewController.btnBackAction), for: .touchUpInside)
        backbutton.setTitleColor(UIColor.black, for: .normal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)

        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 163/255, green: 125/255, blue: 30/255, alpha: 1.0)

        self.webVIew.navigationDelegate = self
        
       // let url = URL(string: "https://docs.google.com/document/d/18wMwTDzQkN0dnxXUaFcAuE3uBTUiYKHyZklFy2YZsP8/edit")!
        
        if let pdf = Bundle.main.url(forResource: "Terms", withExtension: "pdf", subdirectory: nil, localization: nil)  {
            self.webVIew.load(URLRequest(url: pdf))
            self.webVIew.allowsBackForwardNavigationGestures = true
        }
        
        
        // Do any additional setup after loading the view.
    }
    @objc func btnBackAction()
    {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK:- WKNavigationDelegate
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
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
