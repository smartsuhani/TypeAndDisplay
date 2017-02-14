//
//  WebViewController.swift
//  TypeAndDisplay
//
//  Created by Devloper30 on 14/02/17.
//  Copyright © 2017 lanetteamLanet. All rights reserved.
//

import UIKit

class WebViewController: UIViewController,UIWebViewDelegate,UITextFieldDelegate {

    @IBOutlet var indicator: UIActivityIndicatorView!
    @IBOutlet var TxtURL: UITextField!
    @IBOutlet var WebView: UIWebView!
    var url: URL!
    var req: URLRequest!
    override func viewDidLoad() {
        super.viewDidLoad()
        url = URL(string: "https://www.google.com")
        req = URLRequest(url: url!)
        WebView.loadRequest(req)
        WebView.delegate = self
        TxtURL.delegate = self
        indicator.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        goToWebUrl()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        TxtURL.resignFirstResponder()
        return true
    }
    @IBAction func goToWebUrl() {
        var str = TxtURL.text!
    
        if (chek(str: str) && str.contains(".") && !str.contains(" ")){
            if(str.contains("www.")){
               str = "http://"+str
            }else{
                
                 str = "http://www."+str
            }
        }else{
            if(str.contains(" ")){
                let s = str.replacingOccurrences(of: " ", with: "+")
                str = "https://www.google.com/search?q="+s
            }else{
                str = "https://www.google.com/search?q="+str
            }
            
        }
        print(str)
        let url = URL(string: str)
        let req = URLRequest(url: url!)
        WebView.loadRequest(req)
    }
    
    func chek(str: String)-> Bool{
        let reg = "^[a-zA-Z0-9][a-zA-Z0-9-]{1,61}[a-zA-Z0-9].[a-zA-Z]{2,6}$"
        return NSPredicate(format: "SELF MATCHES %@", reg).evaluate(with: str)
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
        indicator.isHidden = false
        indicator.startAnimating()
        TxtURL.text = String(describing: (WebView.request?.url!)!)
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        TxtURL.text = String(describing: (WebView.request?.url!)!)
        indicator.stopAnimating()
        indicator.isHidden = true
    }
    @IBAction func goHome(_ sender: Any) {
        url = URL(string: "https://www.google.com")
        req = URLRequest(url: url!)
        WebView.loadRequest(req)
    }
    func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url  = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
}
