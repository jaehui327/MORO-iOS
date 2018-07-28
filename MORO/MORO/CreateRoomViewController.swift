import UIKit

class CreateRoomViewController: UIViewController {
    //MARK: IBOutlet
    @IBOutlet weak var roomNameTextField: UITextField!
    @IBOutlet weak var maxMemberTextField: UITextField!
    @IBOutlet weak var minLevelTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
