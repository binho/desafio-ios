//
//  Dictionary+Helper.swift
//  JavaPop
//
//  Created by Cleber Santos on 12/29/16.
//  Copyright © 2016 Cleber Santos. All rights reserved.
//

import Foundation

extension Dictionary where Key: CustomDebugStringConvertible, Value:CustomDebugStringConvertible {
    func prettyPrint() {
        for (key, value) in self {
            print("\(key) = \(value)")
        }
    }
}
