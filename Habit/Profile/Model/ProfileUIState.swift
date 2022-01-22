//
//  ProfileUIState.swift
//  Habit
//
//  Created by Wesley Calazans on 22/01/22.
//

import Foundation

enum ProfileUIState: Equatable {
    case none
    case loading
    case fetchSuccess
    case fetchError(String)
    
    case updateLoading
    case updateSuccess
    case updateError(String)
}
