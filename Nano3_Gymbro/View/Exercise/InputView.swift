//
//  ContentView.swift
//  inputExercise
//
//  Created by Shan Havilah on 10/07/24.
//

import SwiftUI
import SwiftData

struct InputView: View {
    @Environment(\.modelContext) public var context
    @Query public var exercises: [ExerciseName]
    @State private var activeExercise: ExerciseName?
    @StateObject private var viewModel = ExerciseViewModel()
    
    var RM: Double = 50
    var PR: Double = 50
    
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

                NavigationLink(destination: ExerciseListView(activeExercise: $activeExercise)
                    .navigationBarBackButtonHidden()
                ){
                    Text("Choose Exercise").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                }
                
                Button(action: {
                    // Add RM and PR to the selected exercise
                    if let selectedExercise = viewModel.activeExercise {
                        viewModel.addArray(item: selectedExercise, PR: PR, RM: RM, context: context)
                        
                        print("Exercise: \(selectedExercise.name)")
                        // Print listPR contents
                        print("PR List:")
                        for pr in selectedExercise.sortedListPR {
                            print("   PR Value: \(pr.value), ID: \(pr.id), Date: \(pr.date)")
                        }
                        print("First PR: \(selectedExercise.sortedListPR.first?.value)")
                        print("Last PR: \(selectedExercise.sortedListPR.last?.value)")
                        
                        // Print listRM contents
                        print("RM List:")
                        for rm in selectedExercise.sortedListRM {
                            print("   RM Value: \(rm.value), ID: \(rm.id), Date: \(rm.date)")
                        }
                        print("First RM: \(selectedExercise.sortedListRM.first?.value)")
                        print("Last RM: \(selectedExercise.sortedListRM.last?.value)")
                        
                    }
                }) {
                    Text("Add RM and PR to Exercise")
                }
                .padding()
            }
            .padding()
        }
        .onAppear {
            // Set the activeExercise to the first exercise if available
            if let firstExercise = exercises.first {
                //activeExercise = firstExercise
                viewModel.setActiveExercise(firstExercise)
                print("Content List Active: \(viewModel.activeExercise)")
            }
            
        }
    }
}

#Preview {
    InputView()
}
