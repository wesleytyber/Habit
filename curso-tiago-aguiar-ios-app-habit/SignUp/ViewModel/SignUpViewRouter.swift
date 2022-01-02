//
//  SignUpViewRouter.swift
//  curso-tiago-aguiar-ios-app-habit
//
//  Created by Wesley Calazans on 31/12/21.
//

import SwiftUI
import Combine

enum SignUpViewRouter {
    static func makeHomeView(publisher: PassthroughSubject<Bool, Never>) -> some View {
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
}

