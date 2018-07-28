//
//  JoinAlertViewController.swift
//  MORO
//
//  Created by Suji Kim on 2018. 7. 28..
//  Copyright © 2018년 김재희. All rights reserved.
//

import UIKit

class JoinAlertViewController: UIViewController {
    @IBOutlet var popUpView: UIView!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var labelMessage: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 테두리 둥글게
        popUpView.layer.cornerRadius = 15

        cancelButton.layer.addBorder([.top, .right], color: UIColor.lightGray, width: 0.5)
        doneButton.layer.addBorder([.top], color: UIColor.lightGray, width: 0.5)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirmPressed() {
    }
    
    @IBAction func cancelPressed() {
    }
}

extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}

