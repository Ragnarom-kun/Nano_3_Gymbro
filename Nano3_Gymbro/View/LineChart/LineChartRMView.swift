//
//  LineChartRMView.swift
//  Nano3_Gymbro
//
//  Created by Romi Fadhurohman Nabil on 16/07/24.
//

import SwiftUI
import Charts
import SwiftData

enum TimeFilter: String, CaseIterable, Identifiable {
    case day, week, month, year
    var id: String { self.rawValue }
}

struct LineChartRMView: View {
    
    @EnvironmentObject var viewModelRMCalculator: RMCalculatorViewModel
    @EnvironmentObject var viewModelExercise: ExerciseViewModel
    @EnvironmentObject var router: Router
    
    @State private var timeFilter: TimeFilter = .day
    @State private var options: [ExerciseRM] = []

    var filteredData: [ExerciseRM] {
        guard let activeExercise = viewModelExercise.activeExercise else {
            return []
        }
        
        let sortedListRM = activeExercise.sortedListRM
        
        switch timeFilter {
        case .day:
            return sortedListRM.filter { Calendar.current.isDateInToday($0.date) }
        case .week:
            return sortedListRM.filter { Calendar.current.isDate($0.date, equalTo: Date(), toGranularity: .weekOfYear) }
        case .month:
            return sortedListRM.filter { Calendar.current.isDate($0.date, equalTo: Date(), toGranularity: .month) }
        case .year:
            return sortedListRM.filter { Calendar.current.isDate($0.date, equalTo: Date(), toGranularity: .year) }
        }
    }

    var body: some View {
        VStack {
            Picker("Time Filter", selection: $timeFilter) {
                ForEach(TimeFilter.allCases) { filter in
                    Text(filter.rawValue.capitalized).tag(filter)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            Chart(filteredData, id: \.id) { rm in
                LineMark(
                    x: .value("Date", rm.date),
                    y: .value("RM Value", rm.value)
                )
            }
            .chartXAxis {
                AxisMarks(values: .automatic(desiredCount: timeFilter == .year ? 12 : 7))
            }
            .chartYAxis {
                AxisMarks()
            }
            .padding()
        }
    }
}

#Preview {
    let context = ModelContext()
    ExerciseName.reloadSampleData(modelContext: context)
    
    LineChartRMView()
        .environmentObject(RMCalculatorViewModel())
        .environmentObject(ExerciseViewModel())
        .environmentObject(Router())
        .environment(\.modelContext, context)
}

