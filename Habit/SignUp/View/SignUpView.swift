//
//  SignUpView.swift
//  curso-tiago-aguiar-ios-app-habit
//
//  Created by Wesley Calazans on 31/12/21.
//

import SwiftUI

struct SignUpView: View {
   
    
    @ObservedObject var viewModel: SignUpViewModel
    
    var body: some View {
        
        ZStack {
            ScrollView (showsIndicators: false) {
                VStack(alignment: .center ) {
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text("Cadastro de usuário")
                            .foregroundColor(Color("textColor"))
                            .font(Font.system(.title).bold())
                            .padding(.bottom, 8)
                        
                        fullNameField
                        
                        emailField
                        
                        passwordField
                        
                        documentField
                        
                        numberField
                        
                        birthdayField
                        
                        genderField
                        
                        saveButton
                    }
                    
                    Spacer()
                    
                }.padding(.horizontal, 8)
                
            }.padding()
            
            if case SignUpUIState.error(let value) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(title: Text("Habit"), message: Text(value), dismissButton: .default(Text("Ok")) {
                            
                        })
                    }
            }
        }
    }
}

extension SignUpView {
    var fullNameField: some View {
        EditTextView(text: $viewModel.fullName,
                     placeholder: "Digite seu nome completo *",
                     keyboard: .alphabet,
                     error: "",
                     failure: viewModel.fullName.count < 3)
    }
}

extension SignUpView {
    var emailField: some View {
        EditTextView(text: $viewModel.email,
                     placeholder: "Digite seu e-mail *",
                     keyboard: .emailAddress,
                     error: "e-mail inválido",
                     failure: !viewModel.email.isEmail())
    }
}

extension SignUpView {
    var passwordField: some View {
        EditTextView(text: $viewModel.password,
                     placeholder: "Digite sua senha *",
                     keyboard: .emailAddress,
                     error: "e-mail inválido",
                     failure: viewModel.password.count < 8,
                     isSecure: true)
    }
}

extension SignUpView {
    var documentField: some View {
        EditTextView(text: $viewModel.document,
                     placeholder: "Digite seu CPF *",
                     keyboard: .numberPad,
                     error: "CPF inválido",
                     failure: viewModel.document.count != 11)
    }
}

extension SignUpView {
    var numberField: some View {
        EditTextView(text: $viewModel.number,
                     placeholder: "Digite seu número de celular *",
                     keyboard: .numberPad,
                     error: "Digite o DDD + 8 ou 9 digitos",
                     failure: viewModel.number.count < 10 || viewModel.number.count >= 12 )
    }
}

extension SignUpView {
    var birthdayField: some View {
        EditTextView(text: $viewModel.birthday,
                     placeholder: "Digite sua data de nascimento *",
                     keyboard: .default,
                     error: "Digite o formato dd/MM/yyyy",
                     failure: viewModel.birthday.count != 10)
    }
}

extension SignUpView {
    var genderField: some View {
        Picker("Gender", selection: $viewModel.gender) {
            ForEach(Gender.allCases, id: \.self) { value in
                Text(value.rawValue)
                    .tag(value )
            }
        }.pickerStyle(SegmentedPickerStyle())
            .padding(.top, 16)
            .padding(.bottom, 32)
    }
}

extension SignUpView {
    var saveButton: some View {
        LoadingButtonView(action: { viewModel.signUp()
            
        }, text: "Realizar o cadastro", showProgress: self.viewModel.uiState == SignUpUIState.loading, disabled:  !viewModel.email.isEmail() ||
                          viewModel.password.count < 8 ||
                          viewModel.fullName.count < 3 ||
                          viewModel.document.count != 11 ||
                          viewModel.number.count < 10 ||  viewModel.number.count >= 12 ||
                          viewModel.birthday.count != 10)
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { value in
            SignUpView(viewModel: SignUpViewModel(interactor: SignUpInteractor()))
                .previewDevice("iPhone 13")
                .preferredColorScheme(value)
        }
        
    }
}
