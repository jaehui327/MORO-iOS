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
    @IBOutlet weak var levelView: UIView!
    @IBOutlet weak var roomInfoView: UIView!
    
    //MARK: properties
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        levelView.layer.cornerRadius = levelView.frame.height / 2
        roomInfoView.layer.cornerRadius = roomInfoView.frame.height / 2
    }
    //MARK: Methods
}
