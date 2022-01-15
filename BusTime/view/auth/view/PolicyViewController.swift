//
//  PolicyViewController.swift
//  BusTime
//
//  Created by Aldiyar Massimkhanov on 11/9/20.
//  Copyright © 2020 thousand.com. All rights reserved.
//

import UIKit
import WebKit

class PolicyViewController : UIViewController{
    let webView = WKWebView()
    var fileName = String()
    init(fileName : String){
        super.init(nibName: nil, bundle: nil)
        self.fileName = fileName
    }
    
    var header: String = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0'></header>"
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupWebView()
    }
    func setupWebView(){
        let url = Bundle.main.url(forResource: self.fileName, withExtension: "html")
        webView.loadFileURL(url!, allowingReadAccessTo: url!)
        let request = URLRequest(url: url!)
        webView.load(request)
        
    }
    
    func setupView(){
        view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}
