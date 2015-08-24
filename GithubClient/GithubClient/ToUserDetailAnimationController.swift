//
//  ToUserDetailAnimationController.swift
//  GithubClient
//
//  Created by Edrease Peshtaz on 8/22/15.
//  Copyright (c) 2015 MysterioGroupSoftware. All rights reserved.
//

import UIKit

class ToUserDetailAnimationController: NSObject {
  
}

//MARK: UIViewControllerAnimatedTransitioning
extension ToUserDetailAnimationController: UIViewControllerAnimatedTransitioning {
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
    return 0.5
  }
  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    
    if let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? UserProfileViewController,
      toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? UserDetailViewController {
    
      let containerView = transitionContext.containerView()
      
      toVC.view.alpha = 0
      
      containerView.addSubview(toVC.view)
        
      let indexPath = fromVC.collectionView.indexPathsForSelectedItems().first as! NSIndexPath
      let userCell = fromVC.collectionView.cellForItemAtIndexPath(indexPath) as! UserSearchResultsCell
      let snapShot = userCell.profileImage.snapshotViewAfterScreenUpdates(false)
      
      snapShot.frame = containerView.convertRect(userCell.profileImage.frame, fromCoordinateSpace: userCell.profileImage.superview!)
        
      containerView.addSubview(snapShot)
      userCell.hidden = true
        
      toVC.view.layoutIfNeeded()
        
      toVC.imageView.hidden = true
        
      let destinationFrame = toVC.imageView.frame
        
      UIView.animateWithDuration(0.5, animations: { () -> Void in
        snapShot.frame = destinationFrame
        toVC.view.alpha = 1
        }, completion: { (finished) -> Void in
         userCell.hidden = false
         toVC.imageView.hidden = false
         snapShot.removeFromSuperview()
          if finished {
            transitionContext.completeTransition(finished)
          } else {
            transitionContext.completeTransition(finished)
          }
      })
    }
  }
}