//
//  HomeViewModel.swift
//  curso-tiago-aguiar-ios-app-habit
//
//  Created by Wesley Calazans on 31/12/21.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    let habitViewModel = HabitViewModel(isCharts: false, interactor: HabitInteractor())
    let habitForChartsViewModel = HabitViewModel(isCharts: true, interactor: HabitInteractor())
    let profileViewModel = ProfileViewModel(interactor: ProfileInteractor())
}

extension HomeViewModel {
    func habitView() -> some View {
        return HomeViewRouter.makeHabitView(viewModel: habitViewModel)
    }
    
    func profileView() -> some View {
        return HomeViewRouter.makeProfileView(viewModel: profileViewModel)
    }
    
    func habitForChartView() -> some View {
        return HomeViewRouter.makeHabitView(viewModel: habitForChartsViewModel)
    }
}
