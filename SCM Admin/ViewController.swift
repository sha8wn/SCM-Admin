//
//  ViewController.swift
//  SCM Admin
//
//  Created by Shawn Frank on 16/12/2019.
//  Copyright © 2019 Shawn Frank. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate {

    
    @IBOutlet weak var webView: WKWebView!
    var setUp = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(!setUp) {
            
            setUp = true
            self.webView.uiDelegate = self
            self.webView.load(URLRequest(url: URL(string: "https://scmajlis.ae/admin.php")!))
            
            let source: String = "var meta = document.createElement('meta');" +
            "meta.name = 'viewport';" +
            "meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';" +
            "var head = document.getElementsByTagName('head')[0];" + "head.appendChild(meta);";
            
            let script: WKUserScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
            self.webView.configuration.userContentController.addUserScript(script)
        }
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        /*var wv: WKWebView?

        if navigationAction.targetFrame == nil {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController")  as? ViewController {
                vc.url = navigationAction.request.URL
                vc.webConfig = configuration
                wv = vc.view as? WKWebView

                self.navigationController?.pushViewController(vc, animated: true)
            }
        }

        return wv*/
        
        if let frame = navigationAction.targetFrame,
            frame.isMainFrame {
            return nil
        }
        // for _blank target or non-mainFrame target
        self.webView.load(navigationAction.request)
        return nil
    }
}

