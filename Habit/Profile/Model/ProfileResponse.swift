//
//  ProfileRequest.swift
//  Habit
//
//  Created by Wesley Calazans on 22/01/22.
//

import Foundation

struct ProfileResponse: Decodable {
    // decodable pq busca dados
    
    let id: Int
    let fullName: String
    let email: String
    let document: String
    let phone: String
    let birthday: String
    let gender: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "name"
        case email
        case document
        case phone
        case birthday
        case gender
    }
}

