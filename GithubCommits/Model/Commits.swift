//
//  Commits.swift
//  GithubCommits
//
//  Created by Billy Bray on 6/14/19.
//  Copyright © 2019 Billy Bray. All rights reserved.
//

import Foundation

typealias Commits = [Commit]

struct Commit: Codable {
    let sha: String
    let commit: CommitDetails
    
    var commitName: String {
        get {
            return commit.author.name
        }
    }
    
    var commitMessage: String {
        get {
            return "Message: \(commit.message)"
        }
    }
    
    var commitHash: String {
        get {
            return "Commit: \(self.sha)"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case sha
        case commit
    }
}

struct CommitDetails: Codable {
    let message: String
    let author: Author
    
    enum CodingKeys: String, CodingKey {
        case message
        case author
    }
}

struct Author: Codable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}
