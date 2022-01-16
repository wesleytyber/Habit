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
    
    private let interactor: SignUpInteractor
    
    private var cancellableSignUp: AnyCancellable?
    private var cancellableSignIn: AnyCancellable?
    
    init(interactor: SignUpInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellableSignIn?.cancel()
        cancellableSignUp?.cancel()
    }
    
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
        
        let signUpRequest =  SignUpRequest(fullName: fullName,
                                           email: email,
                                           password: password,
                                           document: document,
                                           phone: number,
                                           birthday: birthday,
                                           gender: gender.index )
        
        cancellableSignUp = interactor.postUser(signUpRequest: signUpRequest)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch (completion) {
                case .failure(let appErrorModel):
                    self.uiState = .error(appErrorModel.message)
                    break
                case .finished:
                    break
                }
            } receiveValue: { created in
                if (created) {
                    // se tiver criado -> login
                    
                    self.cancellableSignIn = self.interactor.login(signInRequest: SignInRequest(email: self.email, password: self.password))
                        .receive(on: DispatchQueue.main)
                        .sink { completion in
                            
                            switch(completion) {
                            case .failure(let appErrorModal):
                                self.uiState = .error(appErrorModal.message)
                                break
                            case .finished:
                                break
                            }
                        }receiveValue: { successSignIn in
                            print(created)
                            self.publisher.send(created)
                            self.uiState = .success
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
