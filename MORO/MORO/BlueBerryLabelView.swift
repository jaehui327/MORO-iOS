//
//  BlueBerryLabelView.swift
//  MORO
//
//  Created by 이재성 on 28/07/2018.
//  Copyright © 2018 김재희. All rights reserved.
//

import UIKit

class BlueBerryLabelView: UIView {
    private var label: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.init(name: "NanumSquareRoundR", size: 13)
        label.textColor = .white
        label.text = "Lv.3~5"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        backgroundColor = #colorLiteral(red: 0.3330000043, green: 0.2509999871, blue: 0.5759999752, alpha: 1)
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubViews()
        addNewConstraints()
    }
    
    private func addSubViews() {
        addSubview(label)
    }
    
    private func addNewConstraints() {
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(1)
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
        }
    }
}
