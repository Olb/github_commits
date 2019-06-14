//
//  RepoPresenter.swift
//  GithubCommits
//
//  Created by Billy Bray on 6/14/19.
//  Copyright © 2019 Billy Bray. All rights reserved.
//

import Foundation

protocol RepoCommitsPresenterDelegate {
    func loadCommits(commits: Commits)
    func showSearchViewController()
    func showSearchInfo()
}

struct RepoPresenter {
    let delegate: RepoCommitsPresenterDelegate
    
    init(delegate: RepoCommitsPresenterDelegate) {
        self.delegate = delegate
        self.delegate.showSearchInfo()
    }
    
    func searchPressed() {
        self.delegate.showSearchInfo()
    }
    
    func newCommits(commits: Commits) {
        self.delegate.loadCommits(commits: commits)
    }
}
