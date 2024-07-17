//
//  PRDetailView.swift
//  Nano3_Gymbro
//
//  Created by Christian Gunawan on 11/07/24.
//
import SwiftUI
import Charts

struct DetailView: View {
    var exerciseName: ExerciseName
    @StateObject private var viewModel = ExerciseViewModel()
    @State private var selectedItem = 0
    @State private var selection = 0
    @State private var options: [String] = ["Option 1", "Option 2", "Option 3"]
    @State private var isModalPresented = false
    @State private var selectedUnits = "Kg"
    @State private var units = ["Kg", "lb"]

    private let segments = ["D", "W", "M", "Y"]

    var body: some View {
        Section {
            List {
                headerSection
                progressSection
                chartSection
            }
        }
        .navigationTitle("\(exerciseName.name)")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                unitPicker
            }
        }
        .background(Color("BackgroundBG").edgesIgnoringSafeArea(.all))
    }

    private var headerSection: some View {
        Section {
            Spacer()
            HStack {
                Spacer()
                Image(systemName: "dumbbell.fill")
                    .foregroundColor(.orange)
                    .font(.system(size: 80))
                Spacer()
            }
            .listRowSeparator(.hidden)

            HStack(alignment: .firstTextBaseline) {
                Spacer()
                weightText
                Spacer()
            }
            .listRowSeparator(.hidden)

            HStack {
                Spacer()
                lastUpdateText
                Spacer()
            }
            .listRowSeparator(.hidden)

            Button(action: {
                isModalPresented.toggle()
            }) {
                addNewRecordButton
            }
            .listRowSeparator(.hidden)
        }
    }

    private var progressSection: some View {
        Section {
            HStack(alignment: .firstTextBaseline) {
                Image(systemName: "flame")
                Text("Your Progress").bold()
                Spacer()
            }
            .foregroundColor(.orange)
            
            Picker(selection: $selection, label: Text("Segments")) {
                ForEach(0..<segments.count, id: \.self) { index in
                    Text(self.segments[index]).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .listRowSeparator(.hidden)
            
            HStack {
                Spacer()
                startAndLastWeights
                Spacer()
            }
        }
    }

    private var chartSection: some View {
        Chart {
            ForEach(exerciseName.sortedListPR) { pr in
                let lbWeightPR = Measurement(value: Double(pr.value), unit: UnitMass.kilograms)
                    .converted(to: .pounds)
                    .value
                
                if selectedUnits == "Kg" {
                    LineMark(
                        x: .value("Date", pr.date, unit: chartUnit(for: selection)),
                        y: .value("Value (Kg)", pr.value)
                    )
                } else {
                    LineMark(
                        x: .value("Date", pr.date, unit: chartUnit(for: selection)),
                        y: .value("Value (lbs)", lbWeightPR)
                    )
                }
            }
        }
        .chartXScale(domain: .automatic(includesZero: false))
        .chartYScale(domain: .automatic(includesZero: false))
        .frame(height: 300)
        .padding()
    }

    private var unitPicker: some View {
        Picker("", selection: $selectedUnits) {
            ForEach(units, id: \.self) { unit in
                Text(unit).tag(unit)
            }
        }
        .frame(maxWidth: 100)
        .pickerStyle(SegmentedPickerStyle())
    }

    private var weightText: some View {
        Group {
            if let lastPR = exerciseName.sortedListPR.last {
                let lbWeight = Measurement(value: Double(lastPR.value), unit: UnitMass.kilograms)
                    .converted(to: .pounds)
                    .value
                Text("\(String(format: "%.1f", selectedUnits == "Kg" ? lastPR.value : lbWeight))")
                    .font(.system(size: 34))
                    .bold()
                Text(selectedUnits)
                    .font(.system(size: 15))
            } else {
                Text("0")
                    .font(.system(size: 34))
                    .bold()
                Text(selectedUnits)
                    .font(.system(size: 15))
            }
        }
    }

    private var lastUpdateText: some View {
        Group {
            if let lastPR = exerciseName.sortedListPR.last {
                Text("Last Update: \(lastPR.date, formatter: dateFormatter)")
                    .fontWeight(.thin)
            } else {
                Text("Last Update: N/A")
                    .fontWeight(.thin)
            }
        }
    }

    private var addNewRecordButton: some View {
        HStack {
            Spacer()
            Image(systemName: "square.and.pencil")
            Text("Add New Record")
            Spacer()
        }
        .sheet(isPresented: $isModalPresented) {
            ModalView(exerciseName: exerciseName, viewModel: viewModel)
                .presentationDetents([.height(235)])
        }
        .padding()
        .background(Color("ButtonContainerBG"))
        .foregroundColor(.blue)
        .font(.headline)
        .cornerRadius(10)
        .padding()
    }

    private var startAndLastWeights: some View {
        Group {
            if let firstPR = exerciseName.sortedListPR.first,
               let lastPR = exerciseName.sortedListPR.last {
                let lbWeightFirst = Measurement(value: Double(firstPR.value), unit: UnitMass.kilograms)
                    .converted(to: .pounds)
                    .value
                let lbWeightLast = Measurement(value: Double(lastPR.value), unit: UnitMass.kilograms)
                    .converted(to: .pounds)
                    .value
                
                VStack {
                    Text("Start").foregroundColor(.blue)
                    Text("\(String(format: "%.1f", selectedUnits == "Kg" ? firstPR.value : lbWeightFirst)) \(selectedUnits)")
                }
                Divider()
                    .background(Color.gray)
                    .frame(height: 30)
                VStack {
                    Text("Last").foregroundColor(.blue)
                    Text("\(String(format: "%.1f", selectedUnits == "Kg" ? lastPR.value : lbWeightLast)) \(selectedUnits)")
                }
            } else {
                VStack {
                    Text("Start").foregroundColor(.blue)
                    Text("N/A \(selectedUnits)")
                }
                Divider()
                    .background(Color.gray)
                    .frame(height: 30)
                VStack {
                    Text("Last").foregroundColor(.blue)
                    Text("N/A \(selectedUnits)")
                }
            }
        }
    }

    private func chartUnit(for selection: Int) -> Calendar.Component {
        switch segments[selection] {
        case "D":
            return .day
        case "W":
            return .weekOfYear
        case "M":
            return .month
        case "Y":
            return .year
        default:
            return .day
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()
