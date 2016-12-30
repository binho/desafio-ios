//
//  PullViewController.swift
//  JavaPop
//
//  Created by Cleber Santos on 12/30/16.
//  Copyright © 2016 Cleber Santos. All rights reserved.
//

import Foundation
import UIKit

class PullViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var repo: Repo! {
        didSet {
            if let pageTitle = repo?.name {
                self.navigationItem.title = pageTitle
            }
        }
    }
    
    var user: User!
    
    var totalOpen = 0
    var totalClosed = 0
    
    // Private
    private var results: [(PullViewModel, UserViewModel)] = []
    private var tableView: UITableView!
    private let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    private var headerLabel: UILabel!
    private let cellIdentifier = "PullCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.setupUI()
        self.loadData()
    }
    
    func loadData() {
        activityIndicatorView.startAnimating()
        
        let api = PullAPI()
        api.getPulls(user.username, repo.name) { (data, error) in
            self.results = data as! [(PullViewModel, UserViewModel)]
            
            self.setupTotals()
            
            DispatchQueue.main.sync {
                self.activityIndicatorView.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
    
    func setupTotals() {
        totalOpen = 0; totalClosed = 0
        
        for (pullViewModel, _) in results {
            if (pullViewModel.pull.state == .open) {
                totalOpen += 1
            } else if (pullViewModel.pull.state == .closed) {
                totalClosed += 1
            }
        }

        let openedString = "\(totalOpen) opened"
        let closedString = "\(totalClosed) closed"
        
        let attributedString = NSMutableAttributedString(string: "\(openedString) / \(closedString)", attributes: nil)
        
        let openedStringRange = (attributedString.string as NSString).range(of: openedString)
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor(hexString: "dd910c"), range: openedStringRange)
        
        DispatchQueue.main.async {
            self.headerLabel.attributedText = attributedString
        }
    }
    
    func setupUI() {
        self.view.backgroundColor = UIColor.white
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        
        headerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 35))
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont.boldSystemFont(ofSize: 14)
        
        let bottomBorder = CALayer()
        bottomBorder.backgroundColor = UIColor.lightGray.cgColor
        bottomBorder.frame = CGRect(x: 0, y: 35, width: self.view.frame.size.width, height: 1)
        headerLabel.layer.addSublayer(bottomBorder)
        
        tableView.tableHeaderView = headerLabel
        
        self.view.addSubview(self.tableView)
        
        tableView.register(PullCell.self, forCellReuseIdentifier: cellIdentifier)
        
        
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2 - 60)
        self.view.addSubview(activityIndicatorView)
        self.view.bringSubview(toFront: activityIndicatorView)
        
        self.setupConstraints()
    }
    
    func setupConstraints() {
        // Make the constraints start below navigation bar
        if self.responds(to: NSSelectorFromString("edgesForExtendedLayout")) {
            edgesForExtendedLayout = []
        }
        
        let views = ["tableView": tableView] as [String : Any]
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tableView]|", options: [], metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tableView]|", options: [], metrics: nil, views: views))
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 133
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PullCell
        
        let (pullViewModel, userViewModel) = results[indexPath.row]
        
        cell.titleLabel.text = pullViewModel.titleText
        cell.descriptionLabel.text = pullViewModel.descriptionText
        
        cell.userNameLabel.text = userViewModel.nameText
        cell.userUsernameLabel.text = userViewModel.usernameText
        cell.userAvatarImageView.loadImageUsingCacheWithURL(url: NSURL(string: userViewModel.avatarURL)!)
        
        return cell
    }

}
