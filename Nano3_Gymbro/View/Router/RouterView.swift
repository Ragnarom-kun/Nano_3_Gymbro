//
//  RouterView.swift
//  Nano3_Gymbro
//
//  Created by Romi Fadhurohman Nabil on 11/07/24.
//

import SwiftUI

struct RouteView: View {
    @StateObject private var navPath = Router.shared

    var body: some View {
        NavigationStack(path: $navPath.path) {
            SplashScreenView()
                .toolbar(.hidden)
                .navigationDestination(for: Router.Destination.self) { destination in
                    switch destination {
                    case .Content:
                        ContentView()
                    }
                }
        }
    }
}

#Preview {
    RouterView()
}
