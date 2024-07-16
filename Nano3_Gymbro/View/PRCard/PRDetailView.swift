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
    @StateObject var viewModel = ExerciseViewModel()
    @State private var selectedItem = 0
    @State private var selection = 0
    @State private var options: [String] = ["Option 1", "Option 2", "Option 3"]
    @State private var isModalPresented = false
    let segments = ["D", "W", "M", "Y"]

    var body: some View {
        Section {
            List {
                Section {
                    Spacer()
                    HStack {
                        Spacer()
                        Image(systemName: "dumbbell.fill").foregroundColor(.orange).font(.system(size: 80))
                        Spacer()
                    }
                    .listRowSeparator(.hidden)
                    
                    HStack(alignment: .firstTextBaseline) {
                        Spacer()
                        if let lastPR = exerciseName.sortedListPR.last {
                            Text("\(String(format: "%.1f", lastPR.value))")
                                .font(.system(size: 34))
                                .bold()
                            Text("Kg")
                                .font(.system(size: 15))
                        } else {
                            Text("0")
                                .font(.system(size: 34))
                                .bold()
                            Text("Kg")
                                .font(.system(size: 15))
                        }
                        Spacer()
                    }
                    .listRowSeparator(.hidden)
                    
                    HStack {
                        Spacer()
                        if let lastPR = exerciseName.sortedListPR.last {
                            Text("Last Update: \(lastPR.date, formatter: dateFormatter)")
                                .fontWeight(.thin)
                        } else {
                            Text("Last Update: N/A")
                                .fontWeight(.thin)
                        }
                        Spacer()
                    }
                    .listRowSeparator(.hidden)

                    Button(action: {
                        isModalPresented.toggle()
                    }) {
                        HStack {
                            Spacer()
                            Image(systemName: "square.and.pencil")
                            Text("Add New Record")
                            Spacer()
                        }
                        .sheet(isPresented: $isModalPresented) {
                            ModalView(exerciseName: exerciseName, viewModel: viewModel).presentationDetents([.height(235)])
                        }
                        .padding()
                        .background(Color("ButtonContainerBG"))
                        .foregroundColor(.blue)
                        .font(.headline)
                        .cornerRadius(10)
                        .padding()
                    }
                    .listRowSeparator(.hidden)
                }
                
                Section {
                    HStack(alignment: .firstTextBaseline) {
                        Image(systemName: "flame")
                        Text("Your Progress").bold()
                        Spacer()
                    }
                    .foregroundColor(.orange)
                    
                    Picker(selection: $selection, label: Text("Segments")) {
                        ForEach(0 ..< segments.count) { index in
                            Text(self.segments[index])
                                .tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .listRowSeparator(.hidden)
                    
                    HStack {
                        Spacer()
                        if let firstPR = exerciseName.sortedListPR.first, let lastPR = exerciseName.sortedListPR.last {
                            VStack {
                                Text("Start").foregroundColor(.blue)
                                Text("\(String(format: "%.1f", firstPR.value))Kg")
                            }
                            Divider()
                                .background(Color.gray)
                                .frame(height: 30)
                            VStack {
                                Text("Last").foregroundColor(.blue)
                                Text("\(String(format: "%.1f", lastPR.value))Kg")
                            }
                        } else {
                            VStack {
                                Text("Start").foregroundColor(.blue)
                                Text("N/A Kg")
                            }
                            Divider()
                                .background(Color.gray)
                                .frame(height: 30)
                            VStack {
                                Text("Last").foregroundColor(.blue)
                                Text("N/A Kg")
                            }
                        }
                        Spacer()
                    }

                    Chart {
                        ForEach(exerciseName.sortedListPR) { pr in
                            LineMark(
                                x: .value("Date", pr.date, unit: chartUnit(for: selection)),
                                y: .value("Value", pr.value)
                            )
                        }
                    }
                    .chartXScale(domain: .automatic(includesZero: false))
                    .chartYScale(domain: .automatic(includesZero: false))
                    .frame(height: 300)
                    .padding()
                }
            }
        }
        .navigationTitle("\(exerciseName.name)")
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
