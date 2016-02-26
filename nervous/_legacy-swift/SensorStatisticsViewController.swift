//
//import UIKit
//import CoreMotion
//
//class SensorStatisticsViewController : UIViewController {
//    
//    var counter : Int = 1
//    @IBOutlet var webView: UIWebView!
//    var sensorId : String = "klappt nicht"
//    var garhTimer = NSTimer()
//    var VM = NervousVM.sharedInstance
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        //print(sensorId)
//        //webView.removeFromSuperview()
//        let currentTimeA :NSDate = NSDate()
//        let timestamp = UInt64(currentTimeA.timeIntervalSince1970*1000)
//        
//        
//        
//        switch sensorId {
//            
//            
//        case "Accelerometer":
//            var calender = NSCalendar.currentCalendar()
//            let flags: NSCalendarUnit = [.NSYearCalendarUnit, .NSMonthCalendarUnit, .NSDayCalendarUnit, .NSHourCalendarUnit, .NSMinuteCalendarUnit, .NSSecondCalendarUnit]
//            let components = NSCalendar.currentCalendar().components(flags, fromDate: currentTimeA)
//            
//            let accFreq = VM.getFrequency(0)
//            var accData = VM.retrieve(0, fromTimeStamp: timestamp-60000, toTimeStamp: timestamp)
//            let lastAcc = accData[accData.endIndex-1]
//            let javascript_global_variables =
//                "var unit_of_meas = " + "'m/s^2';" +
//                "var first_curve_name = " + "'X axis';" +
//                "var second_curve_name = " + "'Y axis';" +
//                "var third_curve_name = " + "'Z axis';" +
//                "var x_axis_title = " + "'Date';" +
//                "var y_axis_title = " + "'Acceleration (m/s^2)';" +
//                "var plot_title = " + "'Acceleration data';" +
//                "var plot_subtitle = " + "'along axes x,y,z';"
//            webView.stringByEvaluatingJavaScriptFromString("javascript:" + javascript_global_variables)
//            
//            let nsu = NSBundle.mainBundle().URLForResource("webview_charts_3_lines_live_data_over_time", withExtension: "html")
//            let req = NSURLRequest(URL: nsu!)
//            webView.loadRequest(req)
//
//            webView.stringByEvaluatingJavaScriptFromString("javascript:"
//                + "point0 = [Date.UTC(" + components.year.description + "," + (components.month-1).description + "," + components.day.description + "," + components.hour.description + "," + components.minute.description + "," + components.second.description + ")," + (lastAcc.valueFloat[0]).description + "];"
//                + "point1 = [Date.UTC(" + components.year.description + "," + (components.month-1).description + "," + components.day.description + "," + components.hour.description + "," + components.minute.description + "," + components.second.description + ")," + (lastAcc.valueFloat[1]).description + "];"
//                + "point2 = [Date.UTC(" + components.year.description + "," + (components.month-1).description + "," + components.day.description + "," + components.hour.description + "," + components.minute.description + "," + components.second.description + ")," + (lastAcc.valueFloat[2]).description + "];")
//            garhTimer = NSTimer.scheduledTimerWithTimeInterval(accFreq+0.5, target:self , selector: Selector("calledEverySecond"), userInfo: nil, repeats: true)
//
//            
//        case "Battery":
//            var calender = NSCalendar.currentCalendar()
//            let flags: NSCalendarUnit = [.NSYearCalendarUnit, .NSMonthCalendarUnit, .NSDayCalendarUnit, .NSHourCalendarUnit, .NSMinuteCalendarUnit, .NSSecondCalendarUnit]
//            let components = NSCalendar.currentCalendar().components(flags, fromDate: currentTimeA)
//            
//            let batFreq = VM.getFrequency(1)
//            var batData = VM.retrieve(1, fromTimeStamp: timestamp-60000, toTimeStamp: timestamp)
//            let lastBat = batData[batData.endIndex-1]
//            let javascript_global_variables = "var curve_name = " + "'Battery %';" +
//                "var unit_of_meas = " + "'%';" +
//                "var x_axis_title = " + "'Date';" +
//                "var y_axis_title = " + "'Battery percentage %';" +
//                "var plot_title = " + "'Battery data';" +
//                "var plot_subtitle = " + "'%';"
//            webView.stringByEvaluatingJavaScriptFromString("javascript:" + javascript_global_variables)
//            
//            let nsu = NSBundle.mainBundle().URLForResource("webview_charts_1_line_live_data_over_time", withExtension: "html")
//            let req = NSURLRequest(URL: nsu!)
//            webView.loadRequest(req)
//            
//            webView.stringByEvaluatingJavaScriptFromString("javascript:"
//                + "point = [Date.UTC(" + components.year.description + "," + (components.month-1).description + "," + components.day.description + "," + components.hour.description + "," + components.minute.description + "," + components.second.description + ")," + (lastBat.valueFloat[0]).description + "];")
//            garhTimer = NSTimer.scheduledTimerWithTimeInterval(batFreq+0.5, target:self , selector: Selector("calledEverySecond"), userInfo: nil, repeats: true)
//            
//            
//        case "Gyroscope":
//            var calender = NSCalendar.currentCalendar()
//            let flags: NSCalendarUnit = [.NSYearCalendarUnit, .NSMonthCalendarUnit, .NSDayCalendarUnit, .NSHourCalendarUnit, .NSMinuteCalendarUnit, .NSSecondCalendarUnit]
//            let components = NSCalendar.currentCalendar().components(flags, fromDate: currentTimeA)
//            
//            let gyrFreq = VM.getFrequency(2)
//            var gyrData = VM.retrieve(2, fromTimeStamp: timestamp-60000, toTimeStamp: timestamp)
//            let lastGyr = gyrData[gyrData.endIndex-1]
//            let javascript_global_variables = "var unit_of_meas = " + "'°';" +
//                "var first_curve_name = " + "'° around X axis';" +
//                "var second_curve_name = " + "'° around Y axis';" +
//                "var third_curve_name = " + "'° around Z axis';" +
//                "var x_axis_title = " + "'Date';" +
//                "var y_axis_title = " + "'Angle (°)';" +
//                "var plot_title = " + "'Gyroscope data';" +
//                "var plot_subtitle = " + "'angles around axes x,y,z';"
//            webView.stringByEvaluatingJavaScriptFromString("javascript:" + javascript_global_variables)
//            
//            let nsu = NSBundle.mainBundle().URLForResource("webview_charts_3_lines_live_data_over_time", withExtension: "html")
//            let req = NSURLRequest(URL: nsu!)
//            webView.loadRequest(req)
//            
//            webView.stringByEvaluatingJavaScriptFromString("javascript:"
//                + "point0 = [Date.UTC(" + components.year.description + "," + (components.month-1).description + "," + components.day.description + "," + components.hour.description + "," + components.minute.description + "," + components.second.description + ")," + (lastGyr.valueFloat[0]).description + "];"
//                + "point1 = [Date.UTC(" + components.year.description + "," + (components.month-1).description + "," + components.day.description + "," + components.hour.description + "," + components.minute.description + "," + components.second.description + ")," + (lastGyr.valueFloat[1]).description + "];"
//                + "point2 = [Date.UTC(" + components.year.description + "," + (components.month-1).description + "," + components.day.description + "," + components.hour.description + "," + components.minute.description + "," + components.second.description + ")," + (lastGyr.valueFloat[2]).description + "];")
//            garhTimer = NSTimer.scheduledTimerWithTimeInterval(gyrFreq+0.5, target:self , selector: Selector("calledEverySecond"), userInfo: nil, repeats: true)
//            
//            
//        case "Magnetic":
//            var calender = NSCalendar.currentCalendar()
//            let flags: NSCalendarUnit = [.NSYearCalendarUnit, .NSMonthCalendarUnit, .NSDayCalendarUnit, .NSHourCalendarUnit, .NSMinuteCalendarUnit, .NSSecondCalendarUnit]
//            let components = NSCalendar.currentCalendar().components(flags, fromDate: currentTimeA)
//            
//            let magFreq = VM.getFrequency(5)
//            var magData = VM.retrieve(5, fromTimeStamp: timestamp-60000, toTimeStamp: timestamp)
//            let lastMag = magData[magData.endIndex-1]
//            let javascript_global_variables = "var unit_of_meas = " + "'T';" +
//                "var first_curve_name = " + "'T along X axis';" +
//            "var second_curve_name = " + "'T along Y axis';" +
//                "var third_curve_name = " + "'T along Z axis';" +
//                "var x_axis_title = " + "'Date';" +
//                "var y_axis_title = " + "'Field strength (T)';" +
//                "var plot_title = " + "'Geomagnetic field data';" +
//                "var plot_subtitle = " + "'strength along axes x,y,z';"
//            webView.stringByEvaluatingJavaScriptFromString("javascript:" + javascript_global_variables)
//            
//            let nsu = NSBundle.mainBundle().URLForResource("webview_charts_3_lines_live_data_over_time", withExtension: "html")
//            let req = NSURLRequest(URL: nsu!)
//            webView.loadRequest(req)
//            
//            webView.stringByEvaluatingJavaScriptFromString("javascript:"
//                + "point0 = [Date.UTC(" + components.year.description + "," + (components.month-1).description + "," + components.day.description + "," + components.hour.description + "," + components.minute.description + "," + components.second.description + ")," + (lastMag.valueFloat[0]).description + "];"
//                + "point1 = [Date.UTC(" + components.year.description + "," + (components.month-1).description + "," + components.day.description + "," + components.hour.description + "," + components.minute.description + "," + components.second.description + ")," + (lastMag.valueFloat[1]).description + "];"
//                + "point2 = [Date.UTC(" + components.year.description + "," + (components.month-1).description + "," + components.day.description + "," + components.hour.description + "," + components.minute.description + "," + components.second.description + ")," + (lastMag.valueFloat[2]).description + "];")
//            garhTimer = NSTimer.scheduledTimerWithTimeInterval(magFreq+0.5, target:self , selector: Selector("calledEverySecond"), userInfo: nil, repeats: true)
//            
//            
//        case "Proximity":
//            var calender = NSCalendar.currentCalendar()
//            let flags: NSCalendarUnit = [.NSYearCalendarUnit, .NSMonthCalendarUnit, .NSDayCalendarUnit, .NSHourCalendarUnit, .NSMinuteCalendarUnit, .NSSecondCalendarUnit]
//            let components = NSCalendar.currentCalendar().components(flags, fromDate: currentTimeA)
//            
//            let proFreq = VM.getFrequency(6)
//            var proData = VM.retrieve(6, fromTimeStamp: timestamp-60000, toTimeStamp: timestamp)
//            let lastPro = proData[proData.endIndex-1]
//            
//            let javascript_global_variables = "var curve_name = " + "'Proximity %';" +
//                "var unit_of_meas = " + "'cm';" +
//                "var x_axis_title = " + "'Date';" +
//                "var y_axis_title = " + "'Proximity';" +
//                "var plot_title = " + "'Proximity data';" +
//                "var plot_subtitle = " + "'cm';"
//            webView.stringByEvaluatingJavaScriptFromString("javascript:" + javascript_global_variables)
//            
//            let nsu = NSBundle.mainBundle().URLForResource("webview_charts_1_line_live_data_over_time", withExtension: "html")
//            let req = NSURLRequest(URL: nsu!)
//            webView.loadRequest(req)
//            
//            webView.stringByEvaluatingJavaScriptFromString("javascript:"
//                + "point = [Date.UTC(" + components.year.description + "," + (components.month-1).description + "," + components.day.description + "," + components.hour.description + "," + components.minute.description + "," + components.second.description + ")," + (lastPro.valueFloat[0]).description + "];")
//            garhTimer = NSTimer.scheduledTimerWithTimeInterval(proFreq+0.5, target:self , selector: Selector("calledEverySecond"), userInfo: nil, repeats: true)
//            
//        default:
//            print("")
//            
//            
//            
//        }
//        
//        
//        
//    }
//    
////    override func viewDidDisappear(animated: Bool) {
////        garhTimer.invalidate
////    }
//    
//    override func viewDidDisappear(animated: Bool) {
//        garhTimer.invalidate()
//    }
//    
//    func calledEverySecond(){
//        let currentTimeA :NSDate = NSDate()
//        let timestamp = UInt64(currentTimeA.timeIntervalSince1970*1000)
//        
//        switch sensorId {
//        case "Accelerometer":
//            var calender = NSCalendar.currentCalendar()
//            let flags: NSCalendarUnit = [.NSYearCalendarUnit, .NSMonthCalendarUnit, .NSDayCalendarUnit, .NSHourCalendarUnit, .NSMinuteCalendarUnit, .NSSecondCalendarUnit]
//            let components = NSCalendar.currentCalendar().components(flags, fromDate: currentTimeA)
//            
//            var accData = VM.retrieve(0, fromTimeStamp: timestamp-60000, toTimeStamp: timestamp)
//            let lastAcc = accData[accData.endIndex-1]
//            //println(lastAcc)
//            webView.stringByEvaluatingJavaScriptFromString("javascript:"
//                + "point0 = [Date.UTC(" + components.year.description + "," + (components.month-1).description + "," + components.day.description + "," + components.hour.description + "," + components.minute.description + "," + components.second.description + ")," + (lastAcc.valueFloat[0]).description + "];"
//                + "point1 = [Date.UTC(" + components.year.description + "," + (components.month-1).description + "," + components.day.description + "," + components.hour.description + "," + components.minute.description + "," + components.second.description + ")," + (lastAcc.valueFloat[1]).description + "];"
//                + "point2 = [Date.UTC(" + components.year.description + "," + (components.month-1).description + "," + components.day.description + "," + components.hour.description + "," + components.minute.description + "," + components.second.description + ")," + (lastAcc.valueFloat[2]).description + "];")
//        
//            counter = counter + 1
//            counter = counter%60
//            //print (sensorId)
//            
//            
//        case "Battery":
//            var calender = NSCalendar.currentCalendar()
//            let flags: NSCalendarUnit = [.NSYearCalendarUnit, .NSMonthCalendarUnit, .NSDayCalendarUnit, .NSHourCalendarUnit, .NSMinuteCalendarUnit, .NSSecondCalendarUnit]
//            let components = NSCalendar.currentCalendar().components(flags, fromDate: currentTimeA)
//            
//            var batData = VM.retrieve(1, fromTimeStamp: timestamp-60000, toTimeStamp: timestamp)
//            let lastBat = batData[batData.endIndex-1]
//            webView.stringByEvaluatingJavaScriptFromString("javascript:"
//                + "point = [Date.UTC(" + components.year.description + "," + (components.month-1).description + "," + components.day.description + "," + components.hour.description + "," + components.minute.description + "," + components.second.description + ")," + (lastBat.valueFloat[0]).description + "];")
//            counter = counter + 1
//            counter = counter%60
//            //print (sensorId)
//            
//            
//        case "Gyroscope":
//            var calender = NSCalendar.currentCalendar()
//            let flags: NSCalendarUnit = [.NSYearCalendarUnit, .NSMonthCalendarUnit, .NSDayCalendarUnit, .NSHourCalendarUnit, .NSMinuteCalendarUnit, .NSSecondCalendarUnit]
//            let components = NSCalendar.currentCalendar().components(flags, fromDate: currentTimeA)
//            
//            var gyrData = VM.retrieve(2, fromTimeStamp: timestamp-60000, toTimeStamp: timestamp)
//            let lastGyr = gyrData[gyrData.endIndex-1]
//            webView.stringByEvaluatingJavaScriptFromString("javascript:"
//                + "point0 = [Date.UTC(" + components.year.description + "," + (components.month-1).description + "," + components.day.description + "," + components.hour.description + "," + components.minute.description + "," + components.second.description + ")," + (lastGyr.valueFloat[0]).description + "];"
//                + "point1 = [Date.UTC(" + components.year.description + "," + (components.month-1).description + "," + components.day.description + "," + components.hour.description + "," + components.minute.description + "," + components.second.description + ")," + (lastGyr.valueFloat[1]).description + "];"
//                + "point2 = [Date.UTC(" + components.year.description + "," + (components.month-1).description + "," + components.day.description + "," + components.hour.description + "," + components.minute.description + "," + components.second.description + ")," + (lastGyr.valueFloat[2]).description + "];")
//            
//            counter = counter + 1
//            counter = counter%60
//            //print (sensorId)
//            
//            
//        case "Magnetic":
//            var calender = NSCalendar.currentCalendar()
//            let flags: NSCalendarUnit = [.NSYearCalendarUnit, .NSMonthCalendarUnit, .NSDayCalendarUnit, .NSHourCalendarUnit, .NSMinuteCalendarUnit, .NSSecondCalendarUnit]
//            let components = NSCalendar.currentCalendar().components(flags, fromDate: currentTimeA)
//            
//            var magData = VM.retrieve(5, fromTimeStamp: timestamp-60000, toTimeStamp: timestamp)
//            let lastMag = magData[magData.endIndex-1]
//            
//            webView.stringByEvaluatingJavaScriptFromString("javascript:"
//                + "point0 = [Date.UTC(" + components.year.description + "," + (components.month-1).description + "," + components.day.description + "," + components.hour.description + "," + components.minute.description + "," + components.second.description + ")," + (lastMag.valueFloat[0]).description + "];"
//                + "point1 = [Date.UTC(" + components.year.description + "," + (components.month-1).description + "," + components.day.description + "," + components.hour.description + "," + components.minute.description + "," + components.second.description + ")," + (lastMag.valueFloat[1]).description + "];"
//                + "point2 = [Date.UTC(" + components.year.description + "," + (components.month-1).description + "," + components.day.description + "," + components.hour.description + "," + components.minute.description + "," + components.second.description + ")," + (lastMag.valueFloat[2]).description + "];")
//            counter = counter + 1
//            counter = counter%60
//            //print (sensorId)
//            
//            
//        case "Proximity":
//            var calender = NSCalendar.currentCalendar()
//            let flags: NSCalendarUnit = [.NSYearCalendarUnit, .NSMonthCalendarUnit, .NSDayCalendarUnit, .NSHourCalendarUnit, .NSMinuteCalendarUnit, .NSSecondCalendarUnit]
//            let components = NSCalendar.currentCalendar().components(flags, fromDate: currentTimeA)
//            
//            var proData = VM.retrieve(6, fromTimeStamp: timestamp-60000, toTimeStamp: timestamp)
//            let lastPro = proData[proData.endIndex-1]
//            
//            webView.stringByEvaluatingJavaScriptFromString("javascript:"
//                + "point = [Date.UTC(" + components.year.description + "," + (components.month-1).description + "," + components.day.description + "," + components.hour.description + "," + components.minute.description + "," + components.second.description + ")," + (lastPro.valueFloat[0]).description + "];")
//            counter = counter + 1
//            counter = counter%60
//            //print (sensorId)
//            
//        default:
//            print("")
//
//
//
//        }
//        
//
//    }
//
//
//}