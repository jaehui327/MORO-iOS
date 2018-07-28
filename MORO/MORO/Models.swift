//
//  Models.swift
//  MORO
//
//  Created by 이재성 on 29/07/2018.
//  Copyright © 2018 김재희. All rights reserved.
//

import UIKit

struct EmptyModel: Codable {
}

struct MainModel: Codable {
    let level, alarmTime, numOfUsers, roomName, roomRequirement, leftUsers, isSelected: String
}
