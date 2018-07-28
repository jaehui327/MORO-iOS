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
