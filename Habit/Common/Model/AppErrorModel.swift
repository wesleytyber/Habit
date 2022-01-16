//
//  AppErrorModel.swift
//  Habit
//
//  Created by Wesley Calazans on 16/01/22.
//

import Foundation

enum AppErrorModel: Error {
    case response(message: String)
    
    public var message: String  {
        switch self {
        case .response(let message):
            return message
        }
    }
}
