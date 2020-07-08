//
//  NetworkService.swift
//  Get newsfeed VK
//
//  Created by Nikola on 04/07/2020.
//  Copyright © 2020 Nikola Krstevski. All rights reserved.
//

import Foundation
import Alamofire

protocol Networking {
    func request(path: String, params: [String: String], completion: @escaping (Data?, Error?) -> Void)
    func requestAF(path: String, params: [String: String], completion: @escaping (AFDataResponse<Data>?) -> Void)
}

final class NetworkService: Networking {
    
    private let authService: AuthService
    
    init(authService: AuthService = SceneDelegate.shared().authService) {
        self.authService = authService
    }
    
    func request(path: String, params: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        guard let token = authService.token else { return }
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
        let url = self.url(from: path, params: allParams)
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
        print(url)
    }
    
    func requestAF(path: String, params: [String : String], completion: @escaping (AFDataResponse<Data>?) -> Void) {
        guard let token = authService.token else { return }
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
        let url = self.url(from: path, params: allParams)
        
        AF.request(url.absoluteString, method: .post, parameters: allParams, encoder: JSONParameterEncoder.default).validate().responseData { (data) in
            print(data)
            
            completion(data)
        }
    }
    
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        })
    }
    
    private func url(from path: String, params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = path
        components.queryItems = params.map {  URLQueryItem(name: $0, value: $1) }
        return components.url!
    }
}