//
//  RepoSearchViewController.swift
//  GithubClient
//
//  Created by Edrease Peshtaz on 8/20/15.
//  Copyright (c) 2015 MysterioGroupSoftware. All rights reserved.
//

import UIKit

class RepoSearchViewController: UIViewController {

//MARK: Constants/Variables
  var reposForSearch = [RepoInformation]()
  
//MARK: Outlets
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
//MARK: Life Cycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    searchBar.delegate = self
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
//MARK: Segue Function
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ToRepoDetailWebViewControoler" {
      if let repoDetailWebViewController = segue.destinationViewController as? RepoDetailWebViewController, indexPath = tableView.indexPathForSelectedRow() {
        let selectedRow = indexPath.row
        let selectedRepo = reposForSearch[selectedRow]
        repoDetailWebViewController.repo = selectedRepo
      }
    }
  }
}

//MARK: UISearchBarDelegate
extension RepoSearchViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    GithubService.reposForSearchTerm(self.searchBar.text, completionHandler: { (errorDescription, repos) -> (Void) in
      if let repos = repos {
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
          self.reposForSearch = repos
          self.tableView.reloadData()
        })
      }
    })
    self.searchBar.resignFirstResponder()
  }
  
  func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
    return text.validateURL()
  }
}

//MARK: UITableViewDataSource
extension RepoSearchViewController: UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return reposForSearch.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! RepoSearchResultsCell
    var repo = reposForSearch[indexPath.row]
    cell.repoNameLabel.text = repo.name
    cell.userLoginLabel.text = repo.ownerLogin
    cell.repoDescriptionLabel.text = repo.description
    return cell
  }
}
