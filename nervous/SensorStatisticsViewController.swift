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
        
        
        switch sensorId {
            
            
        case "Accelerometer":
            let javascript_global_variables =
                "var unit_of_meas = " + "'m/s^2';" +
                "var first_curve_name = " + "'X axis';" +
                "var second_curve_name = " + "'Y axis';" +
                "var third_curve_name = " + "'Z axis';" +
                "var x_axis_title = " + "'Date';" +
                "var y_axis_title = " + "'Acceleration (m/s^2)';" +
                "var plot_title = " + "'Acceleration data';" +
                "var plot_subtitle = " + "'along axes x,y,z';"
            webView.stringByEvaluatingJavaScriptFromString("javascript:" + javascript_global_variables)
            
            var nsu = NSBundle.mainBundle().URLForResource("webview_charts_3_lines_live_data_over_time", withExtension: "html")
            var req = NSURLRequest(URL: nsu!)
            webView.loadRequest(req)
            
            webView.stringByEvaluatingJavaScriptFromString("javascript:"
                + "point0 = [Date.UTC(2015,11,23,11,32," + counter.description+"),"+(counter).description+"];"
                + "point1 = [Date.UTC(2015,11,23,11,32," + counter.description+"),"+(counter*counter).description+"];"
                + "point2 = [Date.UTC(2015,11,23,11,32," + counter.description+"),"+(counter*counter*counter).description + "];")
            garhTimer = NSTimer.scheduledTimerWithTimeInterval(2, target:self , selector: Selector("calledEverySecond"), userInfo: nil, repeats: true)

            
        case "Battery":
            let javascript_global_variables = "var curve_name = " + "'Battery %';" +
                "var unit_of_meas = " + "'%';" +
                "var x_axis_title = " + "'Date';" +
                "var y_axis_title = " + "'Battery percentage %';" +
                "var plot_title = " + "'Battery data';" +
                "var plot_subtitle = " + "'%';"
            webView.stringByEvaluatingJavaScriptFromString("javascript:" + javascript_global_variables)
            
            var nsu = NSBundle.mainBundle().URLForResource("webview_charts_1_line_live_data_over_time", withExtension: "html")
            var req = NSURLRequest(URL: nsu!)
            webView.loadRequest(req)
            
            webView.stringByEvaluatingJavaScriptFromString("javascript:" + "point = [Date.UTC(2015,11,23,11,32,0),0];")
            garhTimer = NSTimer.scheduledTimerWithTimeInterval(2, target:self , selector: Selector("calledEverySecond"), userInfo: nil, repeats: true)
            
            
        case "Gyroscope":
            let javascript_global_variables = "var unit_of_meas = " + "'°';" +
                "var first_curve_name = " + "'° around X axis';" +
                "var second_curve_name = " + "'° around Y axis';" +
                "var third_curve_name = " + "'° around Z axis';" +
                "var x_axis_title = " + "'Date';" +
                "var y_axis_title = " + "'Angle (°)';" +
                "var plot_title = " + "'Gyroscope data';" +
                "var plot_subtitle = " + "'angles around axes x,y,z';"
            webView.stringByEvaluatingJavaScriptFromString("javascript:" + javascript_global_variables)
            
            var nsu = NSBundle.mainBundle().URLForResource("webview_charts_3_lines_live_data_over_time", withExtension: "html")
            var req = NSURLRequest(URL: nsu!)
            webView.loadRequest(req)
            
            webView.stringByEvaluatingJavaScriptFromString("javascript:"
                + "point0 = [Date.UTC(2015,11,23,11,32," + counter.description+"),"+(counter).description+"];"
                + "point1 = [Date.UTC(2015,11,23,11,32," + counter.description+"),"+(counter*counter).description+"];"
                + "point2 = [Date.UTC(2015,11,23,11,32," + counter.description+"),"+(counter*counter*counter).description + "];")
            garhTimer = NSTimer.scheduledTimerWithTimeInterval(2, target:self , selector: Selector("calledEverySecond"), userInfo: nil, repeats: true)
            
            
        case "Magnetic":
            let javascript_global_variables = "var unit_of_meas = " + "'T';" +
                "var first_curve_name = " + "'T along X axis';" +
            "var second_curve_name = " + "'T along Y axis';" +
                "var third_curve_name = " + "'T along Z axis';" +
                "var x_axis_title = " + "'Date';" +
                "var y_axis_title = " + "'Field strength (T)';" +
                "var plot_title = " + "'Geomagnetic field data';" +
                "var plot_subtitle = " + "'strength along axes x,y,z';"
            webView.stringByEvaluatingJavaScriptFromString("javascript:" + javascript_global_variables)
            
            var nsu = NSBundle.mainBundle().URLForResource("webview_charts_3_lines_live_data_over_time", withExtension: "html")
            var req = NSURLRequest(URL: nsu!)
            webView.loadRequest(req)
            
            webView.stringByEvaluatingJavaScriptFromString("javascript:"
                + "point0 = [Date.UTC(2015,11,23,11,32," + counter.description+"),"+(counter).description+"];"
                + "point1 = [Date.UTC(2015,11,23,11,32," + counter.description+"),"+(counter*counter).description+"];"
                + "point2 = [Date.UTC(2015,11,23,11,32," + counter.description+"),"+(counter*counter*counter).description + "];")
            garhTimer = NSTimer.scheduledTimerWithTimeInterval(2, target:self , selector: Selector("calledEverySecond"), userInfo: nil, repeats: true)
            
            
        case "Proximity":
            let javascript_global_variables = "var curve_name = " + "'Proximity %';" +
                "var unit_of_meas = " + "'%';" +
                "var x_axis_title = " + "'Date';" +
                "var y_axis_title = " + "'Battery percentage %';" +
                "var plot_title = " + "'Battery data';" +
                "var plot_subtitle = " + "'%';"
            webView.stringByEvaluatingJavaScriptFromString("javascript:" + javascript_global_variables)
            
            var nsu = NSBundle.mainBundle().URLForResource("webview_charts_1_line_live_data_over_time", withExtension: "html")
            var req = NSURLRequest(URL: nsu!)
            webView.loadRequest(req)
            
            webView.stringByEvaluatingJavaScriptFromString("javascript:" + "point = [Date.UTC(2015,11,23,11,32,0),0];")
            garhTimer = NSTimer.scheduledTimerWithTimeInterval(2, target:self , selector: Selector("calledEverySecond"), userInfo: nil, repeats: true)
            
        default:
            println("")
            
            
            
        }
        
        
        
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
            webView.stringByEvaluatingJavaScriptFromString("javascript:"
                + "point0 = [Date.UTC(2015,11,23,11,32,"+counter.description+"),"+(counter).description+"];"
                + "point1 = [Date.UTC(2015,11,23,11,32,"+counter.description+"),"+(counter*counter).description+"];"
                + "point2 = [Date.UTC(2015,11,23,11,32,"+counter.description+"),"+(counter*counter*counter).description+"];"
            )
        
            counter = counter + 1
            counter = counter%60
            //print (sensorId)
            
            
        case "Battery":
            webView.stringByEvaluatingJavaScriptFromString("javascript:" + "point = [Date.UTC(2015,11,23,11,32,"+counter.description+"),"+(counter*counter).description+"];")
            counter = counter + 1
            counter = counter%60
            //print (sensorId)
            
            
        case "Gyroscope":
            webView.stringByEvaluatingJavaScriptFromString("javascript:"
                + "point0 = [Date.UTC(2015,11,23,11,32,"+counter.description+"),"+(counter).description+"];"
                + "point1 = [Date.UTC(2015,11,23,11,32,"+counter.description+"),"+(counter*counter).description+"];"
                + "point2 = [Date.UTC(2015,11,23,11,32,"+counter.description+"),"+(counter*counter*counter).description+"];"
            )
            
            counter = counter + 1
            counter = counter%60
            //print (sensorId)
            
            
        case "Magnetic":
            webView.stringByEvaluatingJavaScriptFromString("javascript:"
                + "point0 = [Date.UTC(2015,11,23,11,32,"+counter.description+"),"+(counter).description+"];"
                + "point1 = [Date.UTC(2015,11,23,11,32,"+counter.description+"),"+(counter*counter).description+"];"
                + "point2 = [Date.UTC(2015,11,23,11,32,"+counter.description+"),"+(counter*counter*counter).description+"];"
            )
            
            counter = counter + 1
            counter = counter%60
            //print (sensorId)
            
            
        case "Proximity":
            webView.stringByEvaluatingJavaScriptFromString("javascript:" + "point = [Date.UTC(2015,11,23,11,32,"+counter.description+"),"+(counter*counter).description+"];")
            counter = counter + 1
            counter = counter%60
            //print (sensorId)
            
        default:
            println("")



        }
        

    }


}