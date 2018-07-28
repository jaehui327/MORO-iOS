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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 테두리 둥글게
        popUpView.layer.cornerRadius = 10
        
        imgView.layer.cornerRadius = 75
        imgView.clipsToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirmPressed() {
    }
    
    @IBAction func cancelPressed() {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
