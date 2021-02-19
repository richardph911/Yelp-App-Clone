//
//  RestaurantDetailViewController.swift
//  Yelpy
//
//  Created by Richard Pham on 2/11/21.
//  Copyright © 2021 memo. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {

    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var headerImage: UIImageView!
    var r: Restaurant!
    override func viewDidLoad() {
        super.viewDidLoad()
        headerImage.af.setImage(withURL: r.imageURL!)

        // Do any additional setup after loading the view.
        nameLabel.text = r.name
        reviewsLabel.text = String(r.reviews)
        starImage.image = Stars.dict[r.rating]!
        // Extra: Add tint opacity to image to make text stand out
        let tintView = UIView()
        tintView.backgroundColor = UIColor(white: 0, alpha: 0.3) //change to your liking
        tintView.frame = CGRect(x: 0, y: 0, width: headerImage.frame.width, height: headerImage.frame.height)

        headerImage.addSubview(tintView)
        
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
