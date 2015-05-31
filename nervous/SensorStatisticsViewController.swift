import UIKit
import CoreMotion

class SensorStatisticsViewController : UIViewController {
    
    var counter : Int = 0
    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //webView.removeFromSuperview()
        
        let javascript_global_variables = "var curve_name = " + "'Proximity';" +
            "var unit_of_meas = " + "'cm';" +
            "var x_axis_title = " + "'Date';" +
            "var y_axis_title = " + "'Proximity (cm)';" +
            "var plot_title = " + "'Proximity data';" +
            "var plot_subtitle = " + "'';"
        print(javascript_global_variables)
        
        let url = NSBundle.mainBundle().URLForResource("hello", withExtension: "htm")
        
        webView.stringByEvaluatingJavaScriptFromString("javascript:" + javascript_global_variables)
        
        var nsu = NSBundle.mainBundle().URLForResource("webview_charts_1_line_live_data_over_time", withExtension: "html")
        var req = NSURLRequest(URL: nsu!)
        webView.loadRequest(req)
        
        
        
        
        webView.stringByEvaluatingJavaScriptFromString("javascript:" + "point = [Date.UTC(2015,11,23,11,32,52),83];")
        var garhTimer = NSTimer.scheduledTimerWithTimeInterval(2, target:self , selector: Selector("calledEverySecond"), userInfo: nil, repeats: true)
        
        
        
//            (string: "javascript:" + "point = " + "[Date.UTC("
//            + 2015.description + "," + 11.description + "," + 23.description + "," + 11.description
//            + "," + 32.description + "," + 52.description + "),"
//            + 83.description + "];")
        
//        let requestURL = NSURL(string: "http://www.google.com")
//        let request = NSURLRequest(URL : url!)
//        webView.loadRequest(request)
    }
    
//    override func viewDidDisappear(animated: Bool) {
//        garhTimer.invalidate
//    }
    
    func calledEverySecond(){
        
        webView.stringByEvaluatingJavaScriptFromString("javascript:" + "point = [Date.UTC(2015,11,23,11,32,"+counter.description+"),83];")
        counter = counter + 1
        counter = counter%60
    }


}