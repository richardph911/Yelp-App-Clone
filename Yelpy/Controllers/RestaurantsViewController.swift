//
//  ViewController.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit
import AlamofireImage
import Lottie
import SkeletonView

class RestaurantsViewController: UIViewController, UITableViewDelegate{

    
    
    // ––––– TODO: Add storyboard Items (i.e. tableView + Cell + configurations for Cell + cell outlets)
    // ––––– TODO: Next, place TableView outlet here
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    // –––––– TODO: Initialize restaurantsArray
    var restaurantsArray: [Restaurant] = []
    var filteredRestaurants: [Restaurant] = []
    
    // create a AnimationView
    var animationView: AnimationView?
    var refresh = true

    // ––––– TODO: Add tableView datasource + delegate
    override func viewDidLoad() {
        super.viewDidLoad()
        //Lab 4: Start animation
        startAnimations()

        animationView = .init(name: "animationName")
        animationView?.frame = view.bounds
        animationView?.play()
        
        let delayTime = DispatchTime.now() + 3.0
        DispatchQueue.main.asyncAfter(deadline: delayTime, execute: {
            self.stopAnimations()
           })
//        stopAnimations()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        getAPIData()
        

    }
    
    
    // ––––– TODO: Get data from API helper and retrieve restaurants
    func getAPIData(){
    
        API.getRestaurants(){ (restaurants) in
            guard let restaurants = restaurants else {
                return
            }
//            self.stopAnimations()
            print(restaurants)
            self.restaurantsArray = restaurants
            self.filteredRestaurants = restaurants
            self.tableView.reloadData() //reload data
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredRestaurants.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        
        cell.r = filteredRestaurants[indexPath.row]
        if self.refresh {
            cell.showAnimatedSkeleton()
        }else{
            cell.hideSkeleton()
        }
        
//        cell.nameLabel.text = restaurant["name"] as? String ?? ""
//        if let imageUrlString = restaurant["image_url"] as? String {
//            let imageUrl = URL(string: imageUrlString)
//            cell.restaurantImage.af.setImage(withURL: imageUrl!)
//        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let r = filteredRestaurants[indexPath.row]
            let detailViewController = segue.destination as! RestaurantDetailViewController
            detailViewController.r = r
        }
    }
    

}

// ––––– TODO: Create tableView Extension and TableView Functionality
extension RestaurantsViewController: UISearchBarDelegate {
    
    // Search bar functionality
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            filteredRestaurants = restaurantsArray.filter { (r: Restaurant) -> Bool in
                return r.name.lowercased().contains(searchText.lowercased())
            }
        }
        else {
            filteredRestaurants = restaurantsArray
        }
        tableView.reloadData()
    }
    
    
    // Show Cancel button when typing
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    // Logic for searchBar cancel button
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false // remove cancel button
        searchBar.text = "" // reset search text
        searchBar.resignFirstResponder() // remove keyboard
        filteredRestaurants = restaurantsArray // reset results to display
        tableView.reloadData()
    }
    
}

extension RestaurantsViewController: SkeletonTableViewDataSource{
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "RestaurantCell"
    }
    func startAnimations(){
        animationView = .init(name: "4762-food-carousel" )
        //set frame
        animationView!.frame = CGRect(x: view.frame.width / 3, y: 95, width: 100, height: 100)
        //fit animation
        animationView!.contentMode = .scaleAspectFit
        view.addSubview(animationView!)
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 5
        animationView!.play()
        view.showGradientSkeleton()
        
    }
    @objc func stopAnimations(){
        animationView?.stop()
//        view.hideSkeleton()
        view.subviews.last?.removeFromSuperview()
        view.hideSkeleton()
        refresh = false
    }
    
}




