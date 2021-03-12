//
//  RestaurantDetailViewController.swift
//  Yelpy
//
//  Created by Richard Pham on 2/11/21.
//  Copyright © 2021 memo. All rights reserved.
//

import UIKit
import Alamofire
import MapKit

class RestaurantDetailViewController: UIViewController, MKMapViewDelegate{

    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var headerImage: UIImageView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var MKMapView: MKMapView!
    
    var annotationView: MKAnnotationView!
    
    var r: Restaurant!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureOutlets()
        mapView.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    // Add image to MapView Annotation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPostImageVC" {
            let postImageVC = segue.destination as! PostImageViewController
            // NOTE: PLEASE FOLLOW LAB BEFORE ASKING FOR HELP ON THIS
//            postImageVC.delegate = self
        }
    }
    
    func configureOutlets(){
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
        
        // MARK: Lab 6 set region for map to be coordinates of restaurant
        // 1) get longitude and latitude from coordinates property
        let latitude = r.coordinates["latitude"]!
        let longitude = r.coordinates["longitude"]!
        // test coordinates are being printed
        print("COORDS: \(latitude), \(longitude)")
        // 2) initialize coordinate point for restaurant
        let locationCoordinate = CLLocationCoordinate2DMake(CLLocationDegrees.init(latitude), CLLocationDegrees.init(longitude))
        // 3) initialize region object using restaurant's coordinates
        let restaurantRegion = MKCoordinateRegion(center: CLLocationCoordinate2DMake(latitude, longitude), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        // 4) set region in mapView to be that of restaurants
        mapView.setRegion(restaurantRegion, animated: true)
        
        // 5) instantiate annotation object to show pin on map
        let annotation = MKPointAnnotation()
        
        // 6) set annotation's properties
        annotation.coordinate = locationCoordinate
        annotation.title = r.name
        
        // 7) drop pin on map using restaurant's coordinates
        mapView.addAnnotation(annotation)
                
                   
        
    }
    
    // MARK: 8) Configure annotation view using protocol method
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        return mapView.dequeueReusableAnnotationView(withIdentifier: "removeMe")
        
    }
    
    // MARK: 12) action to execute when user taps annotation views accessory buttons
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        // 14) performSegue to PostImageVC
        
    }
    
    
    
    // MARK: 19) Conform to PostImageViewDelegate protocol
    func imageSelected(controller: PostImageViewController, image: UIImage) {
        // 9) Add info button to annotation view

    }
    
    
    
    // Unwind segue after user finishes uploading image for map annotation
    @IBAction func unwind(_ seg: UIStoryboardSegue) {
        
    }

}
