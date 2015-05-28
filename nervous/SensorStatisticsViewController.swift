import UIKit
import CoreMotion

class SensorStatisticsViewController : UIViewController {
    
    
    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.removeFromSuperview()
        
        let requestURL = NSURL(string: "http://www.facebook.com")
        let request = NSURLRequest(URL : requestURL!)
        webView.loadRequest(request)
    }

}