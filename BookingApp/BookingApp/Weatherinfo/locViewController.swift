//
//  locViewController.swift
//  BookingApp
//
//  Created by FCI on 12/12/24.
//

import UIKit
import CoreLocation
import QuartzCore

class locViewController: UIViewController {
    
    // MARK: - Variables for UI Layers
    var homeButton1 : UIBarButtonItem!
    
    var txt1: CALayer! // Layer for txt TextField
    var lat1: CALayer! // Layer for latitude label
    var long1: CALayer! // Layer for longitude label
    var temp1: CALayer! // Layer for temperature label
    var hum1: CALayer! // Layer for humidity label
    var wind1: CALayer! // Layer for wind speed label
    var descript1: CALayer! // Layer for description label
    var details1: CALayer! // Layer for details label
    
    var Fetch1: CALayer! // Layer for Fetch button
    var nxt1: CALayer! // Layer for Next button
    
    // MARK: - Outlets for UI Elements
    @IBOutlet var txt: UITextField! // TextField to input city name
    @IBOutlet var lat: UILabel! // Label to display latitude
    @IBOutlet var long: UILabel! // Label to display longitude
    @IBOutlet var temp: UILabel! // Label to display temperature
    @IBOutlet var hum: UILabel! // Label to display humidity
    @IBOutlet var wind: UILabel! // Label to display wind speed
    @IBOutlet var descript: UILabel! // Label to display weather description
    @IBOutlet var details: UILabel! // Label to display location details
    
    @IBOutlet var Fetch: UIButton! // Button to fetch weather data
    @IBOutlet var nxt: UIButton! // Button to navigate to the next screen
    
    // MARK: - Variables to Store API Data
    var latValue: String? // Stores latitude
    var longValue: String? // Stores longitude
    var temperaturevalue: String? // Stores temperature
    var administrativeArea: String? // Stores administrative area (state/region)
    var locality: String? // Stores locality (city)
    var name: String? // Stores specific name of the place
    var postalCode: String? // Stores postal code
    var country: String? // Stores country name

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add a home button to the navigation bar
        homeButton1 = UIBarButtonItem(image: UIImage(systemName: "homekit"), style: .plain, target: self, action: #selector(homeButton1Click))
        self.navigationItem.rightBarButtonItem = homeButton1
        homeButton1.tintColor = .white // Set button color
        
        // Initialize layer properties for UI elements and round their corners
        txt1 = txt.layer
        txt1.cornerRadius = 8
        
        lat1 = lat.layer
        lat1.cornerRadius = 8
        
        long1 = long.layer
        long1.cornerRadius = 8
        
        temp1 = temp.layer
        temp1.cornerRadius = 8
        
        hum1 = hum.layer
        hum1.cornerRadius = 8
        
        wind1 = wind.layer
        wind1.cornerRadius = 8
        
        descript1 = descript.layer
        descript1.cornerRadius = 8
        
        details1 = details.layer
        details1.cornerRadius = 8
        
        Fetch1 = Fetch.layer
        Fetch1.cornerRadius = 12
        
        nxt1 = nxt.layer
        nxt1.cornerRadius = 12
    }
    
    // MARK: - Fetch Weather Data
    @IBAction func ClickToFetch(_ sender: UIButton) {
        // Validate if the city name is entered
        guard let cityName = txt.text, !cityName.isEmpty else {
            showAlert(title: "Error", message: "Please enter a city name.")
            return
        }
        
        // Prepare the URL for the API call
        let session1 = URLSession.shared
        let webserviceURL = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(cityName)&APPID=f31356634fbc4c64c86edd02aaf817c2&units=metric")!
        
        // Create a data task to fetch weather data
        let task1 = session1.dataTask(with: webserviceURL) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                // Show an alert if there's an error in the API call
                DispatchQueue.main.async {
                    self.showAlert(title: "Invalid URL", message: "Please enter a valid URL.")
                }
                return
            }
            else if let data1 = data {
                // Convert received data to a string (for debugging purposes)
                let dataString = String(data: data1, encoding: String.Encoding.utf8)
                
                // Parse JSON data
                if let firstDictionary = try? JSONSerialization.jsonObject(with: data1, options: .allowFragments) as? NSDictionary {
                    
                    // Extract main weather details
                    if let secondDictionary = firstDictionary.value(forKey: "main") as? NSDictionary {
                        // Get temperature
                        if let temperaturevalue = secondDictionary.value(forKey: "temp") {
                            DispatchQueue.main.async {
                                self.temp.text = "Temperature: \(temperaturevalue)°C"
                                self.temperaturevalue = "\(temperaturevalue)"
                            }
                        }
                        
                        // Get humidity
                        if let humidityValue = secondDictionary.value(forKey: "humidity") {
                            DispatchQueue.main.async {
                                self.hum.text = "Humidity: \(humidityValue)%"
                            }
                        }
                    }
                    
                    // Extract coordinates
                    if let thirdDictionary = firstDictionary.value(forKey: "coord") as? NSDictionary {
                        // Get latitude
                        if let latValue = thirdDictionary.value(forKey: "lat") {
                            DispatchQueue.main.async {
                                self.lat.text = "Latitude: \(latValue)"
                                self.latValue = "\(latValue)"
                            }
                        }
                        
                        // Get longitude
                        if let longValue = thirdDictionary.value(forKey: "lon") {
                            DispatchQueue.main.async {
                                self.long.text = "Longitude: \(longValue)"
                                self.longValue = "\(longValue)"
                            }
                        }
                        
                        // Perform reverse geocoding to get detailed location information
                        if let latValue = thirdDictionary.value(forKey: "lat") as? Double,
                           let lonValue = thirdDictionary.value(forKey: "lon") as? Double {
                            let location = CLLocation(latitude: latValue, longitude: lonValue)
                            CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
                                if error != nil {
                                    DispatchQueue.main.async {
                                        self.showAlert(title: "Geocoding error", message: "Invalid Details.")
                                    }
                                    return
                                } else if let placemark = placemarks?.first {
                                    DispatchQueue.main.async {
                                        // Extract details from placemark
                                        self.name = placemark.name ?? "Unknown"
                                        self.country = placemark.country ?? "Unknown"
                                        self.administrativeArea = placemark.administrativeArea ?? "Unknown"
                                        self.locality = placemark.locality ?? "Unknown"
                                        self.postalCode = placemark.postalCode ?? "Unknown"
                                        
                                        // Display location details
                                        self.details.text = """
                                            \(self.name ?? "Unknown"), \(self.country ?? "Unknown")
                                            \(self.administrativeArea ?? "Unknown"), \(self.locality ?? "Unknown"), \(self.postalCode ?? "Unknown")
                                            """
                                    }
                                }
                            }
                        }
                    }
                    
                    // Extract wind details
                    if let fourthDictionary = firstDictionary.value(forKey: "wind") as? NSDictionary {
                        // Get wind speed
                        if let speedvalue = fourthDictionary.value(forKey: "speed") {
                            DispatchQueue.main.async {
                                self.wind.text = "WindSpeed: \(speedvalue)m/s"
                            }
                        }
                    }
                    
                    // Extract weather description
                    if let weatherArray = firstDictionary.value(forKey: "weather") as? NSArray,
                       let firstWeather = weatherArray.firstObject as? NSDictionary,
                       let descriptValue = firstWeather.value(forKey: "description") as? String {
                        DispatchQueue.main.async {
                            self.descript.text = "Description: \(descriptValue)"
                        }
                    }
                }
            }
        }
        task1.resume()
    }
    
    // MARK: - Navigate to Next Screen
    @IBAction func ClickToNext(_ sender: UIButton) {
        // Ensure city name is entered before navigating
        guard let cityName = txt.text, !cityName.isEmpty else {
            showAlert(title: "Error", message: "Please enter a city name.")
            return
        }
    }
    
    // Prepare data for the next screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextScreen = segue.destination as! mapsViewController
        nextScreen.title = txt.text // Pass city name to the next screen
        nextScreen.lati = latValue
        nextScreen.loni = longValue
        nextScreen.tempi = temperaturevalue
        nextScreen.admi = administrativeArea
        nextScreen.loci = locality
        nextScreen.post = postalCode
        nextScreen.nam = name
        nextScreen.cout = country
    }
    
    // MARK: - Helper Method to Show Alert
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    @objc func homeButton1Click() {
        // Navigate back to the root view controller
        self.navigationController?.popToRootViewController(animated: true)
    }
}
