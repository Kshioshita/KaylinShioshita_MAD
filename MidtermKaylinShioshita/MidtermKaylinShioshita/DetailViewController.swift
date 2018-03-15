//
//  DetailViewController.swift
//  MidtermKaylinShioshita
//
//  Created by Kaylin Shioshita on 3/15/18.
//  Copyright © 2018 Kaylin Shioshita. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webSpinner: UIActivityIndicatorView!
    var restauranturl:String?
//    var detailRestaurant:String?
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate=self
        configureView()
        webSpinner.hidesWhenStopped=true
        // Do any additional setup after loading the view.
    }

    func configureView(){
        if let url = restauranturl{
            if url != "null"{
                loadWebsite(url)
            }
        }
    }
    func loadWebsite(_ url:String){
        let url=URL(string: url)
        let request = URLRequest(url:url!)
        webView.load(request)
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        webSpinner.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webSpinner.stopAnimating()
        
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
