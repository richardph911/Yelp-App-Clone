//
//  RestaurantDetailViewController.swift
//  Yelpy
//
//  Created by Richard Pham on 2/11/21.
//  Copyright © 2021 memo. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {

    @IBOutlet weak var restaurantImage: UIImageView!
    var r: Restaurant!
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantImage.af.setImage(withURL: r.imageURL!)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
