//
//  HabitDetailInteractor.swift
//  Habit
//
//  Created by Wesley Calazans on 20/01/22.
//

import Foundation
import Combine

class HabitDetailInteractor {
    
    private let remote: HabitDetailRemoteDataSource = .shared
}

extension HabitDetailInteractor  {
    func save(habitId: Int, habitValueRequest request: HabitValueRequest) -> Future<Bool, AppErrorModel> {
       return  remote.save(habitId:  habitId, request: request)
    }
}
