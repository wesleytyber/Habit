//
//  SignInErrorResponse.swift
//  Habit
//
//  Created by Wesley Calazans on 08/01/22.
//

import Foundation

struct SignInErrorResponse: Decodable {
    
    let detail: SignInDetailErrorResponse
    
    enum CodingKeys: String, CodingKey {
        case detail
        
    }
}

struct SignInDetailErrorResponse: Decodable {
    
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message
        
    }
}

