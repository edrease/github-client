//
//  MainMenuViewController.swift
//  GithubClient
//
//  Created by Edrease Peshtaz on 8/17/15.
//  Copyright (c) 2015 MysterioGroupSoftware. All rights reserved.
//

import UIKit

class MainMenuViewController: UITableViewController {

//MARK: Life Cycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    if let token = KeychainService.loadToken() {
      println("hurrah")
    } else {
      AuthService.performIntialRequest()
    }
    self.title = "Github Client"
    self.view.backgroundColor = UIColor.blackColor()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

}
