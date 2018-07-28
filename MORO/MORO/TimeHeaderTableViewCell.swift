//
//  TimeHeaderTableViewCell.swift
//  MORO
//
//  Created by 이재성 on 28/07/2018.
//  Copyright © 2018 김재희. All rights reserved.
//

import UIKit

class TimeHeaderTableViewCell: UITableViewCell {
    private var lineImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "listHeaderLine")
        return imageView
    }()
    
    private var timeLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.init(name: "NanumSquareRoundR", size: 13)
        label.textColor = .white
        label.text = "AM 07:00"
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        backgroundColor = .clear
        addSubViews()
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
        addSubview(lineImageView)
        addSubview(timeLabel)
    }
    
    private func addConstraints() {
        lineImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().offset(36)
            $0.bottom.equalToSuperview().offset(-10)
        }
        timeLabel.snp.makeConstraints {
            $0.leading.equalTo(lineImageView.snp.trailing).offset(7)
            $0.centerY.equalTo(lineImageView)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
