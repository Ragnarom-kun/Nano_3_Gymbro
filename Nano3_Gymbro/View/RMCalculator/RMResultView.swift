//
//  RMResultView.swift
//  Nano3_Gymbro
//
//  Created by Dinda Ayu Syafitri on 11/07/24.
//

import SwiftUI

struct Customer: Identifiable {
    let id = UUID()
    let name: String
    let email: String
    let creationDate: Date
}

struct RMResultView: View {
    @EnvironmentObject var viewModel: RMCalculatorViewModel
    @EnvironmentObject var viewModelExercise: ExerciseViewModel
    @Environment(\.modelContext) public var context
    @Binding var unit: String
    @State private var showAlert = false
    let percentages = [96, 92, 89, 86, 84, 81, 79, 76, 74, 71, 68]

    var body: some View {
        Section {
            VStack(spacing: 16) {
                HStack {
                    HStack(alignment: .top) {
                        Image(systemName: "percent")
                        Text("Results")
                            .font(.body)
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.orange)
                    Spacer()
                    Image(systemName: "info.circle")
                        .foregroundStyle(.blue)
                        .onTapGesture(perform: {
                            // routing to "How We Calculate"
                        })
                }

                VStack(spacing: 12) {
                    Text("Your 1RM is ..")
                        .font(.subheadline)
                        .bold()
                    HStack(alignment: .bottom) {
                        Text("\(changeUnit(viewModel.oneRepMax, unit))")
                            .font(.largeTitle)
                            .bold()
                        Text("\(unit)")
                            .font(.subheadline)
                            .bold()
                    }
                    HStack {
                        Image(systemName: "square.and.pencil")
                        Text("Add to Progress")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.tertiary)
                    .clipShape(RoundedRectangle(cornerRadius: 12.0))
                    .onTapGesture {
                        if viewModelExercise.activeExercise != nil && viewModel.oneRepMax != 0.0 {
                            viewModelExercise.addArrayRM(item: viewModelExercise.activeExercise!, RM: viewModel.oneRepMax, context: context)
                            showAlert = true
                        }
                    }
                    .foregroundStyle((viewModelExercise.activeExercise != nil && viewModel.oneRepMax != 0.0) ? Color.blue : Color.gray)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Success"),
                            message: Text("RM has been added to progress."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                }
            }
            .listRowSeparator(.hidden)

            Grid {
                GridRow {
                    Text("Reps")
                    Text("Weight")
                    Text("% of 1RM")
                    Text("Volume")
                }
                .font(.subheadline)
                .fontWeight(.bold)

                Divider()
                    .hidden()

                ForEach(2 ... 12, id: \.self) { item in
                    let weight = viewModel.calculateRMPercentWeight(percentage: percentages[item - 2])

                    GridRow {
                        Text("\(item)")
                        Text("\(changeUnit(weight, unit)) \(unit)")
                        Text("\(percentages[item - 2])")
                        Text("\(changeUnit(viewModel.calculateVolume(weight: weight), unit)) \(unit)")
                    }
                    .font(.subheadline)
                    .fontWeight(.regular)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .listSectionSeparator(.hidden, edges: .top)
    }
}

#Preview {
    RMResultView(unit: .constant("Kg"))
        .environmentObject(RMCalculatorViewModel())
        .environmentObject(ExerciseViewModel())
}
