//
//  RouterViewModel.swift
//  Nano3_Gymbro
//
//  Created by Romi Fadhurohman Nabil on 11/07/24.
//

import Foundation
import SwiftUI

class RouterViewModel: ObservableObject {
    @Published private var router: Router
    
    init(router: Router = .shared) {
        self.router = router
    }
    
    var path: [Router.Destination] {
        get { router.path }
        set { router.path = newValue }
    }
    
    // Used by views to navigate to another view
    func navigateTo(_ destination: Router.Destination) {
        router.path.append(destination)
    }
    
    // Used to go back to the previous screen
    func navigateBack() {
        if !router.path.isEmpty {
            router.path.removeLast()
        }
    }
    
    // Pop to the root screen in our hierarchy
    func popToRoot() {
        router.path.removeAll()
    }
    
    // Builds the views
    @ViewBuilder func view(for destination: Router.Destination) -> some View {
        switch destination {
        case .LineChart:
            LineChartView()
        }
    }
}
