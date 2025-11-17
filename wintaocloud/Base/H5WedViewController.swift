//
//  H5WedViewController.swift
//  wintaocloud
//
//  Created by hekang on 2025/11/17.
//

import UIKit
import WebKit
import SnapKit

class H5WedViewController: BaseViewController {
    
    var pageUrl: String = ""
    
    lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration()
        let scriptStr = "window.ALDClient = {};ALDClient.callNative = function(method, arg) { return prompt(method, arg)};"
        let cookieScript = WKUserScript(
            source: scriptStr,
            injectionTime: .atDocumentStart,
            forMainFrameOnly: false
        )
        config.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")
        config.setValue(true, forKey: "allowUniversalAccessFromFileURLs")
        config.userContentController.addUserScript(cookieScript)
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.scrollView.bounces = false
        webView.scrollView.alwaysBounceVertical = false
        webView.scrollView.showsVerticalScrollIndicator = false
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        let scriptNames = ["h5ToSwift"]
        let configuration = WKWebViewConfiguration()
        scriptNames.forEach {
            configuration.userContentController.add(self, name: $0)
        }
        return webView
    }()
    
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.tintColor = UIColor.init(hexString: "#5AD7F6")
        progressView.trackTintColor = UIColor.init(hexString: "#F7F7F6")
        return progressView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let webUrl = pageUrl.replacingOccurrences(of: " ", with: "%20")
        if let url = URL(string: webUrl) {
            webView.load(URLRequest(url: url))
        }
        print("pageurl=====\(webUrl)")
    }

}

extension H5WedViewController: WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
    
    
    
}
