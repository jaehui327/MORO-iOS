//
//  WhiteLabelView.swift
//  MORO
//
//  Created by 이재성 on 28/07/2018.
//  Copyright © 2018 김재희. All rights reserved.
//

import UIKit

class WhiteLabelView: UIView {
    private var roomLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.init(name: "NanumSquareRoundR", size: 15)
        label.textColor = #colorLiteral(red: 0.3330000043, green: 0.2509999871, blue: 0.5759999752, alpha: 1)
        label.text = " "
        return label
    }()
    
    private var label: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.init(name: "NanumSquareRoundR", size: 15)
        label.textColor = #colorLiteral(red: 0.3330000043, green: 0.2509999871, blue: 0.5759999752, alpha: 1)
        label.text = " "
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(result: MainRequest.ResponseType) {
        if result.roomName == "" {
            isHidden = true
        } else {
            isHidden = false
            roomLabel.text = "\(result.roomName)"
            label.text = "Lv.\(result.roomRequirement)~5"
        }
    }
    
    private func commonInit() {
        backgroundColor = .white
        layer.cornerRadius = 18.5
        clipsToBounds = true
        
        addSubViews()
        addNewConstraints()
    }
    
    private func addSubViews() {
        addSubview(roomLabel)
        addSubview(label)
    }
    
    private func addNewConstraints() {
        roomLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.bottom.equalToSuperview().offset(-8)
            $0.centerY.equalToSuperview().offset(1)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(label.snp.leading).offset(-17)
        }
        
        roomLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 250), for: .horizontal)
        
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(1)
            $0.trailing.equalToSuperview().offset(-40)
        }
    }
}
