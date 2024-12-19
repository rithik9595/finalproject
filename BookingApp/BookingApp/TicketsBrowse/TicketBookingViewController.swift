//
//  TicketBookingViewController.swift
//  BookingApp
//
//  Created by FCI on 12/12/24.
//

import UIKit
import SafariServices
import QuartzCore

// TicketBookingViewController class handles the ticket booking functionality
class TicketBookingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {



    
    // MARK: - Variables

    // Arrays for Flights, Trains, Buses, and MovieTickets
    var Flight: [String] = []
    var Fightimg: [String] = []
    var Flighturl: [String] = []
    
    var Train: [String] = []
    var Trainimg: [String] = []
    var Trainurl: [String] = []
    
    var Bus: [String] = []
    var Busimg: [String] = []
    var Busurl: [String] = []
    
    var MovieTickets: [String] = []
    var Movieimg: [String] = []
    var Movieurl: [String] = []
    
    var nxtbtn1: CALayer!
    
    // MARK: - Outlets

    // Table view for displaying various booking options
    @IBOutlet var distable: UITableView!
    
    // Image view to display selected booking option image
    @IBOutlet var disimg: UIImageView!
    
    
    // Labels to display selected site name and URL
    @IBOutlet var sitename: UILabel!
    @IBOutlet var siteurl: UILabel!
    
    // Button for displaying image and label
    @IBOutlet var nxtbtn: UIButton!
    
    // Store the selected URL
     var selectedUrl: String!
    
    // Store the selected name
    var selectedname: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Initializing data for Flights, Trains, Buses, and MovieTickets
        
        Flight = ["MakeMyTrip","Goibibo","Skyscanner"]
        Fightimg = ["makemytrip","goibibo","skyscanner"]
        Flighturl = ["https://www.makemytrip.com","https://www.goibibo.com​","https://www.skyscanner.net"]
        
        Train = ["MakeMyTrip","IRCTC","Paytm"]
        Trainimg = ["trip","irtc","paytm"]
        Trainurl = ["https://www.makemytrip.com","https://www.irctc.co.in","https://www.paytm.com/train"]
        
        Bus = ["FlixBus","Greyhound","redBus"]
        Busimg = ["flixbus","greyhound","redbus"]
        Busurl = ["https://www.flixbus.com","https://www.greyhound.com","https://www.redbus.in"]
        
        MovieTickets = ["BookMyShow","Paytm Movies","PVR Cinemas"]
        Movieimg = ["show","paymovie","pvr"]
        Movieurl = ["https://in.bookmyshow.com","https://www.paytm.com/movies","https://www.pvrcinemas.com"]
       
        // Setting the delegate and data
        distable.delegate = self
        distable.dataSource = self
        
        nxtbtn1 = nxtbtn.layer
        nxtbtn1.cornerRadius = 12 // Round the corners of the button

    }
   
    //tableview Protocol Methods Implementations here
    
    // MARK: - Table View Methods
    //tableview Protocol Methods Implementations here
    
    // Number of sections in the table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    

    // Number of rows in each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return Flight.count
            
        }
        else if section == 1 {
            return Train.count
        }
        else if section == 2 {
            return Bus.count
        }else{
            return MovieTickets.count
        }
    }
    
    
    
    // Configure and display information in cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "id1", for: indexPath)
            
            cell1.textLabel?.text = Flight[indexPath.row]
            cell1.textLabel?.text = Flight[indexPath.row]
            cell1.imageView?.image = UIImage(named: Flight[indexPath.row])
            cell1.accessoryType = .detailDisclosureButton
            
            return cell1
        }
        else if indexPath.section == 1 {
            
            
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "id1", for: indexPath)
            
            cell2.textLabel?.text = Train[indexPath.row]
            cell2.textLabel?.text = Train[indexPath.row]
            cell2.imageView?.image = UIImage(named: Train[indexPath.row])
            cell2.accessoryType = .detailDisclosureButton
            
            return cell2
            
        }
        else if indexPath.section == 2 {
            
            
            let cell3 = tableView.dequeueReusableCell(withIdentifier: "id1", for: indexPath)
            
            cell3.textLabel?.text = Bus[indexPath.row]
            cell3.textLabel?.text = Bus[indexPath.row]
            cell3.imageView?.image = UIImage(named: Bus[indexPath.row])
            cell3.accessoryType = .detailDisclosureButton
            
            return cell3
            
        }else {
            
            
            let cell4 = tableView.dequeueReusableCell(withIdentifier: "id1", for: indexPath)
            
            cell4.textLabel?.text = MovieTickets[indexPath.row]
            cell4.textLabel?.text = MovieTickets[indexPath.row]
            cell4.imageView?.image = UIImage(named: MovieTickets[indexPath.row])
            cell4.accessoryType = .detailDisclosureButton
            
            return cell4
            
        }
        
        
    }
    
    // Section Header Title
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            
            return "Flight"
        }
        else if section == 1 {
            return "Train"
        }
        else if section == 2 {
            return "Bus"
        }
        else {
            return "MovieTickets"
        }
    }
    
    
    
    //Section Footer Title
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        
        if section == 0 {
            
            return "Flight End"
        }
        else if section == 1 {
            return "Train End"
        }
        else if section == 2 {
            return "Bus End"
        }
        else {
            return "MovieTickets End"
        }

    }
    
    // Handle row selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            
            sitename.text = Flight[indexPath.row]
            siteurl.text = Flighturl[indexPath.row]
            disimg.image = UIImage(named: Fightimg[indexPath.row])
            selectedUrl = Flighturl[indexPath.row]
            selectedname = Flight[indexPath.row]
        }
        else if indexPath.section == 1 {
            
            sitename.text = Train[indexPath.row]
            siteurl.text = Trainurl[indexPath.row]
            disimg.image = UIImage(named: Trainimg[indexPath.row])
            selectedUrl = Trainurl[indexPath.row]
            selectedname = Train[indexPath.row]
            
        }
        else if indexPath.section == 2 {
            
            sitename.text = Bus[indexPath.row]
            siteurl.text = Busurl[indexPath.row]
            disimg.image = UIImage(named: Busimg[indexPath.row])
            selectedUrl = Busurl[indexPath.row]
            selectedname = Bus[indexPath.row]
            
        }
        else if indexPath.section == 3 {
            
            sitename.text = MovieTickets[indexPath.row]
            siteurl.text = Movieurl[indexPath.row]
            disimg.image = UIImage(named: Movieimg[indexPath.row])
            selectedUrl = Movieurl[indexPath.row]
            selectedname = MovieTickets[indexPath.row]
        }
        
    }
    
    //when user select any accesory detail buton
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        
        if indexPath.section == 0{
            
            sitename.text = Flight[indexPath.row]
            siteurl.text = Flighturl[indexPath.row]
            disimg.image = UIImage(named: Fightimg[indexPath.row])
        }
        else if indexPath.section == 1 {
            
            sitename.text = Train[indexPath.row]
            siteurl.text = Trainurl[indexPath.row]
            disimg.image = UIImage(named: Trainimg[indexPath.row])
            
        }
        else if indexPath.section == 2 {
            
            sitename.text = Bus[indexPath.row]
            siteurl.text = Busurl[indexPath.row]
            disimg.image = UIImage(named: Busimg[indexPath.row])
            
        }
        else if indexPath.section == 3 {
            
            sitename.text = MovieTickets[indexPath.row]
            siteurl.text = Movieurl[indexPath.row]
            disimg.image = UIImage(named: Movieimg[indexPath.row])
            
        }
   
    }
    
    //section index titles
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        
        let indexTitles = ["Flight","Train","Bus","MovieTickets"]
        return indexTitles
    }
    
    
    
    
    // MARK: - Button Actions

    // Handle next button click
    
    @IBAction func clickNxt(_ sender: UIButton) {
        // Show Alert if no URL is selected
        guard let url = selectedUrl else {
            showAlert(message: "The URL is invalid or missing.")
            return
        }
        
        // Action sheet for browser selection
        let alert = UIAlertController(title: "Browsers", message: "Please Select Any Option", preferredStyle: .actionSheet)
        
        //Open URL in Webkit
        alert.addAction(UIAlertAction(title: "Webkit", style: .default, handler: { _ in
            
            let nextScreen = WebpageViewController()
            let validURL = URL(string: self.selectedUrl )
            nextScreen.title = self.selectedname
            nextScreen.url1 = validURL
            nextScreen.loadInWebView = true
            self.navigationController?.pushViewController(nextScreen, animated: true)


        }))
        
        alert.addAction(UIAlertAction(title: "Safari", style: .default, handler: { _ in
           self.openURLWithSafari(url: url)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }

    // Function To Open URL in Safari
   func openURLWithSafari(url: String) {
        if let url = URL(string: url) {
            let safariVC = SFSafariViewController(url: url)
            self.present(safariVC, animated: true, completion: nil)
        }
    }
    

    //Alert Message if None of the row is selected
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    // MARK: - Animations

    // Animate table view rows
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateTable()
    }

    func animateTable() {
        distable.reloadData()
        let cells = distable.visibleCells
        let tableHeight: CGFloat = distable.bounds.size.height
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        for cell in cells {
            UIView.animate(withDuration: 1.5, delay: 0.09 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .allowAnimatedContent, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            index += 1
        }
    }
}


