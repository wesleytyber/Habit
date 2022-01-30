//
//  ChartInteractor.swift
//  Habit
//
//  Created by Wesley Calazans on 27/01/22.
//

import Foundation
import Combine

class ChartInteractor {
    
    private let remote: ChartRemoteDataSource = .shared
}

extension ChartInteractor {
    
    func fetchHabitValues(habitId: Int) -> Future<[HabitValueResponse], AppErrorModel> {
        return remote.fetchHabitValues(habitId: habitId)
    }
}
