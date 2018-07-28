//
//  BorderTextField.swift
//  MORO
//
//  Created by 김재희 on 2018. 7. 28..
//  Copyright © 2018년 김재희. All rights reserved.
//

import UIKit

class BorderTextField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        let color = UIColor(red: 85/255, green: 64/255, blue: 147/255, alpha: 1)
        layer.borderColor = color.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}
