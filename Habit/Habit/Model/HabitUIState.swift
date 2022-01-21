//
//  HabitUIState.swift
//  Habit
//
//  Created by Wesley Calazans on 17/01/22.
//

import Foundation

enum HabitUIState: Equatable {
    case loading
    case emptyList
    case fullList([HabitCardViewModel])
    case error(String)
}
