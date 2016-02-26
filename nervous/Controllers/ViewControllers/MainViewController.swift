import UIKit
import CoreMotion

class MainViewController : UIViewController {
    
    @IBOutlet var Background: UIImageView!
    @IBOutlet var button: UIButton!
    @IBOutlet var Killswitch: UISwitch!
    
    var UserAgreement = "This what is shown to the user"
    //var VM = NervousVM.sharedInstance
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
       // Killswitch.setOn(!VM.getKillSwitchStatus(), animated: true)
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        /* let alertController = UIAlertController(title: "Nervousnet end-user agreement ", message: UserAgreement, preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Decline", style: .Cancel) { (action) in
            // ...
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "Accept", style: .Default) { (action) in
            self.VM.setAcceptedTerms(true)
        }
        alertController.addAction(OKAction)
        
        if (!VM.getAcceptedTerms()){
        */
        //self.presentViewController(alertController, animated: true, completion:nil)
        //}
    }
    
    @IBAction func KillSwitch(sender: UISwitch) {
        print("\n")
        print(!sender.on, terminator: "")
        //VM.killSwitch(!(sender.on))
    }
}