//
//  HabitInteractor.swift
//  Habit
//
//  Created by Wesley Calazans on 18/01/22.
//

import Foundation
import Combine

class HabitInteractor {
    private let remote: HabitRemoteDataSource = .shared
}

extension HabitInteractor {
    func fecthHabits() -> Future<[HabitResponse], AppErrorModel> {
       return remote.fetchHabits()
    }
}
