//
//  GithubService.swift
//  GithubClient
//
//  Created by Edrease Peshtaz on 8/17/15.
//  Copyright (c) 2015 MysterioGroupSoftware. All rights reserved.
//

import Foundation

class GithubService {
  
  static let sharedService = GithubService()
  private init() {} 
  
  class func userForSearchTerm(searchTerm: String, completionHandler: (String?, [UserProfile]?) -> (Void)) {
    let baseURL = "https://api.github.com/search/users"
    let finalURL = baseURL + "?q=\(searchTerm)"
    
    if let url = NSURL(string: finalURL) {
      NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
        if let error = error {
          println("oh shit")
          return
        } else if let httpResponse = response as? NSHTTPURLResponse {
          println(httpResponse)
          let users = githubJSONParser.userInfoFromGithubData(data)
          completionHandler(nil, users)
        }
      }).resume()
    }
  }
  
  class func reposForSearchTerm(searchTerm: String, completionHandler: (String?, [RepoInformation]?) -> (Void)) {
    let baseURL = "https://api.github.com/search/repositories"
    let finalURL = baseURL + "?q=\(searchTerm)"
    
    if let url = NSURL(string: finalURL) {
      NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
        if let error = error {
          println("Error in getting repos")
        } else if let httpResponse = response as? NSHTTPURLResponse {
          println(httpResponse)
          let repos = githubJSONParser.repoInfoFromGithubData(data)
          completionHandler(nil, repos)
        }
      }).resume()
    }
  }
  
  
}