import UIKit
import CoreMotion

class ViewController : UIViewController {
    
    @IBOutlet var Background: UIImageView!
    @IBOutlet var button: UIButton!
    @IBOutlet var Killswitch: UISwitch!
    
    var VM = NervousVM.sharedInstance
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func KillSwitch(sender: UISwitch) {
        println("\n")
        print(!sender.on)
        VM.killSwitch(!(sender.on))
    }
}