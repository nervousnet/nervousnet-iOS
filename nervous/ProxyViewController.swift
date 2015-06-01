import UIKit

class ProxyViewController : UIViewController {
    
    @IBOutlet var serverField: UITextField!
    @IBOutlet var portField: UITextField!
    var VM = NervousVM.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        serverField.text = (String(VM.getServerAddress()))
        portField.text = (String(VM.getServerPort()))
        
    }
    @IBAction func serverChange(sender: UITextField) {
       VM.setServer(serverField.text, port: VM.getServerPort())
    }
    @IBAction func portChange(sender: UITextField) {
        VM.setServer(VM.getServerAddress(), port: (portField.text as NSString).integerValue)
    }
}