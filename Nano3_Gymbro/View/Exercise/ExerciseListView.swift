import SwiftUI
import SwiftData

struct ExerciseListView: View {
    
    @Environment(\.modelContext) public var context
    @Query public var exercises: [ExerciseName]
    @StateObject private var viewModel = ExerciseViewModel()
    @Binding var activeExercise: ExerciseName?
    @State private var showSheet = false
    @State private var navigateToContentView = false
    
    var body: some View {
        Group {
            if navigateToContentView {
                InputView()
                    .transition(.move(edge: .leading))
            } else {
                NavigationView {
                    VStack {
                        List {
                            ForEach(exercises.sorted(by: { $0.name < $1.name })) { exercise in
                                VStack {
                                    HStack {
                                        Text(exercise.name)
                                            .padding(.vertical, 4)
                                        Spacer()
                                    }
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        activeExercise = exercise // Update activeExercise here
                                        viewModel.setActiveExercise(exercise)
                                        print("Exercise List Active: \(viewModel.activeExercise?.name)")
                                        navigateToContentView = true
                                    }
                                    .swipeActions(edge: .leading) {
                                        Button(role: .destructive) {
                                            viewModel.deleteItem(exercise, context: context)
                                            print("Exercise List Active: \(viewModel.activeExercise?.name)")
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                                }
                                .listRowBackground(Color.clear)
                            }
                        }
                        .listStyle(PlainListStyle()) // Make the list style plain
                    }
                    .navigationTitle("Exercise Type")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                navigateToContentView = true
                            }) {
                                Image(systemName: "chevron.left")
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                showSheet = true
                            }) {
                                Image(systemName: "plus")
                            }
                            .sheet(isPresented: $showSheet) {
                                AddExerciseView()
                                    .presentationDetents([.height(200)])
                            }
                        }
                    }
                }
            }
        }
        .animation(.easeInOut, value: navigateToContentView)
    }
}

struct ExerciseListView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseListView(activeExercise: .constant(nil))
    }
}
