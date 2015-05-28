
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
    
    @IBOutlet var accStepper: UIStepper!
    @IBOutlet var batStepper: UIStepper!
    @IBOutlet var gyrStepper: UIStepper!
    @IBOutlet var magStepper: UIStepper!
    @IBOutlet var proStepper: UIStepper!
    
    var values = [30,1,5,30,2]
    var units = [" s", " m", " m", " m", " h"]
    var valuesInSeconds : [Double] = [30,60,300,1800,6400] // This is for the values in Seconds that will actually be applied to the settings
    
    var VM = NervousVM.sharedInstance
    
    var acc : Double = 0
    var bat : Double = 0
    var gyr : Double = 0
    var mag : Double = 0
    var pro : Double = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getInitialValues()
        
        
        
        
    }
    
    func applyLoggingInterval () {
        //TODO: apply the selected interval to the actual collection
        VM.setFrequency(0, freq: acc)
        VM.setFrequency(1, freq: bat)
        VM.setFrequency(2, freq: gyr)
        VM.setFrequency(5, freq: mag)
        VM.setFrequency(6, freq: pro)
    }
    
    func getInitialValues(){
        //TODO: Set the fields and steppers to the current settings
        acc = VM.getFrequency(0)
        bat = VM.getFrequency(1)
        gyr = VM.getFrequency(2)
        mag = VM.getFrequency(5)
        pro = VM.getFrequency(6)
        
        accField.text = values[find(valuesInSeconds, acc)!].description + units[find(valuesInSeconds, acc)!]
        batField.text = values[find(valuesInSeconds, bat)!].description + units[find(valuesInSeconds, bat)!]
        gyrField.text = values[find(valuesInSeconds, gyr)!].description + units[find(valuesInSeconds, gyr)!]
        magField.text = values[find(valuesInSeconds, mag)!].description + units[find(valuesInSeconds, mag)!]
        proField.text = values[find(valuesInSeconds, pro)!].description + units[find(valuesInSeconds, pro)!]
        
        accStepper.maximumValue = Double(valuesInSeconds.count-1)
        batStepper.maximumValue = Double(valuesInSeconds.count-1)
        gyrStepper.maximumValue = Double(valuesInSeconds.count-1)
        magStepper.maximumValue = Double(valuesInSeconds.count-1)
        proStepper.maximumValue = Double(valuesInSeconds.count-1)
        
        accStepper.value = Double(find(valuesInSeconds, acc)!)
        batStepper.value = Double(find(valuesInSeconds, bat)!)
        gyrStepper.value = Double(find(valuesInSeconds, gyr)!)
        magStepper.value = Double(find(valuesInSeconds, mag)!)
        proStepper.value = Double(find(valuesInSeconds, pro)!)
    }
    
    @IBAction func accChange(sender: UIStepper, forEvent event: UIEvent) {
        accField.text = String(values[abs((Int(sender.value))%(values.count))]) + units[abs((Int(sender.value))%(values.count))]
        acc = valuesInSeconds[abs((Int(sender.value))%(values.count))]
        applyLoggingInterval()
        println("\n")
        println(VM.getFrequency(0))
        println("\n")
    }
    
    @IBAction func batChange(sender: UIStepper) {
        batField.text = String(values[abs((Int(sender.value))%(values.count))]) + units[abs((Int(sender.value))%(values.count))]
        bat = valuesInSeconds[abs((Int(sender.value))%(values.count))]
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
        gyr = valuesInSeconds[abs((Int(sender.value))%(values.count))]
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
        mag = valuesInSeconds[abs((Int(sender.value))%(values.count))]
        applyLoggingInterval()
        println("\n")
        println(VM.getFrequency(5))
        println("\n")
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
        pro = valuesInSeconds[abs((Int(sender.value))%(values.count))]
        applyLoggingInterval()
    }
    
    @IBAction func temChange(sender: UIStepper) {
        temField.text = String(values[abs((Int(sender.value))%(values.count))]) + units[abs((Int(sender.value))%(values.count))]
        applyLoggingInterval()
        
    }
}
    
    
    