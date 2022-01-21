//
//  HabitCardView.swift
//  Habit
//
//  Created by Wesley Calazans on 17/01/22.
//

import SwiftUI
import Combine

struct HabitCardView: View {
    
    @State private var action = false
    
    let viewModel: HabitCardViewModel
    
    var body: some View {
        ZStack(alignment: .trailing) {
            
            NavigationLink(
                destination: viewModel.HabitDetailView(),
                isActive: self.$action,
                label: {
                    EmptyView()
                }
            )
            
            Button(action: {
                self.action = true
            }, label: {
                
                HStack {
                    ImageView(url: viewModel.icon)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 32, height: 32)
                        .clipped()
                    
                    Spacer()
                    
                    HStack(alignment: .top) {
                        
                        VStack(alignment: .leading, spacing: 4) {
                            
                            Text(viewModel.name)
                                .foregroundColor(Color.orange)
                            
                            
                            Text(viewModel.label)
                                .foregroundColor(Color("textColor"))
                                .bold()
                            
                            Text(viewModel.date)
                                .foregroundColor(Color("textColor"))
                                .bold()
                            
                        }.frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            
                            Text("Registrado")
                                .foregroundColor(Color.orange)
                                .bold()
                                .multilineTextAlignment(.leading)
                            
                            Text(viewModel.value)
                                .foregroundColor(Color("textColor"))
                                .bold()
                                .multilineTextAlignment(.leading)
                        }
                    }
                    Spacer(minLength: .maximum(20, 0))
                }
                .padding(.vertical, 4)
                .cornerRadius(4)
            })
            
            Rectangle()
                .frame(width: 8)
                .foregroundColor(viewModel.state)
            
        }.background(
            RoundedRectangle(cornerRadius: 4.0)
                .stroke(Color.orange, lineWidth: 0)
                .shadow(color: .gray, radius: 2, x: 2.0, y: 2.0)
        )
        .padding(.vertical, 4)
    }
}

struct HabitCardView_Previews: PreviewProvider {
    static var previews: some View {
        
        ForEach(ColorScheme.allCases, id: \.self) {
            NavigationView {
                List {
                    HabitCardView(viewModel: HabitCardViewModel(
                        id: 1,
                        icon: "https://via.placeholder.com/150",
                        date: "01/01/2021 00:00",
                        name: "Estudar Alemão",
                        label: "horas",
                        value: "2",
                        state: .green,
                        habitPublisher: PassthroughSubject<Bool, Never>()))
                    
                    HabitCardView(viewModel: HabitCardViewModel(
                        id: 2,
                        icon: "https://via.placeholder.com/150",
                        date: "25/04/2021 00:00",
                        name: "Estudar Russo",
                        label: "horas",
                        value: "1",
                        state: .green, habitPublisher: PassthroughSubject<Bool, Never>()))
                    
                    HabitCardView(viewModel: HabitCardViewModel(
                        id: 3,
                        icon: "https://via.placeholder.com/150",
                        date: "01/11/2021 00:00",
                        name: "Ir para Academia",
                        label: "horas",
                        value: "1",
                        state: .green, habitPublisher: PassthroughSubject<Bool, Never>()))
                    
                }.frame(maxWidth: .infinity)
                    .navigationTitle("Hábitos")
                
            }
            .previewDevice("iPhone 12")
            .preferredColorScheme($0)
        }
    }
}
