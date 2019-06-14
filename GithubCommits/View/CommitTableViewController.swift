//
//  CommitTableViewController.swift
//  GithubCommits
//
//  Created by Billy Bray on 6/14/19.
//  Copyright © 2019 Billy Bray. All rights reserved.
//

import UIKit

let SEARCH_INFO_SEGUE = "search-info-identifier"

class CommitTableViewController: UITableViewController, RepoCommitsPresenterDelegate, SearchRepoViewControllerDelegate {
    
    var commits: Commits = []
    var repoPresenter: RepoPresenter!

    // MARK: - Lifecyle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "CommitTableViewCell", bundle: nil), forCellReuseIdentifier: "commit-cell-id")
        
        repoPresenter = RepoPresenter(delegate: self)
    }
    
    
    @IBAction func searchPressed(_ sender: Any) {
        self.repoPresenter.searchPressed()
    }
    
    // MARK: - RepoCommitsPresenterDelegate methods
    
    func loadCommits(commits: Commits) {
        self.commits = commits
        self.tableView.reloadData()
    }
    
    func showSearchInfo() {
        self.performSegue(withIdentifier: SEARCH_INFO_SEGUE, sender: nil)
    }
    
    // MARK: - SearchRepoViewControllerDelegate methods
    
    func commitsFound(commits: Commits) {
        self.repoPresenter.newCommits(commits: commits)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commits.count
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == SEARCH_INFO_SEGUE) {
            let vc = segue.destination as! SearchRepoViewController
            vc.delegate = self
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commit-cell-id", for: indexPath) as! CommitTableViewCell
        
        cell.name.text = commits[indexPath.row].commitName
        cell.sha.text = commits[indexPath.row].commitHash
        cell.message.text = commits[indexPath.row].commitMessage
        
        return cell
    }


}
