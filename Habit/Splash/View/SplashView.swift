//
//  SplashView.swift
//  Habit
//
//  Created by Wesley Calazans on 30/12/21.
//

import SwiftUI

struct SplashView: View {
    
    @ObservedObject var viewModel: SplashViewModel
    
    var body: some View {
        Group  {
            switch viewModel.uiState {
            case .loading:
                LoadingView()
                
                // navigate to screen
            case .goToSignInScreen:
                viewModel.signInView()
                
                // navigate to screen
            case .goToHomeScreen:
                Text("Home Screen")
                
            case .error(let msg):
                LoadingView(error: msg)
                
            }
        }.onAppear(perform: viewModel.onAppear)
    }
}

extension SplashView {
    func LoadingView(error: String? = nil) -> some View {
        ZStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(100)
                .ignoresSafeArea()
            
            if let error = error {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(title: Text("Habit"), message: Text(error), dismissButton: .default(Text("Ok")) {
                            
                        })
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { value in
            let viewModel = SplashViewModel()
            SplashView(viewModel: viewModel)
                .previewDevice("iPhone 13")
                .preferredColorScheme(value)
        }
    }
}
