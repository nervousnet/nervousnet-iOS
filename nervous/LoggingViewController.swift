
import UIKit
import CoreMotion

class LoggingViewController : UIViewController {
    
    @IBOutlet weak var accField: UITextField!
    @IBOutlet weak var batField: UITextField!
    @IBOutlet weak var bleField: UITextField!
    @IBOutlet weak var conField: UITextField!
    @IBOutlet weak var gyrField: UITextField!
    @IBOutlet weak var humField: UITextField!
    @IBOutlet weak var ligField: UITextField!
    @IBOutlet weak var magField: UITextField!
    @IBOutlet weak var noiField: UITextField!
    @IBOutlet weak var preField: UITextField!
    @IBOutlet weak var proField: UITextField!
    @IBOutlet weak var temField: UITextField!
    
    var values = [0,1,2,3,4]
    var units = [" s", " m", " h", " d", " d"]
    var valuesInSeconds = [] // This is for the values in Seconds that will actually be applied to the settings
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInitialValues()
//        accField.text = String(values[0])
//        batField.text = String(values[0])
//        bleField.text = String(values[0])
//        conField.text = String(values[0])
//        gyrField.text = String(values[0])
//        humField.text = String(values[0])
//        ligField.text = String(values[0])
//        magField.text = String(values[0])
//        noiField.text = String(values[0])
//        preField.text = String(values[0])
//        proField.text = String(values[0])
//        temField.text = String(values[0])
    }
    
    func applyLoggingInterval () {
        //TODO: apply the selected interval to the actual collection
    }
    
    func getInitialValues(){
        //TODO: Set the fields and steppers to the current settings
    }
    
    @IBAction func accChange(sender: UIStepper, forEvent event: UIEvent) {
        accField.text = String(values[abs((Int(sender.value))%(values.count))]) + units[abs((Int(sender.value))%(values.count))]
        applyLoggingInterval()
    }
    
    @IBAction func batChange(sender: UIStepper) {
        batField.text = String(values[abs((Int(sender.value))%(values.count))]) + units[abs((Int(sender.value))%(values.count))]
        applyLoggingInterval()
    }

    @IBAction func bleChange(sender: UIStepper) {
        bleField.text = String(values[abs((Int(sender.value))%(values.count))]) + units[abs((Int(sender.value))%(values.count))]
        applyLoggingInterval()
    }
    
    @IBAction func conChange(sender: UIStepper) {
        conField.text = String(values[abs((Int(sender.value))%(values.count))]) + units[abs((Int(sender.value))%(values.count))]
        applyLoggingInterval()
    }

    @IBAction func gyrChange(sender: UIStepper) {
        gyrField.text = String(values[abs((Int(sender.value))%(values.count))]) + units[abs((Int(sender.value))%(values.count))]
        applyLoggingInterval()
    }

    @IBAction func humChange(sender: UIStepper) {
        humField.text = String(values[abs((Int(sender.value))%(values.count))]) + units[abs((Int(sender.value))%(values.count))]
        applyLoggingInterval()
    }
    
    @IBAction func ligChange(sender: UIStepper) {
        ligField.text = String(values[abs((Int(sender.value))%(values.count))]) + units[abs((Int(sender.value))%(values.count))]
        applyLoggingInterval()
    }

    @IBAction func magChange(sender: UIStepper) {
        magField.text = String(values[abs((Int(sender.value))%(values.count))]) + units[abs((Int(sender.value))%(values.count))]
        applyLoggingInterval()
    }
    
    @IBAction func noiChange(sender: UIStepper) {
        noiField.text = String(values[abs((Int(sender.value))%(values.count))]) + units[abs((Int(sender.value))%(values.count))]
        applyLoggingInterval()
    }

    @IBAction func preChange(sender: UIStepper) {
        preField.text = String(values[abs((Int(sender.value))%(values.count))]) + units[abs((Int(sender.value))%(values.count))]
        applyLoggingInterval()
    }

    @IBAction func proChange(sender: UIStepper) {
        proField.text = String(values[abs((Int(sender.value))%(values.count))]) + units[abs((Int(sender.value))%(values.count))]
        applyLoggingInterval()
    }
    
    @IBAction func temChange(sender: UIStepper) {
        temField.text = String(values[abs((Int(sender.value))%(values.count))]) + units[abs((Int(sender.value))%(values.count))]
        applyLoggingInterval()
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}