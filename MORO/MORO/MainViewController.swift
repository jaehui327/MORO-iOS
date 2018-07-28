//
//  MainViewController.swift
//  MORO
//
//  Created by 김재희 on 2018. 7. 28..
//  Copyright © 2018년 김재희. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    //MARK: IBOutlet
    @IBOutlet weak var HPGuage: UIImageView!
    @IBOutlet weak var HPHideLeadingConstraint: NSLayoutConstraint!
    
    //MARK: properties
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
