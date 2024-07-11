//
//  RouterView.swift
//  Nano3_Gymbro
//
//  Created by Romi Fadhurohman Nabil on 11/07/24.
//

import SwiftUI

struct RouterView<Content: View>: View {
    @StateObject var router = Router.shared
    // Our root view content
    private let content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            content
                .navigationDestination(for: Router.Destination.self) { route in
                    routerView(for: route)
                }
        }
        .environmentObject(router)
    }
    
    @ViewBuilder
    private func routerView(for destination: Router.Destination) -> some View {
        RouterViewModel().view(for: destination)
    }
}
