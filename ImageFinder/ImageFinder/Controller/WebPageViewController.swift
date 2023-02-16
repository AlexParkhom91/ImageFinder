//
//  WebPageViewController.swift
//  ImageFinder
//
//  Created by Александр Пархамович on 16.02.23.
//

import Foundation
import WebKit

class WebPageViewController: UIViewController{
    
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: - Varibles
    var url: URL!
   
    
    // MARK: - UI Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        let request = URLRequest(url: url)
        self.webView.load(request)
    }
}
