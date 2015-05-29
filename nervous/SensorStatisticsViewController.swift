import UIKit
import CoreMotion

class SensorStatisticsViewController : UIViewController {
    
    
    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //webView.removeFromSuperview()
        let url = NSBundle.mainBundle().URLForResource("Installation", withExtension: "html")

        let requestURL = NSURL(string: "http://www.google.com")
        let request = NSURLRequest(URL : requestURL!)
        webView.loadRequest(request)
    }

}