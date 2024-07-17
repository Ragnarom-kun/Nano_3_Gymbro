//
//  ContentView.swift
//  Nano3_Gymbro
//
//  Created by Romi Fadhurohman Nabil on 08/07/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        RouterView {
            TabView {
                RMCalculatorView()
                    .tabItem {
                        Label("Calculator", systemImage: "percent")
                    }
                ProgressView()
                    .tabItem {
                        Label("Progress", systemImage: "chart.xyaxis.line")
                    }
                PRCardView()
                    .tabItem {
                        Label("Personal Record", systemImage: "dumbbell")
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
