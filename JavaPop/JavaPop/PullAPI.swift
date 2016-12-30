//
//  PullAPI.swift
//  JavaPop
//
//  Created by Cleber Santos on 12/30/16.
//  Copyright © 2016 Cleber Santos. All rights reserved.
//

import Foundation

class PullAPI {
    
    func getPulls(_ owner: String, _ repoName: String, callback: @escaping API.APICallback) {
        let pullEndpoint = "https://api.github.com/repos/\(owner)/\(repoName)/pulls?state=all"
        
        let api = API()
        api.callEndpoint(pullEndpoint) { (pullData, pullError) in
            var items = Array<(PullViewModel, UserViewModel)>()
            
            if let itemObjects = pullData as? JSONArray {
                for itemObject: AnyObject in itemObjects {
                    if let itemJSON = itemObject as? JSONDictionary {
                        
                        let pull = Pull.createFromJSON(itemJSON)
                        let pullViewModel = PullViewModel(pull: pull!)
                        
                        let user = User.createFromJSON(itemJSON["user"] as! Dictionary)
                        let userViewModel = UserViewModel(user: user!)
                        
                        items.append( (repo: pullViewModel, user: userViewModel) )
                    }
                }
            }
            
            callback(items as AnyObject?, nil)
        }
    }
}
