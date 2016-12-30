//
//  RepoClient.swift
//  JavaPop
//
//  Created by Cleber Santos on 12/29/16.
//  Copyright © 2016 Cleber Santos. All rights reserved.
//

import Foundation

class RepoAPI {
    
    func getRepos(page: Int, callback: @escaping API.APICallback) {
        let idealPage = (page > 0 ? page : 1)
        let repoEndpoint = "https://api.github.com/search/repositories?q=language:Java&sort=stars&page=\(idealPage)"
        
        let api = API()
        api.callEndpoint(repoEndpoint) { (repoData, repoError) in
            var items = Array<(RepoViewModel, UserViewModel)>()
            
            if let itemObjects = repoData?["items"] as? JSONArray {
                for itemObject: AnyObject in itemObjects {
                    if let itemJSON = itemObject as? JSONDictionary {
                        
                        if let repo = Repo.createFromJSON(itemJSON) {
                            let repoViewModel = RepoViewModel(repo: repo)
                            
                            if let user = User.createFromJSON(itemJSON["owner"] as! Dictionary) {
                                let userViewModel = UserViewModel(user: user)
                                
                                items.append( (repo: repoViewModel, user: userViewModel) )
                            }
                        }
                    }
                }
            }
            
            callback(items as AnyObject?, nil)
        }
    }
}
