//
//  HabitCreateView.swift
//  Habit
//
//  Created by Wesley Calazans on 31/01/22.
//

import SwiftUI

struct HabitCreateView: View {
    
    @ObservedObject var viewModel: HabitCreateViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var shouldPresentCamera = false
    
    init(viewModel: HabitCreateViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            VStack(alignment: .center, spacing: 12) {
                Button(action: {
                    self.shouldPresentCamera = true
                }, label: {
                    VStack {
                        viewModel.image!
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(Color.orange)
                        
                        Text("Clique aqui para enviar")
                            .foregroundColor(Color.orange)
                    }
                })
                    .padding(.bottom, 12)
                    .sheet(isPresented: $shouldPresentCamera) {                        ImagePickerView(image: self.$viewModel.image,
                                        imageData: self.$viewModel.imageData,
                                        isPresented: $shouldPresentCamera,
                                        sourceType: .camera)
                    }
            }
            
            VStack {
                TextField("Escreva aqui nome do hábito", text: $viewModel.name)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(PlainTextFieldStyle())
                
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
            }.padding(.horizontal, 32)
            
            VStack {
                TextField("Escreva aqui a unidade de medida", text: $viewModel.label)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(PlainTextFieldStyle())
                
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
            }.padding(.horizontal, 32)
            
            LoadingButtonView(action: {
                viewModel.save()
            }, text: "Salvar",
                              showProgress: self.viewModel.uiState == .loading,
                              disabled: self.viewModel.name.isEmpty || self.viewModel.label.isEmpty)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            
            Button("Cancelar") {
                // dismiss / pop exit
                self.presentationMode.wrappedValue.dismiss()
            }
            .modifier(ButtonStyle())
            .padding(.horizontal, 16)
            
            Spacer()
        }
        .padding(.horizontal, 8)
        .padding(.top, 32 )
        .onAppear {
            viewModel.$uiState.sink { uiState in
                if uiState == .success {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }.store(in: &viewModel.cancellables)
        }
    }
}

struct HabitCreateaView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            HabitCreateView(viewModel: HabitCreateViewModel(interactor: HabitCreateInteractor()))
                .previewDevice("iPhone 13")
                .preferredColorScheme($0)
        }
    }
}
