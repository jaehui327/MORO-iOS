//
//  Enums.swift
//  MORO
//
//  Created by 이재성 on 29/07/2018.
//  Copyright © 2018 김재희. All rights reserved.
//

import UIKit

enum levels: String {
    case lv0 = "0", lv1 = "1", lv2 = "2", lv3 = "3", Lv4 = "4"
    
    func getImage() -> UIImage {
        switch self {
        case .lv0:
            return #imageLiteral(resourceName: "Lv0")
        case .lv1:
            return #imageLiteral(resourceName: "Lv1")
        case .lv2:
            return #imageLiteral(resourceName: "Lv2")
        case .lv3:
            return #imageLiteral(resourceName: "Lv3")
        case .Lv4:
            return #imageLiteral(resourceName: "Lv4")
        }
    }
}
