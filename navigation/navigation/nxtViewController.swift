//
//  nxtViewController.swift
//  navigation
//
//  Created by FCI on 16/12/24.
//

import UIKit
import MapKit
import CoreLocation

class nxtViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var mv: MKMapView!
    var inlat: String!
    var inlon: String!
    var outlat: String!
    var outlon: String!
    @IBOutlet var segcntrl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mv.delegate = self
        
        // Validate latitude and longitude
        guard let startLat = Double(inlat), let startLon = Double(inlon),
              let endLat = Double(outlat), let endLon = Double(outlon) else {
            print("Invalid latitude or longitude values")
            return
        }
        
        addPins(startCoordinate: CLLocationCoordinate2D(latitude: startLat, longitude: startLon),
                endCoordinate: CLLocationCoordinate2D(latitude: endLat, longitude: endLon))
        
        showRouteOnMap(pickupCoordinate: CLLocationCoordinate2D(latitude: startLat, longitude: startLon),
                       destinationCoordinate: CLLocationCoordinate2D(latitude: endLat, longitude: endLon))
    }
    
    func addPins(startCoordinate: CLLocationCoordinate2D, endCoordinate: CLLocationCoordinate2D) {
        let startPin = MKPointAnnotation()
        startPin.title = "start"
        startPin.coordinate = startCoordinate
        mv.addAnnotation(startPin)
        
        let endPin = MKPointAnnotation()
        endPin.title = "end"
        endPin.coordinate = endCoordinate
        mv.addAnnotation(endPin)
    }
    
    @IBAction func ClickNxtMv(_ sender: UISegmentedControl) {
        switch segcntrl.selectedSegmentIndex {
        case 0:
            mv.mapType = .standard
        case 1:
            mv.mapType = .satellite
        default:
            mv.mapType = .hybrid
        }
    }
    
    func showRouteOnMap(pickupCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {
        let sourcePlacemark = MKPlacemark(coordinate: pickupCoordinate)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: sourcePlacemark)
        directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
        directionRequest.transportType = .automobile // Specify transport type
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { response, error in
            guard let response = response else {
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
                return
            }
            
            let route = response.routes[0]
            self.mv.addOverlay(route.polyline, level: .aboveRoads)
            let rect = route.polyline.boundingMapRect
            self.mv.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom") ??
                             MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
        annotationView.annotation = annotation
        
        // Assign correct images
       /* if annotation.title == "start" {
            annotationView.image = UIImage(named: "start")
        } else if annotation.title == "end" {
            annotationView.image = UIImage(named: "stop")
        }*/
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor(red: 17.0/255.0, green: 147.0/255.0, blue: 255.0/255.0, alpha: 1)
        renderer.lineWidth = 5.0
        return renderer
    }
}
