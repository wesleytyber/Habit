//
//  HomeView.swift
//  curso-tiago-aguiar-ios-app-habit
//
//  Created by Wesley Calazans on 31/12/21.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var  viewModel: HomeViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Home Scren")
                    .foregroundColor(Color.blue)
                    .font(Font.system(.title))
                    .navigationBarTitle("Home", displayMode: .automatic)

                NavigationLink(destination: DetailView()) {
                    
                    Text("Detail screen")
                        .padding()
                        .font(Font.system(.title))
                        .padding(.top, 20)
                        .background(Color("textColor"))
                        .cornerRadius(10)
                        
                }
                
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        ForEach(ColorScheme.allCases, id: \.self) { value in
            HomeView(viewModel: HomeViewModel())
                .previewDevice("iPhone 12")
                .preferredColorScheme(value)
        }
    }
}
