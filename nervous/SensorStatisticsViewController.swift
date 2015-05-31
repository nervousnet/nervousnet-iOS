import UIKit
import CoreMotion

class SensorStatisticsViewController : UIViewController {
    
    var counter : Int = 1
    @IBOutlet var webView: UIWebView!
    var sensorId : String = "klappt nicht"
    var garhTimer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(sensorId)
        //webView.removeFromSuperview()
        
        
        let javascript_global_variables = "var curve_name = " + "'Proximity';" +
            "var unit_of_meas = " + "'cm';" +
            "var x_axis_title = " + "'Date';" +
            "var y_axis_title = " + "'Proximity (cm)';" +
            "var plot_title = " + "'Proximity data';" +
            "var plot_subtitle = " + "'';"
        
        let url = NSBundle.mainBundle().URLForResource("hello", withExtension: "htm")
        
        webView.stringByEvaluatingJavaScriptFromString("javascript:" + javascript_global_variables)
        
        var nsu = NSBundle.mainBundle().URLForResource("webview_charts_1_line_live_data_over_time", withExtension: "html")
        var req = NSURLRequest(URL: nsu!)
        webView.loadRequest(req)
        
        
        
        
        webView.stringByEvaluatingJavaScriptFromString("javascript:" + "point = [Date.UTC(2015,11,23,11,32,0),0];")
        garhTimer = NSTimer.scheduledTimerWithTimeInterval(2, target:self , selector: Selector("calledEverySecond"), userInfo: nil, repeats: true)
        
        
        
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
    
    override func viewDidDisappear(animated: Bool) {
        garhTimer.invalidate()
    }
    
    func calledEverySecond(){
        switch sensorId {
        case "Accelerometer":
                webView.stringByEvaluatingJavaScriptFromString("javascript:" + "point = [Date.UTC(2015,11,23,11,32,"+counter.description+"),"+(counter*counter).description+"];")
                counter = counter + 1
                counter = counter%60
                print (sensorId)
        case "Battery":
            webView.stringByEvaluatingJavaScriptFromString("javascript:" + "point = [Date.UTC(2015,11,23,11,32,"+counter.description+"),"+(counter*counter).description+"];")
            counter = counter + 1
            counter = counter%60
            print (sensorId)
        case "Gyroscope":
            webView.stringByEvaluatingJavaScriptFromString("javascript:" + "point = [Date.UTC(2015,11,23,11,32,"+counter.description+"),"+(counter*counter).description+"];")
            counter = counter + 1
            counter = counter%60
            print (sensorId)
        case "Magnetic":
            webView.stringByEvaluatingJavaScriptFromString("javascript:" + "point = [Date.UTC(2015,11,23,11,32,"+counter.description+"),"+(counter*counter).description+"];")
            counter = counter + 1
            counter = counter%60
            print (sensorId)
        case "Proximity":
            webView.stringByEvaluatingJavaScriptFromString("javascript:" + "point = [Date.UTC(2015,11,23,11,32,"+counter.description+"),"+(counter*counter).description+"];")
            counter = counter + 1
            counter = counter%60
            print (sensorId)
        default:
            println("")



        }
        webView.stringByEvaluatingJavaScriptFromString("javascript:" + "point = [Date.UTC(2015,11,23,11,32,"+counter.description+"),"+(counter*counter).description+"];")
        counter = counter + 1
        counter = counter%60
        print (sensorId)

    }


}