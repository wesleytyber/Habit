//
//  HabitDetailUIState.swift
//  Habit
//
//  Created by Wesley Calazans on 20/01/22.
//

import Foundation

enum HabitDetailUIState: Equatable {
    case none
    case loading
    case success
    case error(String)
    
}
