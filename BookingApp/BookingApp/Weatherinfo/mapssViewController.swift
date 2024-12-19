//
//  mapssViewController.swift
//  BookingApp
//
//  Created by FCI on 13/12/24.
//

import UIKit
import MapKit
import QuartzCore

class mapssViewController: UIViewController {
    
    // MARK: - UI Elements
    var homeButton1 : UIBarButtonItem! // Button to navigate back to the home screen
    var infoshare1: CALayer! // Layer to customize the appearance of the share button
    
    // MARK: - Outlets for UI Elements
    @IBOutlet var mpvi2: MKMapView! // MapView to display location and map type
    @IBOutlet var cntr2: UISegmentedControl! // Segmented control to switch between map types
    @IBOutlet var infoshare: UIButton! // Button to share location and temperature information
    
    // MARK: - Variables to Store Data Passed from Previous Screen
    var lati1: String! // Latitude of the location
    var loni1: String! // Longitude of the location
    var tempi: String! // Temperature at the location
    var admi1: String! // Administrative area (e.g., state/region)
    var loci1: String! // Locality (e.g., city)
    var post1: String! // Postal code
    var nam1: String! // Name of the location
    var cout1: String! // Country of the location

    // MARK: - Lifecycle Method
    override func viewDidLoad() {
        super.viewDidLoad()

        // Customize the appearance of the share button
        infoshare1 = infoshare.layer
        infoshare1.cornerRadius = 12 // Round the corners of the button
        infoshare1.borderWidth = 1.5 // Set the border width for the button
        
        // Create and configure the home button
        homeButton1 = UIBarButtonItem(image: UIImage(systemName: "homekit"), style: .plain, target: self, action: #selector(homeButton1Click))
        self.navigationItem.rightBarButtonItem = homeButton1
        homeButton1.tintColor = .white // Set the color of the home button icon
        
        // Set the selected segment's color in the segmented control
        cntr2.selectedSegmentTintColor = UIColor(red: 0/255, green: 123/255, blue: 255/255, alpha: 1.0) // Primary Blue

        // Safely convert latitude and longitude from String to Double
        guard let lat = Double(lati1 ?? ""), let lon = Double(loni1 ?? "") else {
            // Show alert if coordinates are invalid
            let alert = UIAlertController(title: "Error", message: "Invalid coordinates. Unable to display location.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }

        // Create a CLLocationCoordinate2D object with the converted lat/lon values
        let staticLocation = CLLocationCoordinate2D(latitude: lat, longitude: lon)

        // Set the map's visible region
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) // Define the zoom level
        let region = MKCoordinateRegion(center: staticLocation, span: span)
        mpvi2.setRegion(region, animated: true) // Apply the region to the map

        // Add an annotation for the specified location
        let annotation = MKPointAnnotation()
        annotation.coordinate = staticLocation
        annotation.title = """
        Address:\(nam1!), \(admi1!), 
        \(loci1!), \(post1!), \(cout1!)"
        """ // Title with address details
        annotation.subtitle = "Temperature: \(tempi ?? "N/A")°C" // Subtitle with temperature
        mpvi2.addAnnotation(annotation) // Add annotation to the map
    }

    // MARK: - Action for Changing Map Type
    @IBAction func ClickNxtSeg(_ sender: UISegmentedControl) {
        // Update the map type based on the selected segment
        if cntr2.selectedSegmentIndex == 0 {
            mpvi2.mapType = .standard // Set map type to Standard
        } else if cntr2.selectedSegmentIndex == 1 {
            mpvi2.mapType = .satellite // Set map type to Satellite
        } else {
            mpvi2.mapType = .hybrid // Set map type to Hybrid (Satellite + Roads)
        }
    }
    
    // MARK: - Action for Sharing Location and Temperature
    @IBAction func ClickShare1(_ sender: UIButton) {
        // Prepare address details for sharing
        let AddressDetails = """
                             \(nam1 ?? "No Name"), \(admi1 ?? "No Administrative Area"), \(loci1 ?? "No Locality"), \(post1 ?? "No Postal Code"), \(cout1 ?? "No Country")
                             """
        // Prepare temperature details for sharing
        let TemperatureDetails = tempi ?? "No Temperature Found"

        // Create an array of items to share
        var shareAll: [Any] = []
        shareAll.append(AddressDetails) // Add address to the array
        shareAll.append(TemperatureDetails) // Add temperature to the array

        // Initialize UIActivityViewController for sharing
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // Set source view for popover
        self.present(activityViewController, animated: true) // Present the share sheet
    }

    // MARK: - Action for Home Button
    @objc func homeButton1Click() {
        // Navigate back to the root view controller
        self.navigationController?.popToRootViewController(animated: true)
    }
}
