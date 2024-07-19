import SwiftUI
import SwiftData

struct ExerciseListView: View {
    @Environment(\.modelContext) public var context
    @Query public var exercises: [ExerciseName]
    @EnvironmentObject var viewModel: ExerciseViewModel
    @State private var showSheet = false
    @State private var showDetails = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
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
                                viewModel.setShowDetails(false)
                                presentationMode.wrappedValue.dismiss()
                            }
                            .swipeActions(edge: .leading) {
                                Button(role: .destructive) {
                                    viewModel.deleteItem(exercise, context: context)
                                    viewModel.setShowDetails(false)
                                    print("ShowDetails: \(viewModel.showDetails)")
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                        .listRowBackground(Color.clear)
                    }
                }
                .listStyle(PlainListStyle())           
            }
            .navigationTitle("Exercise Type")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
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
        .navigationBarBackButtonHidden()
    }
}

//struct ExerciseListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExerciseListView(viewModel: ExerciseViewModel(), navigateToContentView: .constant(false))
//    }
//}
