//
//  DetailView.swift
//  Habit
//
//  Created by Wesley Calazans on 09/01/22.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
        Text("Detail Screen")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {value in
            DetailView()
                .previewDevice("iPhone 12")
                .preferredColorScheme(value)
        }
    }
}
