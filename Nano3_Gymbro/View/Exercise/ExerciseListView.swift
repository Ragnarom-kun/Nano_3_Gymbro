import SwiftUI
import SwiftData

struct ExerciseListView: View {
    @Environment(\.modelContext) public var context
    @Query public var exercises: [ExerciseName]
    @EnvironmentObject var viewModel: ExerciseViewModel
    @Binding var navigateToContentView: Bool
    @State private var showSheet = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
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
                                viewModel.setActiveExercise(exercise, context: context)
                                navigateToContentView = true
                                presentationMode.wrappedValue.dismiss()
                                
                            }
                            .swipeActions(edge: .leading) {
                                Button(role: .destructive) {
                                    viewModel.deleteItem(exercise, context: context)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                        .listRowBackground(Color.clear)
                    }
                }
                .listStyle(PlainListStyle())            }
            .navigationTitle("Exercise Type")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        navigateToContentView = true
                        presentationMode.wrappedValue.dismiss()
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
        .animation(.easeInOut, value: navigateToContentView)
    }
}

//struct ExerciseListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExerciseListView(viewModel: ExerciseViewModel(), navigateToContentView: .constant(false))
//    }
//}
