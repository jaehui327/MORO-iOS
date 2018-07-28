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
        layer.borderColor = #colorLiteral(red: 0.3330000043, green: 0.2509999871, blue: 0.5759999752, alpha: 1)
        layer.borderWidth = 1
        layer.cornerRadius = 10
        clipsToBounds = true
        
        let spaceView: UIView = UIView(frame: .init(x: 0, y: 0, width: 10, height: 10))
        leftView = spaceView
        leftViewMode = .always

    }
}
