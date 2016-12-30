//
//  Repo.swift
//  JavaPop
//
//  Created by Cleber Santos on 12/29/16.
//  Copyright © 2016 Cleber Santos. All rights reserved.
//

import Foundation
import UIKit

class Repo {
    
    var name: String
    var description: String
    var forks: Int
    var stars: Int
    
    init(name: String, description: String, forks: Int, stars: Int) {
        self.name = name
        self.description = description
        self.forks = forks
        self.stars = stars
    }
    
    class func createFromJSON(_ repoDict: Dictionary<String, AnyObject>) -> Repo! {
        if let name = repoDict["name"] as? String,
            let description = repoDict["description"] as? String,
            let forks = repoDict["forks"] as? Int,
            let stars = repoDict["stargazers_count"] as? Int {
            
            return Repo(name: name, description: description, forks: forks, stars: stars)
        }
        
        return nil
    }
}

class RepoViewModel {
    // private(set) in this property means that external sources can only read
    private(set) var repo: Repo
    
    init(repo: Repo) {
        self.repo = repo
    }
    
    var nameText: String {
        return repo.name
    }
    
    var descriptionText: String {
        return repo.description
    }
    
    var infoString: String {
        return "\(repo.forks) - \(repo.stars)"
    }
    
    var attributedInfoString: NSAttributedString {
        let forkImageAttachment = NSTextAttachment()
        forkImageAttachment.image = UIImage(named: "totalforks")
        forkImageAttachment.bounds = CGRect(x: 0, y: -2, width: 0, height: 0)
        forkImageAttachment.setImageHeight(height: 16)
        
        let starImageAttachment = NSTextAttachment()
        starImageAttachment.image = UIImage(named: "totalstars")
        starImageAttachment.bounds = CGRect(x: 0, y: -2, width: 0, height: 0)
        starImageAttachment.setImageHeight(height: 16)
        
        let attributedString = NSMutableAttributedString(string: "f \(repo.forks)   s \(repo.stars)", attributes: nil)
        
        let forkRange = (attributedString.string as NSString).range(of: "f")
        let starRange = (attributedString.string as NSString).range(of: "s")
        
        attributedString.replaceCharacters(in: forkRange, with: NSAttributedString(attachment: forkImageAttachment))
        attributedString.replaceCharacters(in: starRange, with: NSAttributedString(attachment: starImageAttachment))
        
        return attributedString
    }
}
