//
//  habitApp.swift
//  habit
//
//  Created by Wesley Calazans on 30/12/21.
//

import SwiftUI

@main
struct Habit: App {
    var body: some Scene {
        WindowGroup {
            SplashView(viewModel: SplashViewModel(interactor: SplashInteractor()))
        }
    }
}
