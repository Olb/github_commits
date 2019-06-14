//
//  Webservice.swift
//  GithubCommits
//
//  Created by Billy Bray on 6/14/19.
//  Copyright © 2019 Billy Bray. All rights reserved.
//

import Foundation

protocol CommitApiProtocol {
    func success(commits: Commits)
    func failure(message: String)
}

protocol WebServiceProtocol {
    var delegate: CommitApiProtocol { get set }
    func getCommits(repoSearchInfo: RepoSearchInfo)
}

class WebService: WebServiceProtocol {
    var delegate: CommitApiProtocol
    
    init(delegate: CommitApiProtocol) {
        self.delegate = delegate
    }
    
    func getCommits(repoSearchInfo: RepoSearchInfo) {
        
        print("Called getCommits")
        
        let url = URL(string: "https://api.github.com/repos/\(repoSearchInfo.ownerName)/\(repoSearchInfo.repoName)/commits")!
        
        let task = URLSession.shared.dataTask(with: url) { (result) in
            switch result {
            case .success(let res, let data):
                if let response = res as? HTTPURLResponse {
                    print("res: \(response.statusCode)")
                    switch response.statusCode {
                    case 200:
                        let commitsTry = try? JSONDecoder().decode(Commits.self, from: data)
                        guard let commits = commitsTry else {
                            self.delegate.failure(message: "Unable to get that repo. Please check the owner and repo names and try again.")
                            return
                        }
                        self.delegate.success(commits: commits)
                        break
                    case 404:
                        self.delegate.failure(message: "That owner name and repo name does not appear to be a valid repo. Please check the names and try again.")
                        break
                    default:
                        self.delegate.failure(message: "Unable to get that repo. Status - \(response.statusCode). Please check the owner and repo names and try again.")
                    }
                    
                } else {
                    self.delegate.failure(message: "Unable to get that repo. Please check the owner and repo names and try again.")
                }
                break
            case .failure(let error):
                print("In failure: \(error)")
                self.delegate.failure(message: error.localizedDescription)
                break
            }
        }
        task.resume()
    }
}

extension URLSession {
    func dataTask(with url: URL, result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {
        return dataTask(with: url) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
}
