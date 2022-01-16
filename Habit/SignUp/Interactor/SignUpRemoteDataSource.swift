//
//  SignUpRemoteDataSource.swift
//  Habit
//
//  Created by Wesley Calazans on 16/01/22.
//

import Foundation
import Combine

class SignUpRemoteDataSource {
    // padrao singleton
    // temos apenas 1 unico objeto vivo rodando dentro da aplicacao
    
    static var shared: SignUpRemoteDataSource = SignUpRemoteDataSource()
    
    private init () {
        
    }
    
    
    func postUser(request: SignUpRequest) -> Future<Bool, AppErrorModel> {
        return Future { promise in
            WebService.call(path: .postUser, body: request) { Result in
                switch Result {
                    case .failure(let error, let data):
                        if let data = data {
                            if error == .badRequest{
                                let decoder = JSONDecoder()
                                let response = try? decoder.decode(ErrorResponse.self, from: data)
                                promise(.failure(AppErrorModel.response(message: response?.detail ?? "Error interno")))
                            }
                        }
                        break
                        case .success(_):
                    // completion(true, nil)
                    promise(.success(true))
                            break
                }
            }
        }
       
    }
}
