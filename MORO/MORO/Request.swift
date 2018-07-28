//
//  Request.swift
//  MORO
//
//  Created by 김재희 on 2018. 7. 29..
//  Copyright © 2018년 김재희. All rights reserved.
//

import UIKit
import Alamofire
import FCUUID

final class CreateRoomRequest: Requestable {
    typealias ResponseType = EmptyModel
    var alarmTime: String
    var NumOfUsers: String
    var roomName: String
    var userRequirement: String
    var tokenKey: String
    var deviceNum: String
    
    init(alarmTime: String, NumOfUsers: String, roomName: String, userRequirement: String, tokenKey: String) {
        self.alarmTime = alarmTime
        self.NumOfUsers = NumOfUsers
        self.roomName = roomName
        self.userRequirement = userRequirement
        self.tokenKey = tokenKey
        self.deviceNum = FCUUID.uuidForDevice()
    }
    
    var endpoint: String {
        return "alarm"
    }
    
    var method: Network.Method {
        return .post
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String: Any]? {
        let parm = ["alarmTime": self.alarmTime, "NumOfUsers": self.NumOfUsers, "roomName": self.roomName, "userRequirement": self.userRequirement, "tokenKey": self.tokenKey, "deviceNum": self.deviceNum]
        return parm
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]  // the request is JSON

    }
    
    var timeout: TimeInterval {
        return 30.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}

final class MainRequest: Requestable {
    typealias ResponseType = MainModel
    
    init() {}
    
    var endpoint: String {
        return "main"
    }
    
    var method: Network.Method {
        return .get
    }
    
    var query: Network.QueryType {
        return .path
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var headers: [String: String]? {
        return ["deviceId": FCUUID.uuidForDevice()]
    }
    
    var timeout: TimeInterval {
        return 30.0
    }
    
    var cachePolicy: NSURLRequest.CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }
}
