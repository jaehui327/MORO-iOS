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

struct MainModel: Codable {
    let level, alarmTime, numOfUsers, roomName: String
}

class Request {
    private let host = "http://192.168.0.148:8080/"
    
    func 메인(success: @escaping (MainModel) -> Void) {
        let headers: HTTPHeaders = [
            "deviceId": FCUUID.uuidForDevice(),
            "Accept": "application/json"
        ]
        
        Alamofire.request("\(host)main", headers: headers).responseJSON { response in
            guard let result = response.result.value as? [String: Any] else { return }
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: result, options: .prettyPrinted)
                let reqJSonStr = String(data: jsonData, encoding: .utf8)
                let data = reqJSonStr?.data(using: .utf8)
                let jsonDecoder = JSONDecoder()
                let model = try jsonDecoder.decode(MainModel.self, from: data!)
                success(model)
            } catch {
                
            }
        }
    }
}
