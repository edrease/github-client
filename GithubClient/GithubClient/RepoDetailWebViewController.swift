//
//  RepoDetailWebViewController.swift
//  GithubClient
//
//  Created by Edrease Peshtaz on 8/23/15.
//  Copyright (c) 2015 MysterioGroupSoftware. All rights reserved.
//

import UIKit
import WebKit

class RepoDetailWebViewController: UIViewController {

//MARK: Constants/Variables
  var repo: RepoInformation!

//MARK: Life Cycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let webView = WKWebView(frame: view.frame)
    view.addSubview(webView)
    
    let urlRequest = NSURLRequest(URL: NSURL(string: "\(repo.url)")!)
    webView.loadRequest(urlRequest)

  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
