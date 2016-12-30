//
//  PullCell.swift
//  JavaPop
//
//  Created by Cleber Santos on 12/30/16.
//  Copyright © 2016 Cleber Santos. All rights reserved.
//

import Foundation
import UIKit

class PullCell: UITableViewCell {
    
    let pullContainerView = UIView()
    let userContainerView = UIView()
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    let userAvatarImageView = UIImageView()
    let userUsernameLabel = UILabel()
    let userNameLabel = UILabel()
    let userAvatarContainerView = UIView()
    let userInfoContainerView = UIView()
    
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
        
        pullContainerView.translatesAutoresizingMaskIntoConstraints = false
        userContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Repo
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor(hexString: "0b649f")
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        descriptionLabel.numberOfLines = 2
        descriptionLabel.lineBreakMode = NSLineBreakMode.byTruncatingTail
        descriptionLabel.textColor = UIColor(hexString: "0a0a0a")
        
        // User
        userAvatarContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        userAvatarImageView.translatesAutoresizingMaskIntoConstraints = false
        userAvatarImageView.backgroundColor = UIColor.clear
        userAvatarImageView.layer.cornerRadius = 15
        userAvatarImageView.layer.masksToBounds = true
        userAvatarImageView.layer.shouldRasterize = true // Improves cell scrolling performance due to corner radius
        userAvatarImageView.layer.rasterizationScale = UIScreen.main.scale
        
        userInfoContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.textAlignment = .left
        userNameLabel.textColor = UIColor(hexString: "a4a4a5")
        userNameLabel.font = UIFont.systemFont(ofSize: 12)
        
        userUsernameLabel.translatesAutoresizingMaskIntoConstraints = false
        userUsernameLabel.textAlignment = .left
        userUsernameLabel.textColor = UIColor(hexString: "0b649f")
        userUsernameLabel.font = UIFont.systemFont(ofSize: 12)
        
        pullContainerView.addSubview(titleLabel)
        pullContainerView.addSubview(descriptionLabel)
        contentView.addSubview(pullContainerView)
        
        userAvatarContainerView.addSubview(userAvatarImageView)
        userContainerView.addSubview(userAvatarContainerView)
        
        userInfoContainerView.addSubview(userUsernameLabel)
        userInfoContainerView.addSubview(userNameLabel)
        userContainerView.addSubview(userInfoContainerView)
        contentView.addSubview(userContainerView)
        
        self.setupConstraints()
    }
    
    func setupConstraints() {
        let views = ["pullContainerView" : pullContainerView, "userContainerView" : userContainerView, "titleLabel" : titleLabel, "descriptionLabel" : descriptionLabel, "userAvatarImageView" : userAvatarImageView, "userUsernameLabel" : userUsernameLabel, "userNameLabel" : userNameLabel, "userAvatarContainerView" : userAvatarContainerView, "userInfoContainerView" : userInfoContainerView]
        
        // Pull container contraints (top)
        pullContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[titleLabel]|", options: [], metrics: nil, views: views))
        pullContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[descriptionLabel]|", options: [], metrics: nil, views: views))
        pullContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[titleLabel]-[descriptionLabel]", options: [], metrics: nil, views: views))
        
        // User container constraints (bottom)
        userAvatarContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[userAvatarImageView(==30)]", options: [], metrics: nil, views: views))
        userAvatarContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[userAvatarImageView(==30)]", options: [], metrics: nil, views: views))

        userInfoContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[userUsernameLabel]|", options: [], metrics: nil, views: views))
        userInfoContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[userNameLabel]|", options: [], metrics: nil, views: views))
        userInfoContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[userUsernameLabel][userNameLabel]", options: [], metrics: nil, views: views))
        
        userContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[userAvatarContainerView(==30)]-[userInfoContainerView]|", options: [], metrics: nil, views: views))
        userContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[userAvatarContainerView(==30)]", options: [], metrics: nil, views: views))
        userContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[userInfoContainerView]|", options: [], metrics: nil, views: views))
        
        // Set containers position inside cell
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[pullContainerView]-20-|", options: [], metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[userContainerView]-20-|", options: [], metrics: nil, views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[pullContainerView]-[userContainerView(==30)]-20-|", options: [], metrics: nil, views: views))
    }
    
}
