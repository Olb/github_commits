//
//  SearchRepoPresenter.swift
//  GithubCommits
//
//  Created by Billy Bray on 6/14/19.
//  Copyright © 2019 Billy Bray. All rights reserved.
//

import Foundation

protocol RepoSearchPresenterDelegate {
    func showProgressIndicator()
    func hideProgressIndicator()
    func repoSearchSuccess(commits: Commits)
    func reportSearchFailed(message: String)
}

struct SearchRepoPresenter: CommitApiProtocol {
    
    let delegate: RepoSearchPresenterDelegate
    var webService: WebServiceProtocol?
    
    init(delegate: RepoSearchPresenterDelegate) {
        self.delegate = delegate
    }
    
    func search(ownerName: String, repoName: String) {

        self.delegate.showProgressIndicator()
        if (ownerName.isEmpty) {
            self.delegate.reportSearchFailed(message: "Owner name is required.")
            self.delegate.hideProgressIndicator()
        } else if (repoName.isEmpty) {
            self.delegate.reportSearchFailed(message: "Repo name is required.")
            self.delegate.hideProgressIndicator()
        } else {
            webService?.getCommits(repoSearchInfo: RepoSearchInfo(ownerName: ownerName, repoName: repoName))
        }
    }
    
    func success(commits: Commits) {
        self.delegate.repoSearchSuccess(commits: commits)
        self.delegate.hideProgressIndicator()
    }
    
    func failure(message: String) {
        self.delegate.reportSearchFailed(message: "\(message)")
        self.delegate.hideProgressIndicator()
    }
    
}
