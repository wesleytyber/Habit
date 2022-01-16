//
//  SignInViewModel.swift
//  curso-tiago-aguiar-ios-app-habit
//
//  Created by Wesley Calazans on 30/12/21.
//

import SwiftUI
import Combine

class SignInViewModel: ObservableObject {
    
    @Published var email = ""
    @Published  var password = ""
    
    private var cancellable: AnyCancellable?
    
    private var cancellableRequest: AnyCancellable?

    private let publisher = PassthroughSubject<Bool, Never>()
    
    private let interactor: SignInInteractor
    
    @Published var uiState: SignInUIState = .none
    
    init (interactor: SignInInteractor) {
        self.interactor = interactor
        cancellable  = publisher.sink {value in
            print("Usuário criado! goToHome: \(value)")
            
            if value {
                self.uiState = .goToHomeScreen
            }
        }
    }
    
    deinit {
        cancellable?.cancel()
        cancellableRequest?.cancel()
    }
    
    func login() {
        self.uiState = .loading
        
       cancellableRequest = interactor.login(loginRequest: SignInRequest(email: email, password: password))
            .receive(on: DispatchQueue.main)
            .sink { completion in
                // Aqui acontence o error ou finished
                switch(completion) {
                case .failure(let appErrorModel):
                    self.uiState = SignInUIState.error(appErrorModel.message)
                    break
                case .finished:
                    break
                }
                
            } receiveValue: { success in
                // Aqui acontece o sucesso
                print(success)
                self.uiState = .goToHomeScreen
            }
        
        
//        interactor.login(loginRequest: SignInRequest(email: email, password: password)) { (successResponse, errorResponse) in
//
//            if let error = errorResponse {
//                DispatchQueue.main.async {
//                    self.uiState = .error(error.detail.message)
//                }
//            }
//            if let success = successResponse {
//                DispatchQueue.main.async {
//                    print(success)
//                    self.uiState = .goToHomeScreen
//                }
//            }
//        }
        
    }
}


extension SignInViewModel {
    func homeView() -> some View {
        return SignInViewRouter.makeHomeView()
    }
    
    func signUpView() -> some View {
        return SignInViewRouter.makeSignUpView(publisher: publisher)
    }
}


