//
//  WebService.swift
//  Habit
//
//  Created by Wesley Calazans on 06/01/22.
//

import Foundation

enum WebService {
    
    enum Endpoint: String {
        case baseURL = "https://habitplus-api.tiagoaguiar.co"
        case postUser = "/users"
        case login = "/auth/login"
    }
    
    enum NetworkError {
        case badRequest
        case notFound
        case unathorized
        case internalServerError
    }
    
    enum Result {
        case success(Data)
        case failure(NetworkError, Data?)
    }
    
    enum ContentType: String  {
        case json = "application/json"
        case formUrl = "application/x-www-form-urlencoded"
    }
    
    private static func completeURL(path:Endpoint) -> URLRequest? {
        guard let url = URL(string: "\(Endpoint.baseURL.rawValue)\(path.rawValue)") else {return nil}
        
        return URLRequest(url: url)
    }
    
    private static func call(path: Endpoint,
                             contentType: ContentType,
                             data: Data?,
                             completion: @escaping (Result) -> Void)
    {
        guard var urlRequest = completeURL(path: path) else { return }
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("aplication/json", forHTTPHeaderField: "accept")
        urlRequest.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = data
        
        let task  = URLSession.shared.dataTask(with: urlRequest) {data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.internalServerError, nil ))
                return
            }
            
            if let r = response as? HTTPURLResponse{
                
                switch r.statusCode {
                case 400:
                    completion(.failure(.badRequest, data))
                    break
                case 401:
                    completion(.failure(.unathorized, data))
                case 200:
                    completion(.success(data))
                default:
                    break
                }
            }
        }
        
        task.resume()
    }
    
    public static func call<T: Encodable>(path: Endpoint,
                                          body: T,
                                          completion: @escaping (Result) -> Void) {
        
        guard let jsonData = try? JSONEncoder().encode(body) else { return }
        
        call(path: path, contentType: .json, data: jsonData, completion: completion)
    }
    
    public static func call(path: Endpoint,
                            params: [URLQueryItem],
                            completion: @escaping (Result) -> Void) {
        guard let urlRequest = completeURL(path: path) else { return }
        
        guard let absoluteURL = urlRequest.url?.absoluteString else { return }
        var components = URLComponents(string: absoluteURL)
        components?.queryItems = params
        
        call(path: path,
             contentType: .formUrl,
             data: components?.query?.data(using: .utf8),
             completion: completion)
    }
    
}
