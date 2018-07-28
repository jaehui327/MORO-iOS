//
//  WhiteImageView.swift
//  MORO
//
//  Created by 이재성 on 28/07/2018.
//  Copyright © 2018 김재희. All rights reserved.
//

import UIKit

class WhiteImageView: UIView {
    private var label: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.init(name: "NanumSquareRoundR", size: 15)
        label.textColor = #colorLiteral(red: 0.3330000043, green: 0.2509999871, blue: 0.5759999752, alpha: 1)
        label.text = "Lv.2"
        return label
    }()
    
    private var imageView: UIImageView = {
        let imageView: UIImageView = UIImageView(image: #imageLiteral(resourceName: "Lv1"))
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(text: String) {
//        imageView.image = 
        label.text = "Lv.\(text)"
    }
    
    private func commonInit() {
        backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.9)
        layer.cornerRadius = 18.5
        clipsToBounds = true
        
        addSubViews()
        addNewConstraints()
    }
    
    private func addSubViews() {
        addSubview(imageView)
        addSubview(label)
    }
    
    private func addNewConstraints() {
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(6)
            $0.bottom.equalToSuperview().offset(-6)
            $0.leading.equalToSuperview().offset(6)
        }
        
        label.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(1)
            $0.leading.equalTo(imageView.snp.trailing).offset(4)
            $0.trailing.equalToSuperview().offset(-9)
        }
    }
}
