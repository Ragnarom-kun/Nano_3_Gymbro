//
//  ProgressiveOverloadPlan.swift
//  Nano3_Gymbro
//
//  Created by Shan Havilah on 14/07/24.
//

import SwiftUI

struct ProgressiveOverloadPlanView: View {
    @State var RPE: Double = 1
    var RPEList = [1, 2, 3, 4, 5, 6, 6.5, 7, 7.5, 8, 8.5, 9, 9.5, 10]
    @State private var showInfo = false
    @EnvironmentObject var viewModel: ExerciseViewModel
    @State private var showDetails = false
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
//                if((viewModel.activeExercise?.sortedListRM) != nil){
//                    calculateTrainingPlan()
//                }
                calculateTrainingPlan()
                showDetails = true
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
        
        if showDetails{
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
                    Text("Increase to 75 kg")
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
                    Text("RPE: \(RPE)")
                        .fontWeight(.semibold)
                    Spacer()
                    Text("Current Weight: \(viewModel.activeExercise!.sortedListRM.last!.value) kg")
                        .fontWeight(.semibold)
                }
                
                
                Text("Based on your RPE of \(RPE), you should add 10% to your current weight of \(viewModel.activeExercise!.sortedListRM.last!.value) kg. Increase it to 75 kg to keep progressing and building strength. Keep up the great work!")
                Spacer()
            }
        }
    }
    func calculateTrainingPlan (){
        let lastRM = viewModel.activeExercise?.sortedListRM.last?.value
        print("last RM of \(viewModel.activeExercise?.name)= \(lastRM)")
            if(RPE >= 1 && RPE <= 5){
                let x: Double = RPE
                let x1: Double = 1
                let x2: Double = 5
                let y1: Double = 10
                let y2: Double = 15
                
                let kiriAtas = x - x1
                let kiriBawah = x2 - x1
                let kananBawah = y2 - y1
                
                let bagianKiri = kiriAtas * kananBawah
                let bagianKanan = kiriBawah * y1
                
                let y = (bagianKiri + bagianKanan)/kiriBawah
                
                let bebanTambahan = ((lastRM ?? 1) * y)/100
                print("y = \(y)")
                print(bebanTambahan)
                print(bebanTambahan + (lastRM ?? 1))
            }
        
        else if(RPE >= 6 && RPE <= 7){
            let x: Double = RPE
            let x1: Double = 6
            let x2: Double = 7
            let y1: Double = 5
            let y2: Double = 10
            
            let kiriAtas = x - x1
            let kiriBawah = x2 - x1
            let kananBawah = y2 - y1
            
            let bagianKiri = kiriAtas * kananBawah
            let bagianKanan = kiriBawah * y1
            
            let y = (bagianKiri + bagianKanan)/kiriBawah
            
            let bebanTambahan = (lastRM ?? 1) * y
            print("y = \(y)")
        }
        else if(RPE >= 8 && RPE <= 10){
            let x: Double = RPE
            let x1: Double = 8
            let x2: Double = 10
            let y1: Double = 2
            let y2: Double = 5
            
            let kiriAtas = x - x1
            let kiriBawah = x2 - x1
            let kananBawah = y2 - y1
            
            let bagianKiri = kiriAtas * kananBawah
            let bagianKanan = kiriBawah * y1
            
            let y = (bagianKiri + bagianKanan)/kiriBawah
            
            let bebanTambahan = (lastRM ?? 1) * y
            print("y = \(y)")
        }
    }
}
//
//#Preview {
//    ProgressiveOverloadPlanView()
//}
