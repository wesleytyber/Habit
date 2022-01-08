//
//  GenderModel.swift
//  curso-tiago-aguiar-ios-app-habit
//
//  Created by Wesley Calazans on 31/12/21.
//

import Foundation

enum Gender: String, CaseIterable, Identifiable {
    case male = "Masculino"
    case female = "Feminino"
    
    var id: String {
        self.rawValue
    }
    
    var index: Self.AllCases.Index {
        return Self.allCases.firstIndex { self == $0 } ?? 0
    }
}
