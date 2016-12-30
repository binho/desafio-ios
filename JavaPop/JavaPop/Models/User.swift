//
//  User.swift
//  JavaPop
//
//  Created by Cleber Santos on 12/29/16.
//  Copyright © 2016 Cleber Santos. All rights reserved.
//

import Foundation

class User {
    
    var name: String
    var username: String
    var avatarURL: String
    
    init(name: String, username: String, avatarURL: String) {
        self.name = name
        self.username = username
        self.avatarURL = avatarURL
    }
    
    class func createFromJSON(_ userDict: Dictionary<String, AnyObject>) -> User! {
        let name = ""//userDict["name"] as? String
        let username = userDict["login"] as? String
        let avatarURL = userDict["avatar_url"] as? String
        
        return User(name: name, username: username!, avatarURL: avatarURL!)
    }
}

class UserViewModel {
    private(set) var user: User
    
    init(user: User) {
        self.user = user
    }
    
    var nameText: String {
        return user.name
    }
    
    var usernameText: String {
        return user.username
    }

    var avatarURL: String {
        return user.avatarURL
    }
}
