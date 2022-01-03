//
//  curso_tiago_aguiar_ios_app_habitApp.swift
//  curso-tiago-aguiar-ios-app-habit
//
//  Created by Wesley Calazans on 30/12/21.
//

import SwiftUI

@main
struct Habit: App {
    var body: some Scene {
        WindowGroup {
            SplashView(viewModel: SplashViewModel())
        }
    }
}
