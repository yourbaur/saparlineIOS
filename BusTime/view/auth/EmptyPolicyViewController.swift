//
//  EmptyPolicyViewController.swift
//  SaparLine
//
//  Created by Aldiyar Massimkhanov on 11/11/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit
import WebKit

class EmptyPolicyViewController : UIViewController, WKNavigationDelegate{

    var webView: WKWebView!
    var policy: PolicyModel?
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPageHTML()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func loadPage(body: String) {
        webView.loadHTMLString("<!DOCTYPE html><html><head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0 maximum-scale=1.0 user-scalable=no\" charset=\"utf-8\" /></head><body>" + body + "</body></html>", baseURL: nil)
    }
    
    private func getPageHTML() {
        showHUD()
        ParseManager.shared.getRequest(url: api.policy, parameters: nil) { (result: PolicyModel?, error) in
            self.dismissHUD()
            if let error = error {
                self.showErrorMessage(messageType: .error, error)
                return
            }
            self.policy = result!
            self.loadPage(body: self.policy?.privacy_policy ?? "")
        }
    }
}
