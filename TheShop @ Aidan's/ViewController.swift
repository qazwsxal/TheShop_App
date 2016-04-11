//
//  ViewController.swift
//  TheShop @ Aidan's
//
//  Created by Jaisal Patel on 01/03/2016.
//  Copyright © 2016 Jaisal Patel. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = NSURL(string: "https://shopataidans.wordpress.com")!
        if Reachability.isConnectedToNetwork() == true{
            webView.loadRequest(NSURLRequest(URL: url))
            webView.allowsBackForwardNavigationGestures = true
        }
    }
    
    //test for github
    
    override func viewDidAppear(animated: Bool) {
        if Reachability.isConnectedToNetwork() == false{
            
            let alertController = UIAlertController(title: "No Internet Connection", message:
                "You are not connected to the internet. Please connect via WiFi. Mobile Data will not work for some cray reason, I'm trying to get it to work, but I have a degree to do to.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK I promise to turn on my WiFi like a good child.", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .LinkActivated  {
            if let newURL = navigationAction.request.URL,
                host = newURL.host where !host.containsString("shopataidans") &&
                    UIApplication.sharedApplication().canOpenURL(newURL) &&
                    UIApplication.sharedApplication().openURL(newURL) {
                    decisionHandler(.Cancel)
            }
            else {
                decisionHandler(.Allow)
            }
        }
        else {
            decisionHandler(.Allow)
        }
    }
    
    
}


