import UIKit
import CoreMotion

class SensorStatisticsViewController : UIViewController {
    
    
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
        
//            (string: "javascript:" + "point = " + "[Date.UTC("
//            + 2015.description + "," + 11.description + "," + 23.description + "," + 11.description
//            + "," + 32.description + "," + 52.description + "),"
//            + 83.description + "];")
        
//        let requestURL = NSURL(string: "http://www.google.com")
//        let request = NSURLRequest(URL : url!)
//        webView.loadRequest(request)
    }

}