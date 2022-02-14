//
//  HabitCreateRemoteDataSource.swift
//  Habit
//
//  Created by Wesley Calazans on 01/02/22.
//

import Foundation
import Combine

class HabitCreateRemoteDataSource {
    
    static var shared: HabitCreateRemoteDataSource = HabitCreateRemoteDataSource()
    
    private init () {
        
    }
    
    func save(request: HabitCreateRequest) -> Future<Void, AppErrorModel> { return Future<Void, AppErrorModel> { promise in
        WebService.call(path: .habits, params: [
            URLQueryItem(name: "name", value: request.name),
            URLQueryItem(name: "label", value: request.label)
        ],data: request.imageData)
        { Result in
            switch Result {
            case .failure(let error, let data):
                if let data = data {
                    if error == .unathorized {
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(SignInErrorResponse.self, from: data)

                        promise(.failure(AppErrorModel.response(message: response?.detail.message ?? "Error desconhecido no servidor")))
                    }
                }
                break
            case .success(_):
                promise(.success(() ))
                
                break
            }
        }
    }
        
    }
}
