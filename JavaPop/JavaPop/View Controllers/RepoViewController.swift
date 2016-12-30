//
//  RepoViewController.swift
//  JavaPop
//
//  Created by Cleber Santos on 12/29/16.
//  Copyright © 2016 Cleber Santos. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    // To control the moment we start loading next page so you don't have to wait for the API response too much.
    private let numberOfItemsBeforeLoadingNextPage: Int = 3
    private var currentPage: Int = 1
    private var results: [(RepoViewModel, UserViewModel)] = []

    private var tableView: UITableView!
    private let cellIdentifier = "RepoCellIdentifier"
    private let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    
    // Search
    var searchBar: UISearchBar!
    private var searchActive : Bool = false
    private var filteredResults: [(RepoViewModel, UserViewModel)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.loadData()
    }
    
    func loadData(_ page: Int? = 1) {
        // Reset results when loading for first time
        if (page == 0 || page == 1) {
            self.results.removeAll()
        }
        
        activityIndicatorView.startAnimating()
        
        let api = RepoAPI()
        api.getRepos(page: page!) { (data, error) in
            self.results.append(contentsOf: data as! [(RepoViewModel, UserViewModel)])
            
            DispatchQueue.main.sync {
                self.activityIndicatorView.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
    
    func setupUI() {
        self.title = "Github JavaPop"
        self.view.backgroundColor = UIColor.white
        
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Filter by repo name"
        searchBar.delegate = self
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableHeaderView = searchBar
        tableView.tableFooterView = UIView()
        self.view.addSubview(self.tableView)
        tableView.register(RepoCell.self, forCellReuseIdentifier: cellIdentifier)
        
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
        return 128
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (searchActive ? filteredResults.count : results.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RepoCell

        let (repoViewModel, userViewModel) = (searchActive ? filteredResults[indexPath.row] : results[indexPath.row])
        
        cell.nameLabel.text = repoViewModel.nameText
        cell.descLabel.text = repoViewModel.descriptionText
        cell.infoLabel.attributedText = repoViewModel.attributedInfoString
        
        cell.userNameLabel.text = userViewModel.nameText
        cell.userUsernameLabel.text = userViewModel.usernameText
        cell.userAvatarImageView.loadImageUsingCacheWithURL(url: NSURL(string: userViewModel.avatarURL)!)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let (repoViewModel, userViewModel) = (searchActive ? filteredResults[indexPath.row] : results[indexPath.row])
        
        let viewController = PullViewController()
        viewController.repo = repoViewModel.repo
        viewController.user = userViewModel.user
        
        self.navigationController?.pushViewController(viewController, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (results.count - numberOfItemsBeforeLoadingNextPage) && !searchActive {
            currentPage += 1

            print("Loading more content with page: \(currentPage)")
            self.loadData(currentPage)
        }
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredResults = results.filter({ (repoViewModel, _) -> Bool in
            let tmp: NSString = repoViewModel.repo.name as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })

        searchActive = !(filteredResults.count == 0)

        self.tableView.reloadData()
    }

}
