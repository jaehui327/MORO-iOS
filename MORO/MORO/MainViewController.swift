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
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            playAnimate()
        }
        
        super.motionEnded(motion, with: event)
    }
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAnimateView()
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: .alarm, object: nil)
        
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
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .alarm, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate?.mainViewWillAppear()
        refresh()
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
        rocketView.alpha = 0
        animationView.alpha = 0
        animationView.loopAnimation = true
    }
    
    @objc private func refresh() {
        guard let model = model else {
            return
        }
        print(model)
        if isAlarmTime(model: model) {
            if model.isSelected == "false" {
                let storyboard = UIStoryboard(name: "AlertStoryboard", bundle: nil)
                let alarmOffAlertViewController = storyboard.instantiateViewController(withIdentifier: "AlarmOffAlertViewController")
                present(alarmOffAlertViewController, animated: true, completion: nil)
            }
            알람시간.text = "\(model.leftUsers)명"
            출발예정.text = "남았습니다."
            엠티라벨.text = ""
            rocketImageView.image = #imageLiteral(resourceName: "rocketon")
            
            if model.leftUsers == "0" {
                playAnimate()
            }
        } else if isEntered(model: model) {
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
    
    private func isAlarmTime(model: MainModel) -> Bool {
        if model.alarmTime == "" {
            return false
        }
        let date = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_kr")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let alarmDate = formatter.date(from: model.alarmTime) else { return false }
        if date.timeIntervalSince1970 - alarmDate.timeIntervalSince1970 > 0 {
            return true
        }
        return false
    }
    
    private func isEntered(model: MainModel) -> Bool {
        if model.alarmTime == "" {
            return false
        }
        return true
    }
    
    @objc private func playAnimate() {
        animationView.play()
        
        rocketView.alpha = 1
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
            self?.rocketImageView.image = #imageLiteral(resourceName: "rocketoff")
            self?.rocketView.snp.remakeConstraints {
                if let `self` = self {
                    $0.top.bottom.leading.trailing.equalTo(self.rocketImageView)
                }
            }
            self?.delegate?.completeRocketlauncher()
            
            self?.rocketView.alpha = 0
            self?.animationView.alpha = 0
            self?.refresh()
            let storyboard = UIStoryboard(name: "AlertStoryboard", bundle: nil)
            let launchRocketAlertViewController = storyboard.instantiateViewController(withIdentifier: "LaunchRocketAlertViewController")
            self?.present(launchRocketAlertViewController, animated: true, completion: nil)
        }
    }
}
