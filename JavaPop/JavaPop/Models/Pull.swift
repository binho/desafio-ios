//
//  Pull.swift
//  JavaPop
//
//  Created by Cleber Santos on 12/30/16.
//  Copyright © 2016 Cleber Santos. All rights reserved.
//

import Foundation

enum State: String {
    case open = "open"
    case closed = "closed"
}

class Pull {
    var title: String
    var description: String
    var state: State
    
    init(title: String, description: String, state: State) {
        self.title = title
        self.description = description
        self.state = state
    }
    
    class func createFromJSON(_ pullDict: Dictionary<String, AnyObject>) -> Pull! {

        if let title = pullDict["title"] as? String,
            let description = pullDict["body"] as? String,
            let stateString = pullDict["state"] as? String {

            return Pull(title: title, description: description, state: State(rawValue: stateString)!)
        }
        
        return nil
    }
}

class PullViewModel {
    private(set) var pull: Pull
    
    init(pull: Pull) {
        self.pull = pull
    }
    
    var state: State {
        return pull.state
    }
    
    var titleText: String {
        return pull.title
    }
    
    var descriptionText: String {
        return pull.description
    }
}
