import UIKit

class AlarmOffAlertViewController: UIViewController {
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var offAlarmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popUpView.layer.cornerRadius = 15
        
        offAlarmButton.layer.addBorder([.top], color: UIColor.lightGray, width: 0.5)
    }
    @IBAction func dismissButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
