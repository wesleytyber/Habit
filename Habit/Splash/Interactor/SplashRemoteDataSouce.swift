//
//  SplashRemoteDataSouce.swift
//  Habit
//
//  Created by Wesley Calazans on 16/01/22.
//

import Foundation
import Combine

class SplashRemoteDataSource {

    static var shared: SplashRemoteDataSource = SplashRemoteDataSource()
    
    private init () {
    }
    
    func refreshToken(request: RefreshRequestModel) -> Future<SignInResponse, AppErrorModel> {
        return Future<SignInResponse, AppErrorModel> { promise in
            WebService.call(path: .refreshToken, method:.put, body: request)
            { Result in
                switch Result {
                case .failure(let error, let data):
                    if let data = data {
                        if error == .unathorized {
                            let decoder = JSONDecoder()
                            let response = try? decoder.decode(SignInErrorResponse.self, from: data)
                            // completion(nil, response )
                            promise(.failure(AppErrorModel.response(message: response?.detail.message ?? "Error desconhecido no servidor")))
                            
                        }
                    }
                    break
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode(SignInResponse .self, from: data)
                    // completion(response, nil)
                    guard let response = response else {
                        print("Log: error parser \(String(data: data, encoding: .utf8)!)")
                        return
                    }
                    
                    promise(.success(response))
                    break
                }
            }
        }
    }
}
