//
//  mapsViewController.swift
//  BookingApp
//
//  Created by FCI on 12/12/24.
//

import UIKit
import MapKit
import QuartzCore

class mapsViewController: UIViewController {
    
    // MARK: - UI Components
    var homeButton1 : UIBarButtonItem! // Home button to navigate back to the root view controller
    var infoshare: CALayer! // Layer for customizing the appearance of the share button
    
    // MARK: - Outlets for UI Elements
    @IBOutlet var mpvi1: MKMapView! // MapView to display location and map type
    @IBOutlet var cntrl: UISegmentedControl! // Segmented control to switch between map types
    @IBOutlet var infoshare1: UIButton! // Button to share location and temperature details
    
    // MARK: - Variables to Store Data Passed from Previous Screen
    var lati: String! // Latitude of the location
    var loni: String! // Longitude of the location
    var tempi: String! // Temperature at the location
    var admi: String! // Administrative area (e.g., state/region)
    var loci: String! // Locality (e.g., city)
    var post: String! // Postal code
    var nam: String! // Name of the location
    var cout: String! // Country of the location
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Customize Share Button Appearance
        infoshare = infoshare1.layer
        infoshare.cornerRadius = 12 // Round the corners of the button
        infoshare.borderWidth = 1.5 // Set the border width for the button
        
        // MARK: - Add Home Button to Navigation Bar
        homeButton1 = UIBarButtonItem(image: UIImage(systemName: "homekit"), style: .plain, target: self, action: #selector(homeButton1Click))
        self.navigationItem.rightBarButtonItem = homeButton1
        homeButton1.tintColor = .white // Set the button's color to white
        
        // MARK: - Configure Map View with Location Details
        // Convert latitude and longitude strings to a CLLocationCoordinate2D object
        let staticLocation = CLLocationCoordinate2D(
            latitude: Double(lati ?? "") ?? 0.0,
            longitude: Double(loni ?? "") ?? 0.0
        )
        
        // Define a small region span for the map view
        let span1 = MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)
        
        // Create a region centered on the given coordinates
        let region1 = MKCoordinateRegion(center: staticLocation, span: span1)
        
        // Set the defined region in the map view
        mpvi1.setRegion(region1, animated: true)
        
        // MARK: - Adding Annotations to the Map
        let annotation = MKPointAnnotation()
        annotation.coordinate = staticLocation // Set annotation's coordinates
        annotation.title = """
        Address:\(nam!), \(admi!), \(loci!),
        \(post!), \(cout!)
        """ // Annotation title with address details
        annotation.subtitle = "Temperature: \(tempi!)°C" // Annotation subtitle with temperature
        mpvi1.addAnnotation(annotation) // Add the annotation to the map view
    }
    
    // MARK: - Action for Changing Map Type
    @IBAction func ClickNxt(_ sender: UISegmentedControl) {
        // Update the map type based on the selected segment
        if cntrl.selectedSegmentIndex == 0 {
            mpvi1.mapType = .standard // Standard map type
        } else if cntrl.selectedSegmentIndex == 1 {
            mpvi1.mapType = .satellite // Satellite map type
        } else {
            mpvi1.mapType = .hybrid // Hybrid map type (satellite + roads)
        }
    }
    
    // MARK: - Action for Sharing Information
    @IBAction func Clickshare(_ sender: UIButton) {
        // Prepare address details as a formatted string
        let AddressDetails = """
                             \(nam ?? "No Name"), \(admi ?? "No Administrative Area"), \(loci ?? "No Locality"), \(post ?? "No Postal Code"), \(cout ?? "No Country")
                             """
        
        // Prepare temperature details as a string
        let TemperatureDetails = tempi ?? "No Temperature Found"
        
        // Create an array of items to share
        var shareAll: [Any] = []
        shareAll.append(AddressDetails)
        shareAll.append(TemperatureDetails)
        
        // Initialize the UIActivityViewController with shareable items
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // Set the source view for iPad popover
        self.present(activityViewController, animated: true) // Present the activity view controller
    }
    
    // MARK: - Action for Navigating to Home Screen
    @objc func homeButton1Click() {
        self.navigationController?.popToRootViewController(animated: true) // Pop to root view controller
    }
}
