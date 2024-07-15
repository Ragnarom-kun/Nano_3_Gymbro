//
//  ProgressiveOverloadPlan.swift
//  Nano3_Gymbro
//
//  Created by Shan Havilah on 14/07/24.
//

import SwiftUI

struct ProgressiveOverloadPlanView: View {
    @State var RPE: Double = 1
    @State var RPEStatic: Double = 1
    var RPEList = [1, 2, 3, 4, 5, 6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5, 10]
    @State private var showInfo = false
    @EnvironmentObject var viewModel: ExerciseViewModel
    var body: some View {
        Section {
            HStack(alignment: .top) {
                Image(systemName: "note.text")
                Text("Progressive Overload Plan")
                    .font(.body)
                    .fontWeight(.semibold)
                Spacer()
            }
            .listRowSeparator(.hidden)
            .foregroundStyle(.orange)

            HStack {
                Text("RPE")
                Picker("", selection: $RPE) {
                    ForEach(RPEList, id: \.self) { rpe in
                        Text(String(format: "%.1f", rpe)).tag(rpe)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            Divider()
            HStack {
                Button(action: {
                    showInfo = true
                }) {
                    Text("What is RPE")
                }
                Spacer()
                .sheet(isPresented: $showInfo) {
                    WhatRPEView()
                        .presentationDetents([.height(726)])
                }
            }

            Button(action: {
                if let activeExercise = viewModel.activeExercise,
                   !activeExercise.sortedListRM.isEmpty {
                    viewModel.calculateTrainingPlan(RPE: RPE)
                    viewModel.setShowDetails(true)
                    RPEStatic = RPE
                } else {
                    print("Tidak bisa calculate")
                }

            }, label: {
                Text("Generate Plan")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .foregroundStyle(.white)
                    .background(.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 12.0))
            })
        }
        .listSectionSeparator(.hidden, edges: .top)
        
        if viewModel.showDetails == true{
            Divider()
            Section{
                HStack(alignment: .top) {
                    Image(systemName: "pencil.and.outline")
                    Text("Your Plan")
                        .font(.body)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .listRowSeparator(.hidden)
                .foregroundStyle(.orange)
                
                HStack{
                    Text("Increase to \(viewModel.activeBebanTambahan!) kg")
                        .fontWeight(.semibold)
                    Spacer()
                    Image(systemName: "dumbbell.fill")
                }
                .foregroundStyle(.blue)
                .padding(.vertical, 10)
                .padding(.horizontal, 16)
                .background(Color.abuDefault)
                .cornerRadius(8)
                
                HStack{
                    Text("RPE: \(RPEStatic)")
                        .fontWeight(.semibold)
                    Spacer()
                    Text("Current Weight: \(viewModel.activeExercise!.sortedListRM.last!.value) kg")
                        .fontWeight(.semibold)
                }
                
                Text("Based on your RPE of \(RPEStatic), you should add \(viewModel.activePersenan!)% to your current weight of \(viewModel.activeExercise!.sortedListRM.last!.value) kg. Increase it to \(viewModel.activeBebanTambahan!) kg to keep progressing and building strength. Keep up the great work!")
                Spacer()
            }
        }
    }
}
