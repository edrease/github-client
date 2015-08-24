//
//  UserDetailViewController.swift
//  GithubClient
//
//  Created by Edrease Peshtaz on 8/22/15.
//  Copyright (c) 2015 MysterioGroupSoftware. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

//MARK: Constants/Variables
  var selectedUser: UserProfile!
  let kCornerRadiusForProfileImage: CGFloat = 50

//MARK: Outlets
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var userURLLable: UILabel!

//MARK: Life Cycle Methods
  override func viewDidLoad() {
      super.viewDidLoad()
    imageView.layer.cornerRadius = self.kCornerRadiusForProfileImage
    imageView.clipsToBounds = true
    imageView.image = selectedUser.profileImage
    userNameLabel.text = selectedUser.name
    userURLLable.text = selectedUser.htmlURL
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
