//
//  HabitCreateInteractor.swift
//  Habit
//
//  Created by Wesley Calazans on 01/02/22.
//

import Foundation
import Combine

class HabitCreateInteractor {
    
    private let remote: HabitCreateRemoteDataSource = .shared
}

extension HabitCreateInteractor {
    func save(habitCreateRequest request: HabitCreateRequest) -> Future<Void, AppErrorModel> {
       return remote.save(request: request)
    }
}
