//
//  WebViewController.swift
//  ClientPortal
//
//  Created by Mudassar Sultan on 07/12/2023.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblURL: UILabel!
    @IBOutlet weak var webView: WKWebView!
    
    //MARK: - Variables
    var url:String!
    var urlHost:URL!
    
    //MARK: - Actions
    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func actionShare(_ sender: Any) {
        let message = "Share"
        if let link = urlHost{
            let objectsToShare = [message,link] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        if let url = URL(string: url) {
            urlHost = url
            lblURL.text = url.host
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}

//MARK: - Navigation
extension WebViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.title") { (result, error) in
            if let title = result as? String {
                self.lblTitle.text = title
            } else if let error = error {
                self.lblTitle.text = "Plateforms"
            }
        }
    }
}
