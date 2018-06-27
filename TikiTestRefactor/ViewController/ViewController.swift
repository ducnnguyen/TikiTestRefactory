//
//  ViewController.swift
//  TikiTestRefactor
//
//  Created by TruongQuangMinh on 6/19/18.
//  Copyright © 2018 TruongQuangMinh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorView: UIView!
    
    let networkingService = NetworkingService()
    let tikiColor = UIColor(red: 27/255, green: 168/255, blue: 255/255, alpha: 1)
    var comments: [Comment]?
    var error: Error?
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.color = tikiColor
        prepareNavigationBar()
        prepareTableView()
        loadComments()
    }
    
    // MARK: - Loading comments
    
    @objc func loadComments() {
        isLoading = true
        tableView.tableFooterView = loadingView
        comments = []
        tableView.reloadData()
        
        networkingService.fetchComments(matching: nil, page: 1) { [weak self] response in
            
            guard let `self` = self else {
                return
            }
            
            self.isLoading = false
            self.update(response: response)
        }
    }
    
    func update(response: CommentsResult) {
        if let comments = response.comments, !comments.isEmpty {
            tableView.tableFooterView = nil
        } else if let error = response.error {
            errorLabel.text = error.localizedDescription
            tableView.tableFooterView = errorView
            tableView.reloadData()
            return
        } else {
            tableView.tableFooterView = emptyView
        }
        
        comments = response.comments
        error = response.error
        tableView.reloadData()
    }
    
    // MARK: - View Configuration
 
    func prepareNavigationBar() {
        navigationController?.navigationBar.barTintColor = tikiColor
        
        let whiteTitleAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = whiteTitleAttributes
    }
    
    func prepareTableView() {
        tableView.dataSource = self
        
        let nib = UINib(nibName: CommentTableViewCell.NibName, bundle: .main)
        tableView.register(nib, forCellReuseIdentifier: CommentTableViewCell.ReuseIdentifier)
    }
    
}

// MARK: -

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar,
                   selectedScopeButtonIndexDidChange selectedScope: Int) {
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self,
                                               selector: #selector(loadComments),
                                               object: nil)
        
        perform(#selector(loadComments), with: nil, afterDelay: 0.5)
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return comments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CommentTableViewCell.ReuseIdentifier)
            as? CommentTableViewCell else {
                return UITableViewCell()
        }
        
        if let comments = comments {
            cell.load(comment: comments[indexPath.row])
        }
        
        return cell
    }
}
