//
//  ImageResizer.swift
//  TwitterClone
//
//  Created by Edrease Peshtaz on 8/8/15.
//  Copyright (c) 2015 MysterioGroupSoftware. All rights reserved.
//

import UIKit

class ImageResizer {
  
  class func resizeImage(image: UIImage, size: CGSize) -> UIImage {
   UIGraphicsBeginImageContext(size)
   image.drawInRect(CGRect(x: 0, y: 0, width: size.width, height: size.height))
   let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
   return resizedImage
  }
  
  class func switchImageSize (imageToResize: UIImage) -> CGSize {
    var size: CGSize
    switch UIScreen.mainScreen().scale {
    case 2:
      size = CGSize(width: 140, height: 140)
    case 3:
      size = CGSize(width: 210, height: 210)
    default:
      size = CGSize(width: 70, height: 70)
    }
    return size
  }
}
