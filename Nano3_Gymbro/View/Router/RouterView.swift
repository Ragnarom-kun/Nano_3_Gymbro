//
//  RouterView.swift
//  Nano3_Gymbro
//
//  Created by Romi Fadhurohman Nabil on 11/07/24.
//
import SwiftUI

struct RouterView<Content: View>: View {
    @StateObject var router: Router = Router()
    @StateObject var viewModel: RMCalculatorViewModel = RMCalculatorViewModel()
    @StateObject var viewModelExercise: ExerciseViewModel = ExerciseViewModel()
    @Environment(\.modelContext) private var modelContext
    // Our root view content
    private let content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            content
                .navigationDestination(for: Router.Route.self) { route in
                    router.view(for: route)
                }.onAppear().task {
                    ExerciseName.reloadSampleData(modelContext: modelContext)
                }
        }
        .environmentObject(router)
        .environmentObject(viewModel)
        .environmentObject(viewModelExercise)
    }
}
