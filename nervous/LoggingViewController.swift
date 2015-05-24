
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("hilo")
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
    
    
    
    @IBAction func accChange(sender: UIStepper, forEvent event: UIEvent) {
        accField.text = String(values[abs((Int(sender.value))%(values.count))])
    }
    
    @IBAction func batChange(sender: UIStepper) {
        batField.text = String(values[abs((Int(sender.value))%(values.count))])

    }

    @IBAction func bleChange(sender: UIStepper) {
        bleField.text = String(values[abs((Int(sender.value))%(values.count))])
    }
    
    @IBAction func conChange(sender: UIStepper) {
        conField.text = String(values[abs((Int(sender.value))%(values.count))])
    }

    @IBAction func gyrChange(sender: UIStepper) {
        gyrField.text = String(values[abs((Int(sender.value))%(values.count))])
    }

    @IBAction func humChange(sender: UIStepper) {
        humField.text = String(values[abs((Int(sender.value))%(values.count))])
    }
    
    @IBAction func ligChange(sender: UIStepper) {
        ligField.text = String(values[abs((Int(sender.value))%(values.count))])
    }

    @IBAction func magChange(sender: UIStepper) {
        magField.text = String(values[abs((Int(sender.value))%(values.count))])
    }
    
    @IBAction func noiChange(sender: UIStepper) {
        noiField.text = String(values[abs((Int(sender.value))%(values.count))])
    }

    @IBAction func preChange(sender: UIStepper) {
        preField.text = String(values[abs((Int(sender.value))%(values.count))])
    }

    @IBAction func proChange(sender: UIStepper) {
        proField.text = String(values[abs((Int(sender.value))%(values.count))])
    }
    
    @IBAction func temChange(sender: UIStepper) {
        temField.text = String(values[abs((Int(sender.value))%(values.count))])

    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}