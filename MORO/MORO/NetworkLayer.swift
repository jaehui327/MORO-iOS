//
//  NetworkLayer.swift
//  MORO
//
//  Created by 이재성 on 29/07/2018.
//  Copyright © 2018 김재희. All rights reserved.
//

import UIKit
import Alamofire

protocol Requestable {
    associatedtype ResponseType: Codable
    
    var endpoint: String { get }
    var method: Network.Method { get }
    var query:  Network.QueryType { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
    var timeout : TimeInterval { get }
    var cachePolicy : NSURLRequest.CachePolicy { get }
}

extension Requestable {
    
    var defaultJSONHeader : [String: String] {
        return ["Content-Type": "application/json"]
    }
}


enum NetworkResult<T> {
    case success(T)
    case cancel(Error?)
    case failure(Error?)
}

class Network {
    public enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    public enum QueryType {
        case json, path
    }
    
    @discardableResult
    static func request<T: Requestable>(req: T, completionHandler: @escaping (NetworkResult<T.ResponseType>) -> Void) -> DataRequest? {
        let url = URL.init(string: "http://192.168.0.148:8080/"+req.endpoint)
        let request = prepareRequest(for: url!, req: req)
        
        return Alamofire.request(request).responseJSON { (response) in
            
            if let err = response.error {
                
                if let urlError = err as? URLError, urlError.code == URLError.cancelled {
                    // cancelled
                    completionHandler(NetworkResult.cancel(urlError))
                } else {
                    // other failures
                    completionHandler(NetworkResult.failure(err))
                }
                return
            }
            
            if let data = response.data {
                let decoder = JSONDecoder()
                
                do {
                    let object = try decoder.decode(T.ResponseType.self, from: data)
                    completionHandler(NetworkResult.success(object))
                } catch let error {
                    completionHandler(NetworkResult.failure(error))
                }
            }
        }
    }
}

extension Network {
    private static func prepareRequest<T: Requestable>(for url: URL, req: T) -> URLRequest {
        var request : URLRequest? = nil
        
        switch req.query {
        case .json:
            request = URLRequest(url: url, cachePolicy: req.cachePolicy,
                                 timeoutInterval: req.timeout)
            if let params = req.parameters {
                do {
                    let body = try JSONSerialization.data(withJSONObject: params, options: [])
                    request!.httpBody = body
                } catch {
                    assertionFailure("Error : while attemping to serialize the data for preparing httpBody \(error)")
                }
            }
        case .path:
            var query = ""
            
            req.parameters?.forEach { key, value in
                query = query + "\(key)=\(value)&"
            }
            
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            components.query = query
            request = URLRequest(url: components.url!, cachePolicy: req.cachePolicy, timeoutInterval: req.timeout)
            
            if let params = req.parameters {
                do {
                    let body = try JSONSerialization.data(withJSONObject: params, options: [])
                    request!.httpBody = body
                } catch {
                    assertionFailure("Error : while attemping to serialize the data for preparing httpBody \(error)")
                }
            }
        }
        
        request!.allHTTPHeaderFields = req.headers
        request!.httpMethod = req.method.rawValue
        
        return request!
    }
}
