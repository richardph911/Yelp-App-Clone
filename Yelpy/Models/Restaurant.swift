//
//  Restaurant.swift
//  Yelpy
//
//  Created by Richard Pham on 2/11/21.
//  Copyright © 2021 memo. All rights reserved.
//

import Foundation
class Restaurant{
    var imageURL: URL?
    var url: URL?
    var name: String
    var mainCategory: String
    var phone: String
    var rating: Double
    var reviews: Int
    //Lab 6 Refactor restaurant model
    var coordinates: [String: Double]
    
    
    init(dict: [String: Any]){
        imageURL = URL(string: dict["image_url"] as! String)
        name = dict["name"] as! String
        rating = dict["rating"] as! Double
        reviews = dict["review_count"] as! Int
        phone = dict["display_phone"] as! String
        url = URL(string: dict["url"] as! String)
        mainCategory = Restaurant.getMainCategory(dict: dict)
        coordinates = dict["coordinates"] as! [String:Double]
        


        
    }
    static func getMainCategory(dict: [String: Any]) -> String {
        let categories = dict["categories"] as! [[String: Any]]
        return categories[0]["title"] as! String
    }
    
}
