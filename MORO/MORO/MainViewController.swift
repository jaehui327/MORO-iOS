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
    func refresh(result: MainRequest.ResponseType)
}

class MainViewController: UIViewController {
    //MARK: IBOutlet
    @IBOutlet weak var rocketImageView: UIImageView!
    @IBOutlet weak var HPGuage: UIImageView!
    @IBOutlet weak var HPHideLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var 알람시간: UILabel!
    @IBOutlet weak var 출발예정: UILabel!
    @IBOutlet weak var 엠티라벨: UILabel!
    
    //MARK: properties
    private var rocketView: UIImageView = {
        let imageView: UIImageView = UIImageView(image: #imageLiteral(resourceName: "rocketon.png"))
        return imageView
    }()
    private var model: MainModel?
    
    private var animationView: LOTAnimationView = LOTAnimationView(name: "rocketLottie");
    weak var delegate: MainViewControllerDelegate?
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Network.request(req: MainRequest()) { [weak self] result in
            switch result {
            case .success(let result):
                self?.model = result
                self?.delegate?.refresh(result: result)
                self?.refresh()
            case .cancel(let cancelError):
                print(cancelError!)
            case .failure(let error):
                print(error!)
            }
        }
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
    
    private func refresh() {
        guard let model = model else {
            return
        }
        
        if isEntered(model: model) {
            알람시간.text = model.alarmTime
            출발예정.text = "출발예정"
            rocketImageView.image = #imageLiteral(resourceName: "rocketon")
            엠티라벨.text = ""
        } else {
            알람시간.text = ""
            출발예정.text = ""
            엠티라벨.text = """
            출발 예정인
            로켓이 없습니다.
            """
            
            rocketImageView.image =  #imageLiteral(resourceName: "rocketoff")
        }
        
        
        
    }
    
    private func isEntered(model: MainModel) -> Bool {
        if model.alarmTime == "" {
            return false
        }
        return true
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
