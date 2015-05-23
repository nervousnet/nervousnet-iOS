import UIKit
import CoreMotion

class SensorStatisticsViewController : UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    var urlpath = NSBundle.mainBundle().pathForResource("index", ofType: "htm")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\n")
        println(urlpath)
        print("\n")
        //WebView.removeFromSuperview()
        
        let requestURL = NSURL(string: urlpath!)
        let request = NSURLRequest(URL : requestURL!)
        webView.loadRequest(request)
    }

}