//
//  DetailViewController.swift
//  BreakingNews
//
//  Created by Robert Pinl on 24.02.2021.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var articleUrl: URL!

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        webView.load(URLRequest(url: articleUrl))
    }
}
