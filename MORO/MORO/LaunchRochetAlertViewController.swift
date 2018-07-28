import UIKit

class LaunchRocketAlertViewController: UIViewController {
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popUpView.layer.cornerRadius = 15
        doneButton.layer.addBorder([.top], color: UIColor.lightGray, width: 0.5)
    }
}
