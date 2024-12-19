//
//  currViewController.swift
//  BookingApp
//
//  Created by FCI on 13/12/24.
//

import UIKit
import CoreLocation
import QuartzCore

// Class declaration for the view controller, which handles UI interactions and location/weather data
class currViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: - Properties for UI Elements and Layers
    var homeButton1 : UIBarButtonItem! // Navigation bar button for returning to the home screen
    
    // Layers for styling UI elements
    var Latitude1: CALayer!
    var Longitude1: CALayer!
    var ReverseAdd1: CALayer!
    var Speed1: CALayer!
    var Tempera1: CALayer!
    var humi1: CALayer!
    var crrfetch1: CALayer!
    var wetherup1: CALayer!
    var nxtmap1: CALayer!
    
    // MARK: - Outlets for UI Elements
    @IBOutlet var Latitude: UILabel! // Label to display latitude
    @IBOutlet var Longitude: UILabel! // Label to display longitude
    @IBOutlet var ReverseAdd: UILabel! // Label to display reverse-geocoded address
    @IBOutlet var Speed: UILabel! // Label to display wind speed
    @IBOutlet var Tempera: UILabel! // Label to display temperature
    @IBOutlet var humi: UILabel! // Label to display humidity
    
    @IBOutlet var crrfetch: UIButton! // Button to fetch current location
    @IBOutlet var wetherup: UIButton! // Button to fetch weather details
    @IBOutlet var nxtmap: UIButton! // Button to navigate to the map view
    
    // MARK: - Variables to Store API Data
    var lat: String? // Latitude as a string
    var long: String? // Longitude as a string
    var temperaturevalue: String? // Temperature value as a string
    var administrativeArea1: String? // Administrative area from reverse geocoding
    var locality1: String? // Locality from reverse geocoding
    var name1: String? // Name from reverse geocoding
    var postalCode1: String? // Postal code from reverse geocoding
    var country1: String? // Country from reverse geocoding

    // MARK: - Location Manager
    var locationManager: CLLocationManager! // CLLocationManager instance to fetch location updates

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize navigation bar button for home
        homeButton1 = UIBarButtonItem(image: UIImage(systemName: "homekit"), style: .plain, target: self, action: #selector(homeButton1Click))
        self.navigationItem.rightBarButtonItem = homeButton1
        homeButton1.tintColor = .white
        
        // Request location access
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        
        // Initialize layers for UI elements and round their corners
        Latitude1 = Latitude.layer
        Latitude1.cornerRadius = 8
        
        Longitude1 = Longitude.layer
        Longitude1.cornerRadius = 8
        
        ReverseAdd1 = ReverseAdd.layer
        ReverseAdd1.cornerRadius = 8
        
        Speed1 = Speed.layer
        Speed1.cornerRadius = 8
        
        Tempera1 = Tempera.layer
        Tempera1.cornerRadius = 8
        
        humi1 = humi.layer
        humi1.cornerRadius = 8
        
        crrfetch1 = crrfetch.layer
        crrfetch1.cornerRadius = 12
        
        wetherup1 = wetherup.layer
        wetherup1.cornerRadius = 12
        
        nxtmap1 = nxtmap.layer
        nxtmap1.cornerRadius = 12
    }

    // MARK: - Fetch Latitude and Longitude
    @IBAction func ClickFetchLatLon(_ sender: UIButton) {
        // Check if location services are enabled
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation() // Start location updates
        } else {
            // Show alert if location services are disabled
            showAlert(title: "Enable Location", message: "Location services are not enabled. Please enable them in settings.")
        }
    }

    // MARK: - CLLocationManagerDelegate Method
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Get the last known location
        guard let location = locations.last else { return }

        let latValue = location.coordinate.latitude
        let longValue = location.coordinate.longitude

        // Convert latitude and longitude to strings
        lat = String(latValue)
        long = String(longValue)

        // Update UI with latitude and longitude
        DispatchQueue.main.async {
            self.Latitude.text = "Latitude: \(self.lat ?? "Unknown")"
            self.Longitude.text = "Longitude: \(self.long ?? "Unknown")"
        }

        // Perform reverse geocoding to get address
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Reverse geocoding failed: \(error.localizedDescription)")
                self.showAlert(title: "Error", message: "Unable to fetch address. Try again.")
                return
            }

            if let placemark = placemarks?.first {
                // Extract address components
                self.name1 = placemark.name ?? "Unknown"
                self.country1 = placemark.country ?? "Unknown"
                self.administrativeArea1 = placemark.administrativeArea ?? "Unknown"
                self.locality1 = placemark.locality ?? "Unknown"
                self.postalCode1 = placemark.postalCode ?? "Unknown"

                // Update UI with address
                DispatchQueue.main.async {
                    self.ReverseAdd.text = """
                    \(self.name1!), \(self.locality1!),
                    \(self.administrativeArea1!), \(self.postalCode1!),
                    \(self.country1!)
                    """
                }
            }
        }

        locationManager.stopUpdatingLocation() // Stop location updates to save battery
    }

    // MARK: - Fetch Weather Details
    @IBAction func ClickFetchDetails(_ sender: UIButton) {
        // Ensure latitude and longitude are available
        guard let lat = lat, let long = long else {
            showAlert(title: "Error", message: "Please fetch your current location first.")
            return
        }

        // Build URL for OpenWeatherMap API
        let session = URLSession.shared
        guard let webserviceURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&APPID=f31356634fbc4c64c86edd02aaf817c2&units=metric") else {
            showAlert(title: "Error", message: "Invalid URL.")
            return
        }

        // Make API call to fetch weather details
        let task = session.dataTask(with: webserviceURL) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: "Failed to fetch weather: \(error.localizedDescription)")
                }
                return
            }

            guard let data = data else { return }

            // Parse JSON response
            if let firstDictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
                if let mainData = firstDictionary.value(forKey: "main") as? NSDictionary {
                    // Extract temperature and update UI
                    if let temperature = mainData.value(forKey: "temp") as? Double {
                        DispatchQueue.main.async {
                            self.Tempera.text = "Temperature: \(temperature)°C"
                            self.temperaturevalue = "\(temperature)"
                        }
                    }
                    // Extract humidity and update UI
                    if let humidity = mainData.value(forKey: "humidity") as? Int {
                        DispatchQueue.main.async {
                            self.humi.text = "Humidity: \(humidity)%"
                        }
                    }
                }

                // Extract wind speed and update UI
                if let windData = firstDictionary.value(forKey: "wind") as? NSDictionary,
                   let speed = windData.value(forKey: "speed") as? Double {
                    DispatchQueue.main.async {
                        self.Speed.text = "WindSpeed: \(speed) m/s"
                    }
                }
            }
        }
        task.resume() // Start the API call
    }

    // MARK: - Show Maps Action
    @IBAction func showMaps(_ sender: UIButton) {
        // Add logic for showing maps here.
    }

    // MARK: - Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Pass location and weather data to the next screen
        if let nextScreen = segue.destination as? mapssViewController {
            nextScreen.title = locality1
            nextScreen.lati1 = lat
            nextScreen.loni1 = long
            nextScreen.admi1 = administrativeArea1
            nextScreen.loci1 = locality1
            nextScreen.post1 = postalCode1
            nextScreen.nam1 = name1
            nextScreen.cout1 = country1
            nextScreen.tempi = temperaturevalue
        }
    }

    // MARK: - Helper Method to Show Alerts
    func showAlert(title: String, message: String) {
        // Display an alert with a title and message
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    // MARK: - Home Button Action
    @objc func homeButton1Click() {
        // Navigate back to the root view controller
        self.navigationController?.popToRootViewController(animated: true)
    }
}
