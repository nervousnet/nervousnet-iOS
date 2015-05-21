import UIKit
import CoreMotion

class ViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("hi")
        
        // Do any additional setup after loading the view, typically from a nib.
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_BACKGROUND.value), 0)) { // 1
            
            dispatch_async(dispatch_get_main_queue()) { // 2
                SensorCollection.sensorActivate(CMMotionManager())
                //println("hello")
            }
        }
    }
}