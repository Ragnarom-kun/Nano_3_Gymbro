import SwiftUI
import SwiftData

struct InputView: View {
    @Environment(\.modelContext) public var context
    @Query public var exercises: [ExerciseName]
    @StateObject var viewModel = ExerciseViewModel()
    @State private var navigateToExerciseListView = false
    
    var RM: Double = 60
    var PR: Double = 60
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Added RM: \(Int(RM))")
                Text("Added PR: \(Int(PR))")
                
                if let activeExercise = viewModel.activeExercise {
                    Text("Chosen exercise: \(activeExercise.name)")
                } else {
                    Text("No exercise selected")
                }

                NavigationLink(destination: ExerciseListView().navigationBarBackButtonHidden(true), isActive: $navigateToExerciseListView) {
                    Text("Choose Exercise").font(.title)
                }

//                Button(action: {
//                    if let selectedExercise = viewModel.activeExercise {
//                        viewModel.addArray(item: selectedExercise, PR: PR, RM: RM, context: context)
//                    }
//                }) {
//                    Text("Add RM and PR to Exercise")
//                }
//                .padding()
                
                ProgressiveOverloadPlanView()
            }
            .padding()
        }
        .environmentObject(viewModel)
    }
}

#Preview {
    InputView()
}
