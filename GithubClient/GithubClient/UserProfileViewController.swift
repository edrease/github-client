//
//  UserRepoViewController.swift
//  GithubClient
//
//  Created by Edrease Peshtaz on 8/17/15.
//  Copyright (c) 2015 MysterioGroupSoftware. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
  
//MARK: Constants/Variables
  let kCornerRadiusForProfileImage: CGFloat = 35
  var userProfiles = [UserProfile]()
  lazy var imageQueue = NSOperationQueue()

//MARK: Outlets
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var collectionView: UICollectionView!
  
  
//MARK: Life Cycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    searchBar.delegate = self
    collectionView.dataSource = self
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.delegate = self
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.delegate = nil
  }

//MARK: Segue Function
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ToUserDetailViewController" {
      if let destination = segue.destinationViewController as? UserDetailViewController, indexPath = collectionView.indexPathsForSelectedItems().first as? NSIndexPath {
        let user = userProfiles[indexPath.row]
        destination.selectedUser = user
      }
    }
  }
}

//MARK: UISearchBarDelegate
extension UserProfileViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    GithubService.userForSearchTerm(self.searchBar.text) { (errorDescription, users) -> (Void) in
      if let users = users {
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          self.userProfiles = users
          self.collectionView.reloadData()
        })
      }
    }
    self.searchBar.resignFirstResponder()
  }
  
  func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
    return text.validateURL()
  }
}

//MARK: UICollectionViewDataSource
extension UserProfileViewController: UICollectionViewDataSource {
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return userProfiles.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! UserSearchResultsCell
    cell.tag++
    let tag = cell.tag
    var user = userProfiles[indexPath.row]
    cell.userNameLabel.text = user.name
    
    if let profileImage = user.profileImage {
      cell.profileImage.image = profileImage
    } else {
      imageQueue.addOperationWithBlock({ () -> Void in
        
        if let image = DownloadImage.fetchImage(user.avatarURL) {
          let size = ImageResizer.switchImageSize(image)
          let resizedImage = ImageResizer.resizeImage(image, size: size)
          
          NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            user.profileImage = resizedImage
            self.userProfiles[indexPath.row] = user
            if cell.tag == tag {
              cell.profileImage.image = resizedImage
              cell.profileImage.layer.cornerRadius = self.kCornerRadiusForProfileImage
              cell.profileImage.clipsToBounds = true
            }
          })
        }
      })
    }
    return cell
  }
}

//MARK: UINavigationControllerDelegate
extension UserProfileViewController: UINavigationControllerDelegate {
  func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return toVC is UserDetailViewController ? ToUserDetailAnimationController() : nil
  }
}
