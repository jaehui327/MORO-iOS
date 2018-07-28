//
//  TimeMainListTableViewCell.swift
//  MORO
//
//  Created by 이재성 on 28/07/2018.
//  Copyright © 2018 김재희. All rights reserved.
//

import UIKit

class TimeMainListTableViewCell: UITableViewCell {
    private var 레벨뷰: BlueBerryLabelView = {
        let view: BlueBerryLabelView = BlueBerryLabelView(frame: .zero)
        return view
    }()
    
    private var 사람수뷰: BlueberryImageView = {
        let view: BlueberryImageView = BlueberryImageView(frame: .zero)
        return view
    }()
    
    private var 제목라벨: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.init(name: "NanumSquareRoundR", size: 13)
        label.textColor = #colorLiteral(red: 0.3921568627, green: 0.3921568627, blue: 0.3921568627, alpha: 1)
        label.text = "꼭 일어나자!"
//        label.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .horizontal)
        return label
    }()
    
    private var 시간라벨: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.init(name: "NanumSquareRoundEB", size: 40)
        if UIScreen.main.bounds.width == 320 {
            label.font = UIFont.init(name: "NanumSquareRoundEB", size: 30)
        }
        label.textColor = #colorLiteral(red: 0.2352941176, green: 0.1137254902, blue: 0.3411764706, alpha: 1)
        label.text = "07:00"
        return label
    }()
    
    private var 오전오후라벨: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.init(name: "NanumSquareRoundR", size: 13)
        label.textColor = #colorLiteral(red: 0.3333333333, green: 0.2509803922, blue: 0.5764705882, alpha: 1)
        label.text = "AM"
        return label
    }()
    
    private var arrowImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "arrow.png")
        return imageView
    }()
    
    private var backgroundCardView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        addSubViews()
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        alpha = 1
    }
    
    private func addSubViews() {
        addSubview(backgroundCardView)
        backgroundCardView.addSubview(오전오후라벨)
        backgroundCardView.addSubview(시간라벨)
        backgroundCardView.addSubview(arrowImageView)
        backgroundCardView.addSubview(제목라벨)
        backgroundCardView.addSubview(사람수뷰)
        backgroundCardView.addSubview(레벨뷰)
    }
    
    private func addConstraints() {
        backgroundCardView.snp.makeConstraints {
            if UIScreen.main.bounds.width == 320 {
                $0.leading.equalToSuperview().offset(17)
            } else {
                $0.leading.equalToSuperview().offset(44)
            }
            $0.trailing.equalToSuperview().offset(-17)
            $0.top.equalToSuperview().offset(5)
            $0.bottom.equalToSuperview().offset(-5)
            $0.height.equalTo(80)
        }
        
        오전오후라벨.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.centerY.equalToSuperview().offset(3)
        }
        
        시간라벨.snp.makeConstraints {
            $0.leading.equalTo(오전오후라벨.snp.trailing).offset(1)
            $0.centerY.equalToSuperview().offset(3)
        }
        
        제목라벨.snp.makeConstraints {
            $0.top.equalToSuperview().offset(23)
            $0.leading.equalTo(시간라벨.snp.trailing).offset(19)
            $0.trailing.lessThanOrEqualTo(arrowImageView.snp.leading).offset(-4)
        }
        
        제목라벨.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 250), for: .horizontal)
        
        사람수뷰.snp.makeConstraints {
            $0.top.equalTo(제목라벨.snp.bottom).offset(3)
            $0.leading.equalTo(제목라벨.snp.leading)
        }
        
        레벨뷰.snp.makeConstraints {
            $0.top.bottom.equalTo(사람수뷰)
            $0.leading.equalTo(사람수뷰.snp.trailing).offset(9)
            $0.trailing.lessThanOrEqualTo(arrowImageView.snp.leading).offset(-4)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-12)
            $0.centerY.equalToSuperview()
        }
    }
    
    func setData(model: String) {
        if model == "" {
            setAlpha()
        }
    }
    
    private func setAlpha() {
        alpha = 0.5
        setNeedsLayout()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
