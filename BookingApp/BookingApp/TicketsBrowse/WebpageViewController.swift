import UIKit
import WebKit

class WebpageViewController: UIViewController {
    
    var homeButton1 : UIBarButtonItem!

    // Outlet for the WebView to display the webpage
    @IBOutlet var Displayurl: WKWebView!
    
    // URL to load in the WebView
    var url1: URL!
    
    // Boolean to determine if the URL should load in the WebView
    var loadInWebView: Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeButton1 = UIBarButtonItem(image: UIImage(systemName: "homekit"), style: .plain, target: self, action: #selector(homeButton1Click))
                self.navigationItem.rightBarButtonItem = homeButton1
                homeButton1.tintColor = .white
        
        // Ensure the URL is not nil and then load it in the WebView
        if let url = url1 {
            loadInWebView(url: url)
        }
    }
    
    // Function to load the given URL in the WebView
    func loadInWebView(url: URL) {
        // Check if the WebView is not already initialized
        if Displayurl == nil {
            // Initialize the WebView with the bounds of the current view
            Displayurl = WKWebView(frame: self.view.bounds)
            // Add the WebView as a subview to the main view
            self.view.addSubview(Displayurl)
        }
        // Load the URL in the WebView
        Displayurl.load(URLRequest(url: url))
    }
    

    @objc func homeButton1Click() {
                self.navigationController?.popToRootViewController(animated: true)
            }
    
}
