//
//  RepoCell.swift
//  JavaPop
//
//  Created by Cleber Santos on 12/29/16.
//  Copyright © 2016 Cleber Santos. All rights reserved.
//

import Foundation
import UIKit

class RepoCell: UITableViewCell {
    
//    var repoViewModel: RepoViewModel! {
//        didSet {
//            if let viewModel = repoViewModel as RepoViewModel? {
//                nameLabel.text = viewModel.nameText
//                descLabel.text = viewModel.descriptionText
//                infoLabel.attributedText = viewModel.attributedInfoString
//                setNeedsLayout()
//            }
//        }
//    }

    let repoContainerView = UIView()
    let userContainerView = UIView()
    
    let nameLabel = UILabel()
    let descLabel = UILabel()
    let infoLabel = UILabel() // forks & stars
    
    let userAvatarImageView = UIImageView()
    
    let userUsernameLabel = UILabel()
    let userNameLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupUI()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupUI() {
        self.selectionStyle = .none
        
        repoContainerView.translatesAutoresizingMaskIntoConstraints = false
        userContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Repo
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = UIColor(hexString: "0b649f")
        
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.font = UIFont.systemFont(ofSize: 12)
        descLabel.numberOfLines = 2
        descLabel.lineBreakMode = NSLineBreakMode.byTruncatingTail
        descLabel.textColor = UIColor(hexString: "0a0a0a")
        
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.font = UIFont.systemFont(ofSize: 16)
        infoLabel.textColor = UIColor(hexString: "dd910c")
        
        // User
        
        userAvatarImageView.translatesAutoresizingMaskIntoConstraints = false
        userAvatarImageView.backgroundColor = UIColor.clear
        userAvatarImageView.layer.cornerRadius = 20.5
        userAvatarImageView.layer.masksToBounds = true
        userAvatarImageView.layer.shouldRasterize = true // Improves cell scrolling performance due to corner radius
        userAvatarImageView.layer.rasterizationScale = UIScreen.main.scale
        
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.textAlignment = .center
        userNameLabel.textColor = UIColor(hexString: "a4a4a5")
        userNameLabel.font = UIFont.systemFont(ofSize: 12)
        
        userUsernameLabel.translatesAutoresizingMaskIntoConstraints = false
        userUsernameLabel.textAlignment = .center
        userUsernameLabel.textColor = UIColor(hexString: "0b649f")
        userUsernameLabel.font = UIFont.systemFont(ofSize: 12)
        
        repoContainerView.addSubview(nameLabel)
        repoContainerView.addSubview(descLabel)
        repoContainerView.addSubview(infoLabel)
        contentView.addSubview(repoContainerView)

        userContainerView.addSubview(userAvatarImageView)
        userContainerView.addSubview(userUsernameLabel)
        userContainerView.addSubview(userNameLabel)
        contentView.addSubview(userContainerView)
        
        self.setupConstraints()
    }
    
    func setupConstraints() {
        let views = ["repoContainerView" : repoContainerView, "userContainerView" : userContainerView, // Containers
                     "nameLabel" : nameLabel, "descLabel" : descLabel, "infoLabel" : infoLabel, // Repo
                     "userAvatarImageView" : userAvatarImageView, "userUsernameLabel" : userUsernameLabel, "userNameLabel" : userNameLabel] // User
        
        // Repo container contraints (left)
        repoContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[nameLabel]|", options: [], metrics: nil, views: views))
        repoContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[descLabel]|", options: [], metrics: nil, views: views))
        repoContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[infoLabel]|", options: [], metrics: nil, views: views))
        repoContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[nameLabel]-[descLabel]-[infoLabel(==24)]", options: [], metrics: nil, views: views))
        
        // User container constraints (right)
        userContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[userAvatarImageView(==41)]", options: [], metrics: nil, views: views))
        userContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[userNameLabel]|", options: [], metrics: nil, views: views))
        userContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[userUsernameLabel]|", options: [], metrics: nil, views: views))
        userContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[userAvatarImageView(==41)]-[userUsernameLabel][userNameLabel]", options: [], metrics: nil, views: views))
        userContainerView.addConstraint(NSLayoutConstraint(item: userAvatarImageView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: userContainerView, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0))
        
        // Set containers position inside cell
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[repoContainerView]-[userContainerView(==100)]-10-|", options: [], metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[repoContainerView(==80)]", options: [], metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[userContainerView(==80)]", options: [], metrics: nil, views: views))
        contentView.addConstraint(NSLayoutConstraint(item: repoContainerView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0.0))
        contentView.addConstraint(NSLayoutConstraint(item: userContainerView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 0.0))
    }

}
