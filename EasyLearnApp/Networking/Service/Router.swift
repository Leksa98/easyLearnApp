//
//  Router.swift
//  EasyLearnApp
//
//  Created by Alexandra Gertsenshtein on 07.07.2020.
//  Copyright © 2020 Alexandra Gertsenshtein. All rights reserved.
//

import Foundation

class Router<EndPoint: EndPointType> {
    
    private var task: URLSessionTask?
    
    /// Generating URL request: creating URLSession, building request and creating task
    /// - Parameters:
    ///   - route: URL request configuration that conforms EndPointType protocol
    ///   - completion: Passing data, response and error in completion
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        do {
            let request = try self.buildRequest(from: route)
            task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                completion(data, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    /// Converting EndPoint into URLRequest and then pass it to session
    /// - Parameter route: EndPoint that will be converted
    /// - Throws: Error if unable to convert into URLRequest
    /// - Returns: URLRequest that will be passed in session for doing request
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        
        do {
            switch route.task {
            case .requestParametersAndHeaders(let bodyParameters,
                                              let urlParameters,
                                              let additionalHeaders):
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    /// Transforming request parameters
    /// - Parameters:
    ///   - bodyParameters: Parameters needed to transform into JSON
    ///   - urlParameters: Parameters needed to transform into URL format
    ///   - request: Request which is currently being  generated
    /// - Throws: Errors if unable to encode parameters
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
    
    /// Adding headers to the request
    /// - Parameters:
    ///   - additionalHeaders: Headers needed to be added
    ///   - request: Request which is currently being  generated
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else {
            return
        }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
