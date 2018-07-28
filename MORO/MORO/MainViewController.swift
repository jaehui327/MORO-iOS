//
//  MainViewController.swift
//  MORO
//
//  Created by 김재희 on 2018. 7. 28..
//  Copyright © 2018년 김재희. All rights reserved.
//

import UIKit
import Lottie
import SnapKit

protocol MainViewControllerDelegate: class {
    func mainViewWillAppear()
    func mainViewWillDisappear()
    func rocketlauncher()
    func completeRocketlauncher()
}

class MainViewController: UIViewController {
    //MARK: IBOutlet
    @IBOutlet weak var rocketImageView: UIImageView!
    @IBOutlet weak var HPGuage: UIImageView!
    @IBOutlet weak var HPHideLeadingConstraint: NSLayoutConstraint!
    
    //MARK: properties
    private var rocketView: UIImageView = {
        let imageView: UIImageView = UIImageView(image: #imageLiteral(resourceName: "rocketon.png"))
        return imageView
    }()
    
    private var animationView: LOTAnimationView = LOTAnimationView(name: "rocketLottie");
    weak var delegate: MainViewControllerDelegate?
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton.init(frame: .init(x: 20, y: 100, width: 100, height: 100))
        button.addTarget(self, action: #selector(playAnimate), for: .touchUpInside)
        button.backgroundColor = .red
        button.setTitle("test", for: .normal)
        view.addSubview(button)
        
        view.backgroundColor = .clear
        setAnimateView()
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
    
    private func setAnimateView() {
        view.addSubview(animationView)
        view.addSubview(rocketView)
        
        rocketView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalTo(rocketImageView)
        }
        
        animationView.snp.makeConstraints {
            $0.top.equalTo(rocketView.snp.bottom).offset(-10)
            $0.leading.trailing.equalTo(rocketView)
        }
        animationView.alpha = 0
        animationView.loopAnimation = true
    }
    
    @objc private func playAnimate() {
        animationView.play()
        
        rocketImageView.alpha = 0
        rocketView.snp.remakeConstraints {
            let offset = -(rocketImageView.frame.height * 3)
            $0.top.equalTo(rocketImageView).offset(offset)
            $0.bottom.equalTo(rocketImageView).offset(offset)
            $0.leading.trailing.equalTo(rocketImageView)
        }
        
        UIView.animate(withDuration: 1) { [weak self] in
            self?.animationView.alpha = 1
        }
        UIView.animate(withDuration: 3, animations: {
            [weak self] in
            self?.delegate?.rocketlauncher()
            self?.view.layoutIfNeeded()
        }) { [weak self] _ in
            self?.animationView.stop()
            self?.rocketImageView.alpha = 1
            self?.rocketView.snp.remakeConstraints {
                if let `self` = self {
                    $0.top.bottom.leading.trailing.equalTo(self.rocketImageView)
                }
            }
            self?.delegate?.completeRocketlauncher()
        }
    }
}
