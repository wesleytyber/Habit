//
//  TabbarView.swift
//  Habit
//
//  Created by Wesley Calazans on 09/01/22.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            HomeView(viewModel: HomeViewModel())
                .tabItem {
                    Label ("Home", systemImage: "house")
                }
            DetailView()
                .tabItem {
                    Label ("More", systemImage: "plus.circle")
                }
            HomeView(viewModel: HomeViewModel())
                .tabItem {
                    Label ("Favorite", systemImage: "heart")
                }
            HomeView(viewModel: HomeViewModel())
                .tabItem {
                    Label ("Settings", systemImage: "gear")
                }
        }
        
    }
    
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { value in
            TabBarView()
                .previewDevice("iPhone 12")
                .preferredColorScheme(value)
        }
        
    }
}
