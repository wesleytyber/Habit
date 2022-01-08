//
//  ErrorResponse.swift
//  Habit
//
//  Created by Wesley Calazans on 07/01/22.
//

import Foundation

struct ErrorResponse: Decodable {
    let detail: String
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}
