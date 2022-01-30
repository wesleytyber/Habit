//
//  ChartUIState.swift
//  Habit
//
//  Created by Wesley Calazans on 27/01/22.
//

import Foundation

enum ChartUIState: Equatable {
    case loading
    case emptyChart
    case fullChart
    case error(String)
}
