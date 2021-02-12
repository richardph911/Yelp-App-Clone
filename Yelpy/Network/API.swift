//
//  File.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import Foundation


struct API {
    

    
    static func getRestaurants(completion: @escaping ([[String:Any]]?) -> Void) {
        
        // ––––– TODO: Add your own API key!
        let apikey = "qfXWO9lvBWHN4STbvue2w5ntDtxyysPiwoH-fab-VjGIhvijY0dbpgZlgDLntemrGYGLsWo6ygcmMu9TwPUnAE66-FSOvxW0PO_0d8AF0XFoVUNg98KXjw5h0aIdYHYx"
        
        // Coordinates for San Francisco
        let lat = 37.773972
        let long = -122.431297
        
        
        let url = URL(string: "https://api.yelp.com/v3/transactions/delivery/search?latitude=\(lat)&longitude=\(long)")!
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        // Insert API Key to request
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                print("hello")
//                print(data)
                //convert json res to a dict
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as! [String:Any]
                //grab businesses data and convert to an array of dictionaries for each restaurant
                let restaurants = dataDictionary["businesses"] as! [[String: Any]]
//                print(restaurants)
                // ––––– TODO: Get data from API and return it using completion
                return completion(restaurants)
                }
            }
        
            task.resume()
        
        }
    }

    
