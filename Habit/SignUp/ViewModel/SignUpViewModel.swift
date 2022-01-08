//
//  SignUpViewModel.swift
//  curso-tiago-aguiar-ios-app-habit
//
//  Created by Wesley Calazans on 31/12/21.
//

import SwiftUI
import Combine

class SignUpViewModel: ObservableObject {
    @Published var fullName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var document = ""
    @Published var number = ""
    @Published var birthday = ""
    @Published var gender = Gender.male
    
    var publisher: PassthroughSubject<Bool, Never>!
    
    @Published var uiState: SignUpUIState = .none
    
    func signUp() {
        self.uiState = .loading
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        
        let dateFormatted = formatter.date(from: birthday)
        
        // validar a data
        guard let dateFormatted = dateFormatted else {
            self.uiState = .error("Data inválida \(birthday)")
            return
        }
        
        // conversao data
        formatter.dateFormat = "yyyy-MM-dd"
        let birthday = formatter.string(from: dateFormatted)
        
        WebService.postUser(request: SignUpRequest(fullName: fullName,
                                                   email: email,
                                                   password: password,
                                                   document: document,
                                                   phone: number,
                                                   birthday: birthday,
                                                   gender: gender.index )) { (successResponse, errorResponse) in
            if let error = errorResponse {
                DispatchQueue.main.async {
                    self.uiState = .error(error.detail)
                }
            }
            if let success = successResponse {
                WebService.login(request: SignInRequest(email: self.email, password: self.password )) { (successResponse, errorResponse) in
                    
                    if let errorSignIn = errorResponse {
                        DispatchQueue.main.async {
                            self.uiState = .error(errorSignIn.detail.message)
                        }
                    }
                    if let successSignIn = successResponse {
                        DispatchQueue.main.async {
                            print(successSignIn)
                            self.publisher.send(success)
                            self.uiState = .success
                        }
                    }
                }
                
            }
        }
    }
}

extension SignUpViewModel {
    func homeView() -> some  View {
        return SignUpViewRouter.makeHomeView(publisher: publisher)
    }
}
