import UIKit
import CoreMotion

class PrivacyViewController : UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet var AccLog: UISwitch!
    @IBOutlet var BatLog: UISwitch!
    @IBOutlet var GyrLog: UISwitch!
    @IBOutlet var MagLog: UISwitch!
    @IBOutlet var ProLog: UISwitch!
    
    @IBOutlet var AccShare: UISwitch!
    @IBOutlet var BatShare: UISwitch!
    @IBOutlet var GyrShare: UISwitch!
    @IBOutlet var MagShare: UISwitch!
    @IBOutlet var ProShare: UISwitch!
    
    var VM = NervousVM.sharedInstance

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AccLog.setOn(VM.getLogSwitch(0), animated: false)
        BatLog.setOn(VM.getLogSwitch(1), animated: false)
        GyrLog.setOn(VM.getLogSwitch(2), animated: false)
        MagLog.setOn(VM.getLogSwitch(5), animated: false)
        ProLog.setOn(VM.getLogSwitch(6), animated: false)
        
        AccShare.setOn(VM.getShareSwitch(0), animated: false)
        BatShare.setOn(VM.getShareSwitch(1), animated: false)
        GyrShare.setOn(VM.getShareSwitch(2), animated: false)
        MagShare.setOn(VM.getShareSwitch(5), animated: false)
        ProShare.setOn(VM.getShareSwitch(6), animated: false)

        

       // scrollView.contentSize = CGSize(width: 100, height : 3000)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func temShare(sender: UISwitch) {
    }
    @IBAction func proShare(sender: UISwitch) {
        VM.setShareSwitch(6, sharing: sender.on)
    }
    @IBAction func preShare(sender: UISwitch) {
    }
    @IBAction func noiShare(sender: UISwitch) {
    }
    @IBAction func magShare(sender: UISwitch) {
        VM.setShareSwitch(5, sharing: sender.on)
    }
    @IBAction func ligShare(sender: UISwitch) {
    }
    @IBAction func humShare(sender: UISwitch) {
    }
    @IBAction func gyrShare(sender: UISwitch) {
        VM.setShareSwitch(2, sharing: sender.on)
    }
    @IBAction func conShare(sender: UISwitch) {
    }
    @IBAction func bleShare(sender: UISwitch) {
    }
    @IBAction func batShare(sender: UISwitch) {
        VM.setShareSwitch(1, sharing: sender.on)
    }
    @IBAction func accShare(sender: UISwitch) {
        VM.setShareSwitch(0, sharing: sender.on)
    }
    
    @IBAction func temLog(sender: UISwitch) {
    }
    @IBAction func proLog(sender: UISwitch) {
        VM.setLogSwitch(6, logging: sender.on)

    }
    @IBAction func preLog(sender: UISwitch) {
    }
    @IBAction func noiLog(sender: UISwitch) {
    }
    @IBAction func magLog(sender: UISwitch) {
        VM.setLogSwitch(5, logging: sender.on)

    }
    @IBAction func ligLog(sender: UISwitch) {
    }
    @IBAction func humLog(sender: UISwitch) {
    }
    @IBAction func gyrLog(sender: UISwitch) {
        VM.setLogSwitch(2, logging: sender.on)

    }
    @IBAction func conLog(sender: UISwitch) {
    }
    @IBAction func bleLog(sender: UISwitch) {
    }
    @IBAction func batLog(sender: UISwitch) {
        VM.setLogSwitch(1, logging: sender.on)

    }
    @IBAction func accLog(sender: UISwitch) {
        VM.setLogSwitch(0, logging: sender.on)
    }


    
}