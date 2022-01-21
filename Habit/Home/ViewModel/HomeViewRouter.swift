//
//  HomeViewRouter.swift
//  Habit
//
//  Created by Wesley Calazans on 17/01/22.
//

import Foundation
import SwiftUI

enum HomeViewRouter {
    
    static func makeHabitView(viewModel: HabitViewModel) -> some View {
        return HabitView(viewModel: viewModel)
    }
}
