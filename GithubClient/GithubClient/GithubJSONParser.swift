//
//  GithubJSONParser.swift
//  GithubClient
//
//  Created by Edrease Peshtaz on 8/18/15.
//  Copyright (c) 2015 MysterioGroupSoftware. All rights reserved.
//

import Foundation

class githubJSONParser {
  class func userInfoFromGithubData (jsonData: NSData) -> [UserProfile]? {
    
    var error: NSError?
    
    if let rootObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [String: AnyObject] {
      
      if let error = error {
        println("error")
      } else {
        
      var users = [UserProfile]()
      
      if let items = rootObject["items"] as? [[String: AnyObject]] {
        
        for item in items {
         if let userName = item["login"] as? String,
                avatarURL = item["avatar_url"] as? String,
                htmlURL = item["html_url"] as? String {
            
                  var user = UserProfile(name: userName, avatarURL: avatarURL, profileImage: nil, htmlURL: htmlURL)
          
            users.append(user)
          }
        }
      }
      return users
      }
    }
    return nil
  }
  
  
  class func repoInfoFromGithubData (jsonData: NSData) -> [RepoInformation]? {
    
    var error: NSError?
    
    if let rootObject = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as? [String: AnyObject] {
      
      if let error = error {
        println("repo json error")
      } else {
        var repos = [RepoInformation]()
        
        if let items = rootObject["items"] as? [[String: AnyObject]] {
          
          for item in items {
            
            if let name = item["name"] as? String,
                   ownerInfo = item["owner"] as? [String: AnyObject],
                   loginName = ownerInfo["login"] as? String,
              
                   descritption = item["description"] as? String,
                   url = item["html_url"] as? String {
                
                    var repo = RepoInformation(name: name, ownerLogin: loginName, description: descritption, url: url)
                   
                    repos.append(repo)
            }
          }
        }
        return repos
      }
    }
    return nil
  }
}
