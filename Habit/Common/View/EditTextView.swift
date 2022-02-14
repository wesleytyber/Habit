 //
//  EditTextView.swift
//  curso-tiago-aguiar-ios-app-habit
//
//  Created by Wesley Calazans on 01/01/22.
//

import SwiftUI

struct EditTextView: View {
    
    @Binding var text: String
    
    var placeholder: String = ""
    var mask: String? = nil
    var keyboard: UIKeyboardType = .default
    var error: String? = nil
    var failure: Bool? = nil
    var isSecure: Bool = false
    var autocaptalization: UITextAutocapitalizationType = .none
    
    var body: some View {
        VStack {
            if isSecure {
                SecureField(placeholder, text: $text)
                    .foregroundColor(Color("textColor"))
                    .keyboardType(keyboard)
                    .textFieldStyle(CustomTextFieldStyle())
            } else {
                TextField(placeholder, text: $text)
                    .foregroundColor(Color("textColor"))
                    .keyboardType(keyboard)
                    .autocapitalization(autocaptalization)
                    .textFieldStyle(CustomTextFieldStyle())
                    .onChange(of: text) { value in
                        if let mask = mask {
                            
                            Mask.mask(mask: mask, value: value, text: &text )
                        }
                    }
            }
            
            if let error = error, failure == true, !text.isEmpty {
                Text(error).foregroundColor(.red)
            }
        }.padding(.bottom, 10)
    }
}

struct EditTextView_Previews: PreviewProvider {
    static var previews: some View {
        
        ForEach(ColorScheme.allCases, id: \.self) { value in
            
            VStack {
                EditTextView(text: .constant(""), placeholder: "E-mail", error: "e-mail inválido", failure: "email@email.com".count < 5)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .previewDevice("iPhone 12")
            .preferredColorScheme(value)
        }
    }
}
