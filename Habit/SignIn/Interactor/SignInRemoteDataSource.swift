//
//  RemoteDataSource.swift
//  Habit
//
//  Created by Wesley Calazans on 16/01/22.
//

import Foundation
import Combine

class SignInRemoteDataSource {
    // padrao singleton
    // temos apenas 1 unico objeto vivo rodando dentro da aplicacao
    
    static var shared: SignInRemoteDataSource = SignInRemoteDataSource()
    
    private init () {
    }
    
    func login(request: SignInRequest) -> Future<SignInResponse, AppErrorModel> {
        return Future<SignInResponse, AppErrorModel> { promise in
            WebService.call(path: .login, params: [
                URLQueryItem(name: "username", value: request.email),
                URLQueryItem(name: "password", value: request.password)
            ])
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

