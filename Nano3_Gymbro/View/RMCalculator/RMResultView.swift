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
    let percentages = [96, 92, 89, 86, 84, 81, 79, 76, 74, 71, 68]
    
    @State private var showInfo = false

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
                    
                    Button(action: {
                        showInfo = true
                    }) {
                        Image(systemName: "info.circle")
                            .foregroundStyle(.blue)
                    }
                    .sheet(isPresented: $showInfo) {
                        HowWeCalculateView()
                            .presentationDetents([.height(726)])
                    }
                }

                VStack(spacing: 12) {
                    Text("Your 1RM is ..")
                        .font(.subheadline)
                        .bold()
                    HStack(alignment: .bottom) {
                        Text("\(viewModel.oneRepMax)")
                            .font(.largeTitle)
                            .bold()
                        Text("Kg")
                            .font(.subheadline)
                            .bold()
                    }
                    Button(action: {}, label: {
                        HStack {
                            Image(systemName: "square.and.pencil")
                            Text("Add to Progress")
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .foregroundStyle(.blue)
                        .background(.tertiary)
                        .clipShape(RoundedRectangle(cornerRadius: 12.0))
                    })
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
                    let weight = viewModel.calculateRMPercentWeight(percentage: percentages[item-2])

                    GridRow {
                        Text("\(item)")
                        Text("\(weight)")
                        Text("\(percentages[item-2])")
                        Text("\(viewModel.calculateVolume(weight: weight)) Kg")
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
    RMResultView()
        .environmentObject(RMCalculatorViewModel())
}
