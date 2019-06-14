//
//  CommitTableViewController.swift
//  GithubCommits
//
//  Created by Billy Bray on 6/14/19.
//  Copyright © 2019 Billy Bray. All rights reserved.
//

import UIKit

let SEARCH_INFO_SEGUE = "search-info-identifier"

class CommitTableViewController: UITableViewController, RepoCommitsPresenterDelegate {
    
    var commits: Commits = []
    var repoPresenter: RepoPresenter!

    // MARK: - Lifecyle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        repoPresenter = RepoPresenter(delegate: self)
    }
    
    // MARK: - RepoCommitsPresenterDelegate methods
    
    func loadCommits(commits: Commits) {
        
    }
    
    func showSearchViewController() {
        
    }
    
    func showSearchInfo() {
        self.performSegue(withIdentifier: SEARCH_INFO_SEGUE, sender: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commits.count
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */


 


}
