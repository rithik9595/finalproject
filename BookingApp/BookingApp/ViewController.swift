//
//  ViewController.swift
//  BookingApp
//
//  Created by FCI on 12/12/24.
//

import UIKit
import QuartzCore

// Define a class for the main view controller, inheriting from UIViewController
class ViewController: UIViewController {

    // Layer properties for ticket and climate buttons
    var ticketbtn1: CALayer!
    var climatebtn1: CALayer!
    
    // Outlet for an image view to display an image
    @IBOutlet var disimg: UIImageView!
    
    // Outlet for a button related to ticket functionality
    @IBOutlet var ticketbtn: UIButton!
    
    // Outlet for a button related to climate functionality
    @IBOutlet var climatebtn: UIButton!
    
    // Called after the controller's view is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Additional setup and initialization after the view is loaded
        
        // Configure the appearance of the ticket button
        ticketbtn1 = ticketbtn.layer
        ticketbtn1.cornerRadius = 12 // Round the corners of the button

        
        // Configure the appearance of the climate button
        climatebtn1 = climatebtn.layer
        climatebtn1.cornerRadius = 12 // Round the corners of the button

    }

}
