//
//  RefreshRequestModel.swift
//  Habit
//
//  Created by Wesley Calazans on 16/01/22.
//

import Foundation

struct RefreshRequestModel: Encodable {
  
  let token: String
  
  enum CodingKeys: String, CodingKey {
    case token = "refresh_token"
  }
}

