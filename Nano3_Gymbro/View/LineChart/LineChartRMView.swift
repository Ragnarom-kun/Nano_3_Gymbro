//
//  LineChartRMView.swift
//  Nano3_Gymbro
//
//  Created by Romi Fadhurohman Nabil on 16/07/24.
//

import SwiftUI
import Charts
import SwiftData

struct LineChartRMView: View {
    @EnvironmentObject var viewModelRMCalculator: RMCalculatorViewModel
    @EnvironmentObject var viewModelExercise: ExerciseViewModel
    @EnvironmentObject var router: Router
    @State private var selection = 0
    let segmentsRM = ["D", "W", "M", "6M", "Y"]
    
    var body: some View {
        if let exerciseName = viewModelExercise.activeExercise {
            VStack {
                HStack {
//                    Text(exerciseName.name)
//                        .font(.title2)
//                        .fontWeight(.bold)
//                        .foregroundColor(.blue)
                    Button(action: {
                        router.navigateTo(.ExerciseListView)
                    }, label: {
                        HStack{
                            Text(viewModelExercise.activeExercise?.name ?? "No Exercise Selected")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                            Image(systemName: "chevron.right")
                        }
                    })
                    Spacer()
                }
                .padding(.horizontal)
                
                Picker(selection: $selection, label: Text("Segments")) {
                    ForEach(0 ..< segmentsRM.count) { index in
                        Text(self.segmentsRM[index])
                            .tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                HStack {
                    Spacer()
                    if let startRM = exerciseName.sortedListRM.first, let lastRM = exerciseName.sortedListRM.last {
                        VStack {
                            Text("Start").foregroundColor(.blue)
                            Text("\(String(format: "%.1f", startRM.value)) kg")
                        }
                        Divider()
                            .background(Color.gray)
                            .frame(height: 30)
                        VStack {
                            Text("Last").foregroundColor(.blue)
                            Text("\(String(format: "%.1f", lastRM.value)) kg")
                        }
                        Divider()
                            .background(Color.gray)
                            .frame(height: 30)
                        VStack {
                            Text("Best").foregroundColor(.blue)
                            Text("\(String(format: "%.1f", exerciseName.RMBest)) kg")
                        }
                    } else {
                        VStack {
                            Text("Start").foregroundColor(.blue)
                            Text("N/A kg")
                        }
                        Divider()
                            .background(Color.gray)
                            .frame(height: 30)
                        VStack {
                            Text("Last").foregroundColor(.blue)
                            Text("N/A kg")
                        }
                        Divider()
                            .background(Color.gray)
                            .frame(height: 30)
                        VStack {
                            Text("Best").foregroundColor(.blue)
                            Text("N/A kg")
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                Chart {
                    ForEach(exerciseName.sortedListRM) { rm in
                        LineMark(
                            x: .value("Date", rm.date, unit: chartUnit(for: selection)),
                            y: .value("Value", rm.value)
                        )
                    }
                }
                .chartXScale(domain: .automatic(includesZero: false))
                .chartYScale(domain: .automatic(includesZero: false))
                .frame(height: 300)
                .padding()
            }
        } else {
            Text("No active exercise selected")
                .padding()
        }
    }
    
    private func chartUnit(for selection: Int) -> Calendar.Component {
        switch segmentsRM[selection] {
        case "D":
            return .day
        case "W":
            return .weekOfYear
        case "M":
            return .month
        case "6M":
            return .month
        case "Y":
            return .year
        default:
            return .day
        }
    }
}

#Preview {
    LineChartRMView()
}
