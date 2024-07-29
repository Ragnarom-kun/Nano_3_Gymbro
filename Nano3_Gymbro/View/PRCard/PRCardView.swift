import SwiftData
import SwiftUI

struct PRCardView: View {
    @Query public var exercises: [ExerciseName]
    @EnvironmentObject var viewModel: ExerciseViewModel
    @State private var cards: [Card] = []
    @State var selectedUnits = "Kg"
    @State var units = ["Kg", "lb"]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Picker("", selection: $selectedUnits) {
                    ForEach(units, id: \.self) { unit in
                        Text("\(unit)").tag(unit)
                    }
                }
                .frame(maxWidth: 100)
                .pickerStyle(.segmented)
                .padding(15)
            }
            
         
            .frame(maxWidth: .infinity)
            
            HStack {
                Text("Personal Record")
                    .font(.largeTitle)
                    .bold()
                    .padding(15)
            }
            
            if exercises.isEmpty {
                Text("No Data Available")
                    .foregroundColor(Color("FontColor"))
            } else {
                VStack {
                    ScrollView {
                        let columns = UIDevice.current.userInterfaceIdiom == .pad ? 4 : 2
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: columns)) {
                            ForEach(exercises) { exercise in
                                NavigationLink(destination: DetailView(exerciseName: exercise)) {
                                    CardView(exerciseName: exercise, units: $selectedUnits)
                                }
                            }
                        }
                        .padding()
                    }
                    .background(Color("BackgroundBG"))
                    .navigationTitle("Personal Record")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Picker("", selection: $selectedUnits) {
                                ForEach(units, id: \.self) { unit in
                                    Text(unit).tag(unit)
                                }
                            }
                            .frame(maxWidth: 100)
                            .pickerStyle(SegmentedPickerStyle())
                        }
                    }
                }
                .background(Color("BackgroundBG").edgesIgnoringSafeArea(.all))
            }
        }
        .background(Color("BackgroundBG"))
    }
}
