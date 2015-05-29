import UIKit

class NervousAppTableViewCell : UITableViewCell {
    
    @IBOutlet var Image: UIView!
   
    @IBOutlet var Name: UILabel!
    
    @IBOutlet var Button: UIButton!
    
    @IBOutlet var Description: UILabel!
    
    var Link : String = " "
    
    @IBAction func ButtonPressed(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: Link)!)
    }
    

}