//
//  APIClient.swift
//  JavaPop
//
//  Created by Cleber Santos on 12/29/16.
//  Copyright © 2016 Cleber Santos. All rights reserved.
//

import Foundation

typealias JSONDictionary = Dictionary<String, AnyObject>
typealias JSONArray = Array<AnyObject>

class API: NSObject {

    typealias APICallback = ((AnyObject?, NSError?) -> ())
        
    func callEndpoint(_ endpoint: String, callback: @escaping APICallback) {
        guard let url = URL(string: endpoint) else {
            print("Error: cannot create URL from provided endpoint")
            callback(nil, nil)
            return
        }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let urlRequest = URLRequest(url: url)
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            /* debug
            if let data = data {
                print(String(data: data, encoding: .utf8) ?? "NO DATA")
            }
            
            if let response = response {
                print(response)
            }*/

            guard error == nil else {
                print(error!)
                callback(nil, error as NSError?)
                return
            }

            guard let responseData = data else {
                print("Error: did not receive data")
                callback(nil, error as NSError?)
                return
            }

            do {
                guard let jsonReponse = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as Any? else {
                    print("Error trying to convert data to JSON")
                    return
                }
                
                callback(jsonReponse as AnyObject?, nil)
            } catch  {
                print("Failed to serialize data to JSON")
                callback(nil, error as NSError?)
                return
            }
        }
        
        task.resume()
    }

}
