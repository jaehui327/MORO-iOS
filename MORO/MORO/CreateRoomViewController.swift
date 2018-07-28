import UIKit

class CreateRoomViewController: UIViewController, UITextFieldDelegate {
    //MARK: IBOutlet
    @IBOutlet weak var roomNameTextField: UITextField!
    @IBOutlet weak var maxMemberTextField: UITextField!
    @IBOutlet weak var minLevelTextField: UITextField!
    
    //MARK: properties
    var activeTextField: UITextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roomNameTextField.delegate = self
        maxMemberTextField.delegate = self
        minLevelTextField.delegate = self
        
        let navLabel = UILabel()
        let navTitle = NSMutableAttributedString(string: "방 만들기", attributes: [NSAttributedStringKey.font: UIFont(name: "NanumSquareRoundEB", size: 17.0) ?? UIFont.systemFont(ofSize: 17.0), NSAttributedStringKey.foregroundColor: UIColor.white])
        navLabel.attributedText = navTitle
        self.navigationItem.titleView = navLabel
    }
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: Any) {
        dismiss(animated: true) {
            NotificationCenter.default.post(name: .createRoom, object: nil, userInfo: nil)
        }
    }
    
    @IBAction func viewDidTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        observeKeyBoardNotification()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        roomNameTextField.resignFirstResponder()
        maxMemberTextField.resignFirstResponder()
        minLevelTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
}

extension CreateRoomViewController {
    private func observeKeyBoardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc private func keyboardHide() {
        let topBarHeight = UIApplication.shared.statusBarFrame.size.height +  (self.navigationController?.navigationBar.frame.height ?? 0.0)
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: { self.view.frame = CGRect(x: 0, y: topBarHeight, width: self.view.frame.width, height: self.view.frame.height) },
                       completion: nil)
    }
    
    @objc private func keyboardShow() {
        if activeTextField == roomNameTextField {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 1,
                           options: .curveEaseOut,
                           animations: { self.view.frame = CGRect(x: 0, y: -50, width: self.view.frame.width, height: self.view.frame.height) },
                           completion: nil)
        } else if activeTextField == maxMemberTextField {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 1,
                           options: .curveEaseOut,
                           animations: { self.view.frame = CGRect(x: 0, y: -80, width: self.view.frame.width, height: self.view.frame.height) },
                           completion: nil)
        } else if activeTextField == minLevelTextField {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 1,
                           options: .curveEaseOut,
                           animations: { self.view.frame = CGRect(x: 0, y: -110, width: self.view.frame.width, height: self.view.frame.height) },
                           completion: nil)
        }
    }
}
