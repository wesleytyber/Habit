//
//  ProfileEditText.swift
//  Habit
//
//  Created by Wesley Calazans on 03/02/22.
//

import Foundation
import SwiftUI

struct ProfileTextView: View {
    
    @Binding var text: String
    
    var placeholder: String = ""
    var mask: String? = nil
    var keyboard: UIKeyboardType = .default
    var autocaptalization: UITextAutocapitalizationType = .none
    
    var body: some View {
        VStack {
            
            TextField(placeholder, text: $text)
                .foregroundColor(Color("textColor"))
                .keyboardType(keyboard)
                .autocapitalization(autocaptalization)
                .multilineTextAlignment(.trailing)
                .onChange(of: text) { value in
                    if let mask = mask {
                        
                        Mask.mask(mask: mask, value: value, text: &text )
                    }
                }
        }
        .padding(.bottom, 10)
    }
}

struct ProfileTextView_Previews: PreviewProvider {
    static var previews: some View {
        
        ForEach(ColorScheme.allCases, id: \.self) { value in
            
            VStack {
                ProfileTextView(text: .constant(""), placeholder: "Celular ")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .previewDevice("iPhone 12")
            .preferredColorScheme(value)
        }
    }
}
