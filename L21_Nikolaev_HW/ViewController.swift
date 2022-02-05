//
//  ViewController.swift
//  L21_Nikolaev_HW
//
//  Created by Alexandr Nikolaev on 5.02.22.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var urlTextField: UITextField!
    
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        urlTextField.delegate = self
        webView.navigationDelegate = self
        
        let urlString = "https://www.apple.com"
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        
        urlTextField.text = urlString
        
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
        
        
    }


    @IBAction func refreshButtonAction(_ sender: Any) {
        webView.reload()
    }
    @IBAction func forwardButtonAction(_ sender: Any) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    @IBAction func backButtonAction(_ sender: Any) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
}



extension ViewController: UITextFieldDelegate, WKNavigationDelegate  {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let urlString = textField.text!
        var url = URL(string: "")
        if urlString.contains("https://"){
            url = URL(string: urlString)
        } else {
            url = URL(string: "https://\(urlString)")
        }
        let request = URLRequest(url: url!)
        webView.load(request)
        
        textField.resignFirstResponder()
        
        return true
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        urlTextField.text = webView.url?.absoluteString
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
}

