//
//  HabitRemoteDataSource.swift
//  Habit
//
//  Created by Wesley Calazans on 20/01/22.
//

import Foundation
import Combine

class HabitDetailRemoteDataSource {
    
    static var shared: HabitDetailRemoteDataSource = HabitDetailRemoteDataSource()
    
    private init () {
    }
    
    func save(habitId: Int, request: HabitValueRequest) -> Future<Bool , AppErrorModel> {
        return Future<Bool, AppErrorModel> { promise in
            let path = String(format: WebService.Endpoint.habitValues.rawValue , habitId)
            
            WebService.call(path: path, method: .post, body: request )
            { Result in
                switch Result {
                case .failure(_, let data):
                    if let data = data {
                        
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(SignInErrorResponse.self, from: data)
                        // completion(nil, response )
                        promise(.failure(AppErrorModel.response(message: response?.detail.message ?? "Error desconhecido no servidor")))
                        
                    }
                    break
                case .success(_):
                    
                    promise(.success(true))
                    
                    break
                }
            }
        }
    }
}

