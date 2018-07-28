//
//  MainViewController.swift
//  MORO
//
//  Created by 김재희 on 2018. 7. 28..
//  Copyright © 2018년 김재희. All rights reserved.
//

import UIKit

protocol mainViewControllerDelegate: class {
    func mainViewWillAppear()
    func mainViewWillDisappear()
}

class MainViewController: UIViewController {
    //MARK: IBOutlet
    @IBOutlet weak var HPGuage: UIImageView!
    @IBOutlet weak var HPHideLeadingConstraint: NSLayoutConstraint!
    
    //MARK: properties
    weak var delegate: mainViewControllerDelegate?
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate?.mainViewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.mainViewWillDisappear()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
