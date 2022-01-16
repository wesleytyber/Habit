//
//  SplashViewModel.swift
//  curso-tiago-aguiar-ios-app-habit
//
//  Created by Wesley Calazans on 30/12/21.
//

import SwiftUI
import Combine

class SplashViewModel: ObservableObject {
    
    @Published var uiState: SplashUIState = .loading
    
    private var cancellableAuth: AnyCancellable?
    
    private var cancellableRefresh: AnyCancellable?
    
    private let interactor: SplashInteractor
    
    init (interactor: SplashInteractor) {
        self.interactor = interactor
        
    }
    
    deinit {
        cancellableAuth?.cancel()
        cancellableRefresh?.cancel()
    }
    
    func onAppear() {
        cancellableAuth = interactor.fecthAuth()
            .receive(on: DispatchQueue.main)
            .sink {  userAuth in
                // e userauth == nulo -> Login
                if userAuth == nil {
                    self.uiState = .goToSignInScreen
                    
                }
                // senao se userAuth != null && expirou
                else if (Date().timeIntervalSince1970 > Double(userAuth!.expires)) {
                    // refresh_token
                    let request = RefreshRequestModel(token: userAuth!.refreshToken)
                    self.cancellableRefresh = self.interactor.refreshToken(refreshRequest: request)
                        .receive(on: DispatchQueue.main)
                        .sink(receiveCompletion: { completion in
                            switch(completion) {
                            case .failure(_):
                                self.uiState = .goToSignInScreen
                                break
                            default:
                                break
                            }
                        }, receiveValue: { success in
                            
                            let auth =  UserAuth(idToken: success.accessToken,
                                                 refreshToken: success.refreshToken,
                                                 expires: Date().timeIntervalSince1970 + Double (success.expires),
                                                 tokenType: success.tokenType)
                            
                            self.interactor.insertAuth(userAuth: auth)
                            print(success)
                            self.uiState = .goToHomeScreen
                            
                        })
                    
                }
                
                // senao -> Tela principal
                else {
                    self.uiState = .goToHomeScreen
                }
            }
    }
}


extension SplashViewModel {
    func signInView() -> some View {
        return SplashViewRouter.makeSignInView()
    }
}
