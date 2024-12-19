//
//  ViewController.swift
//  navigation
//
//  Created by FCI on 16/12/24.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet var start: UITextField!
    @IBOutlet var stop: UITextField!
    @IBOutlet var Fetch: UIButton!
    @IBOutlet var map: UIButton!

    var startlat: String?
    var startlon: String?
    var stoplat: String?
    var stoplon: String?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func ClickFetch(_ sender: UIButton) {
        guard let startpoint = start.text, !startpoint.isEmpty,
              let stoppoint = stop.text, !stoppoint.isEmpty else {
            showAlert(title: "ERROR", message: "Please enter both start and stop locations.")
            return
        }

        // Geocode the start location
        CLGeocoder().geocodeAddressString(startpoint) { [weak self] placemarks, error in
            guard let self = self else { return }
            if let error = error {
                self.showAlert(title: "Geocoding Error", message: error.localizedDescription)
                return
            }
            if let placemark = placemarks?.first,
               let location = placemark.location {
                self.startlat = String(format: "%.04f", location.coordinate.latitude)
                self.startlon = String(format: "%.04f", location.coordinate.longitude)
            } else {
                self.showAlert(title: "Error", message: "Unable to fetch coordinates for the start location.")
            }
        }

        // Geocode the stop location
        CLGeocoder().geocodeAddressString(stoppoint) { [weak self] placemarks, error in
            guard let self = self else { return }
            if let error = error {
                self.showAlert(title: "Geocoding Error", message: error.localizedDescription)
                return
            }
            if let placemark = placemarks?.first,
               let location = placemark.location {
                self.stoplat = String(format: "%.04f", location.coordinate.latitude)
                self.stoplon = String(format: "%.04f", location.coordinate.longitude)
            } else {
                self.showAlert(title: "Error", message: "Unable to fetch coordinates for the stop location.")
            }
        }
    }

    @IBAction func ClickMap(_ sender: UIButton) {
        if startlat == nil || startlon == nil || stoplat == nil || stoplon == nil {
            showAlert(title: "Error", message: "Please fetch the coordinates before proceeding to the map.")
        } else {
            // Trigger the segue
            performSegue(withIdentifier: "showMap", sender: nil)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Check the segue identifier and pass the data
        if segue.identifier == "showMap",
           let nextScreen = segue.destination as? nxtViewController {
            nextScreen.inlat = startlat
            nextScreen.inlon = startlon
            nextScreen.outlat = stoplat
            nextScreen.outlon = stoplon
        }
    }


    

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
