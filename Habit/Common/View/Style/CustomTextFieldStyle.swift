//
//  CustomTextFieldStyle.swift
//  curso-tiago-aguiar-ios-app-habit
//
//  Created by Wesley Calazans on 01/01/22.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
            .overlay(
            RoundedRectangle(cornerRadius: 10)
            .stroke(Color.orange, lineWidth: 0.8)
                .multilineTextAlignment(.leading)
            )
    }
}
