//
//  HabitDetailViewmodel.swift
//  Habit
//
//  Created by Wesley Calazans on 20/01/22.
//

import Foundation
import SwiftUI
import Combine

class HabitDetailViewModel: ObservableObject {
    
    @Published var uiState: HabitDetailUIState = .none
    @Published var value = ""
    
    private var cancellable: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    var habitPublisher = PassthroughSubject<Bool, Never>()
    
    let id: Int
    let name: String
    let label: String
    let interactor: HabitDetailInteractor
    
    init(id: Int, name: String, label: String, interactor: HabitDetailInteractor ) {
        self.id = id
        self.name = name
        self.label = label
        self.interactor = interactor
    }
    
    deinit {
        cancellable?.cancel()
        for cancellable in cancellables {
            cancellable.cancel()
        }
    }
    
    func save() {
        self.uiState = .loading
        
        cancellable = interactor.save(habitId: id, habitValueRequest: HabitValueRequest(value: value))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {completion in
                switch (completion) {
                case .failure(let appErrorModel):
                    self.uiState = .error(appErrorModel.message)
                    break
                case .finished:
                    break
                }
            }, receiveValue: { created in
                if created {
                    self.uiState = .success
                    self.habitPublisher.send(created)
                }
            })       
    }
}
