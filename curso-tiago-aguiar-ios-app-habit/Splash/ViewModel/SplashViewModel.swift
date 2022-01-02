//
//  SplashViewModel.swift
//  curso-tiago-aguiar-ios-app-habit
//
//  Created by Wesley Calazans on 30/12/21.
//

import SwiftUI

class SplashViewModel: ObservableObject {
    
    @Published var uiState: SplashUIState = .loading
    
    func onAppear() {
        // assincrono e  muda o estado da uiState
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            
            self.uiState = .goToSignInScreen
        }
    }
    
}

extension SplashViewModel {
    func signInView() -> some View {
        return SplashViewRouter.makeSignInView()
    }
}
