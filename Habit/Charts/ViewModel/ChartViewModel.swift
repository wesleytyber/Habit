//
//  ChartViewModel.swift
//  Habit
//
//  Created by Wesley Calazans on 26/01/22.
//

import Foundation
import SwiftUI
import Charts
import Combine

class ChartViewModel: ObservableObject {
    
    @Published var  uiState = ChartUIState.loading
    
    @Published var entries: [ChartDataEntry] = []
    
    @Published var dates: [String] = []
    
    private let habitId: Int
    private let interactor: ChartInteractor
    
    private var cancellable: AnyCancellable?
    
    init(habitId: Int, interactor: ChartInteractor) {
        self.habitId = habitId
        self.interactor = interactor
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func onAppear() {
        cancellable = interactor.fetchHabitValues(habitId: habitId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch(completion) {
                case .failure(let appErrorModal):
                    self.uiState = .error(appErrorModal.message)
                case.finished:
                    break
                }
            }, receiveValue: { response in
                if response.isEmpty {
                    self.uiState = .emptyChart
                } else {
                    self.dates = response.map { $0.createdDate }
                    
                    self.entries = zip(response.startIndex..<response.endIndex, response).map { index, res in
                        ChartDataEntry(x: Double(index), y: Double(res.value))
                    }
                    
                    self.uiState = .fullChart
                }
            })
    }
}
