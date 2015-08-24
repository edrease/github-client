//
//  DownloadImage.swift
//  TwitterClone
//
//  Created by Edrease Peshtaz on 8/10/15.
//  Copyright (c) 2015 MysterioGroupSoftware. All rights reserved.
//

import UIKit

class DownloadImage {
  
  class func fetchImage (imageURL: String) -> UIImage? {
    
    if let imageURL = NSURL(string: imageURL),
    imageData = NSData(contentsOfURL: imageURL),
    image = UIImage(data: imageData) {

      return image
    }
    return nil
  }
}
