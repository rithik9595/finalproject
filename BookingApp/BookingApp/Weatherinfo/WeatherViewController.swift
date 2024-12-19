//
//  WeatherViewController.swift
//  BookingApp
//
//  Created by FCI on 12/12/24.
//

import UIKit
import QuartzCore

// WeatherViewController handles the UI and actions for the weather screen
class WeatherViewController: UIViewController {
    
    // IBOutlet for displaying a location image (e.g., weather icon or map)
    @IBOutlet var dislocimg: UIImageView!
    
    // UIButton to display or select a specific location's weather
    @IBOutlet var statloc: UIButton!
    
    // UIButton to get the current user's location weather
    @IBOutlet var currloc: UIButton!
    
    // CALayer for styling the "statloc" button (specific location button)
    var statloc1: CALayer!
    
    // CALayer for styling the "currloc" button (current location button)
    var currloc1: CALayer!
    
    // Lifecycle method called after the view has been loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize the CALayer for the "statloc" button
        statloc1 = statloc.layer
        statloc1.cornerRadius = 12 // Set corner radius for rounded edges
  
        
        // Initialize the CALayer for the "currloc" button
        currloc1 = currloc.layer
        currloc1.cornerRadius = 12 // Set corner radius for rounded edges

    }
}
