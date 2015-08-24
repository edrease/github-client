//
//  AuthService.swift
//  GithubClient
//
//  Created by Edrease Peshtaz on 8/19/15.
//  Copyright (c) 2015 MysterioGroupSoftware. All rights reserved.
//

import UIKit

class AuthService {
  
  class func performIntialRequest() {
    UIApplication.sharedApplication().openURL(NSURL(string: "https://github.com/login/oauth/authorize?client_id=\(kClientID)&redirect_uri=GithubClientURL://oauth&scope=user,repo")!)
  }
  
  class func exchangeCodeInURL (codeURL: NSURL) {
    if let code = codeURL.query {
    let request = NSMutableURLRequest(URL: NSURL(string: "https://github.com/login/oauth/access_token?client_id=\(kClientID)&client_secret=\(kClientSecret)&\(code)")!)
      println(request.URL)
      request.HTTPMethod = "POST"
      request.setValue("application/json", forHTTPHeaderField: "Accept")
      
      NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
        
        if let httpResponse = response as? NSHTTPURLResponse {
          println(httpResponse.statusCode)
          
          var jsonError: NSError?
          
          if let jsonObject = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as? [String: AnyObject], token = jsonObject["access_token"] as? String {
            KeychainService.saveToken(token)
          }
        }
      }).resume()
    }
  }
}