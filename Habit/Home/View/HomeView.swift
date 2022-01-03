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
        Text("OLA")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
