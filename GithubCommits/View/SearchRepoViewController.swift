//
//  SearchRepoViewController.swift
//  GithubCommits
//
//  Created by Billy Bray on 6/14/19.
//  Copyright © 2019 Billy Bray. All rights reserved.
//

import UIKit

protocol SearchRepoViewControllerDelegate {
    func commitsFound(commits: Commits)
}

class SearchRepoViewController: UIViewController, UITextFieldDelegate, RepoSearchPresenterDelegate {
    
    @IBOutlet weak var repoOwnerNameTextField: UITextField!
    @IBOutlet weak var repoNameTextField: UITextField!
    @IBOutlet weak var instructionsLabel: UILabel!
    
    fileprivate var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var presenter: SearchRepoPresenter!
    var delegate: SearchRepoViewControllerDelegate?

    // MARK: - Lifecyle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = SearchRepoPresenter(delegate: self)
        self.presenter.webService = WebService(delegate: self.presenter)
    }
    
    // MARK: - IBActions
    
    @IBAction func searchRepoPressed(_ sender: Any) {
        self.presenter.search(ownerName: repoOwnerNameTextField.text! , repoName: repoNameTextField.text!)
    }
    
    
    @IBAction func showDefaultGithubInfoPressed(_ sender: Any) {
        self.presenter.showDefaultGithubInfo()
    }
    
    // MARK: - RepoSearchPresenterDelegate methods
    
    func showProgressIndicator() {
        addActivityIndicator()
    }
    
    func hideProgressIndicator() {
        removeActivityIndicator()
    }
    
    func repoSearchSuccess(commits: Commits) {
        DispatchQueue.main.async { [weak self] in
            self?.dismiss(animated: true, completion: nil)
            self?.delegate?.commitsFound(commits: commits)
        }
    }
    
    func reportSearchFailed(message: String) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Oops!", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
    }
}

extension SearchRepoViewController {
    
    // MARK: - Activity indicator methods
    
    func addActivityIndicator() {
        self.activityIndicator.hidesWhenStopped = true
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.activityIndicator.centerYAnchor.constraint(equalTo: self.instructionsLabel.centerYAnchor, constant: -(self.instructionsLabel.frame.size.height + 20)).isActive = true
        self.activityIndicator.startAnimating()
    }
    
    func removeActivityIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.removeFromSuperview()
        }
    }
    
    // MARK: - UITextfield delegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == repoOwnerNameTextField) {
            textField.resignFirstResponder()
            repoNameTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
