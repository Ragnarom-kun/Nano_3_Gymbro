//
//  PRDetailView.swift
//  Nano3_Gymbro
//
//  Created by Christian Gunawan on 11/07/24.
//
import SwiftUI
//import SwiftUICharts
import SwiftData

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
                                // Handle the case where sortedListPR is empty
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
                                // Handle the case where sortedListPR is empty
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
    
                            .frame(maxWidth: 150)
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
                                // Handle the case where sortedListPR is empty or nil
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

                        
                        Text("chart").font(.system(size: 800))
                            .listRowSeparator(.hidden)
                    }
                    
                    
                }
                 
            }.navigationTitle("\(exerciseName.name)")
            }

      
    }


private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()

//        NavigationView{
//            ScrollView {
//                Section {
//                    HStack {
//                        VStack(alignment:.center,spacing: 16){
//                            Spacer()
//                            Image(systemName: "dumbbell.fill").foregroundColor(.orange).font(.system(size: 80))
//                            HStack(alignment:.firstTextBaseline) {
//                                Spacer()
//                                Text("\(card.weight)").font(.system(size: 34)).bold()
//                                Text("Kg").font(.system(size: 15))
//                                Spacer()
//                            }
//                            Text("Last Updated \(card.date, formatter: dateFormatter)").font(.system(size: 15))
//
//                            Button(action: {
//                                print("Button tapped!")
//                            }) {
//                                HStack {
//                                    Spacer()
//                                    Image(systemName: "square.and.pencil")
//                                    Text("Add New Record")
//                                    Spacer()
//                                }
//                                .padding()
//                                .background(Color("ButtonContainerBG"))
//                                .foregroundColor(.blue)
//                                .font(.headline)
//                                .cornerRadius(10)
//                                .padding()
//                            }
//                            Spacer()
//                        }
//                        .background(Color("ContainerColor"))
//                        .padding(10)
//                        .cornerRadius(50)
//                    }
//
//                    NavigationView{
//                        List{
//                            HStack(alignment: .firstTextBaseline) {
//                                Image(systemName: "flame")
//                                Text("Your Progress").bold()
//                            }
//                            .foregroundColor(.orange)
//                        }
//                    }
//                    Section{
//                        HStack {
//                            Spacer()
//                            HStack(alignment: .firstTextBaseline) {
//                                Image(systemName: "flame")
//                                Text("Your Progress").bold()
//                            }
//                            .foregroundColor(.orange)
//
//                            Picker(selection: $selectedItem, label: Text("Options")) {
//                                ForEach(0 ..< options.count, id: \.self) {
//                                    Text(self.options[$0])
//                                }
//                            }
//                            .pickerStyle(MenuPickerStyle())
//                            .padding()
//                        }
//                        Picker(selection: $selection, label: Text("Segments")) {
//                            ForEach(0 ..< segments.count) { index in
//                                Text(self.segments[index])
//                                    .tag(index)
//                            }
//                        }
//                        .pickerStyle(SegmentedPickerStyle())
//                        .padding()
//
//                        VStack {
//                            HStack{
//                                VStack{
//                                    Text("Start").foregroundColor(.blue)
//                                    Text("\(card.weight) Kg")
//                                }
//                                Divider()
//                                    .background(Color.gray)
//                                    .frame(height: 30)
//                                VStack{
//                                    Text("Last").foregroundColor(.blue)
//                                    Text("\(card.weight) Kg")
//                                }
//                            }
//
//                            Text("Ini Chart")
//
//                        }
//                        Spacer()
//                    }.background(Color("ContainerColor"))
//                        .padding(10)
//                        .cornerRadius(50)
//
//                }
//                .padding(.bottom,1000)
//                .background(Color("BackgroundBG"))
//                .navigationTitle("Personal Record")
//            }
//            .onAppear {
//                self.options = cards.map { $0.title }
//            }
//        }
//    }
//}
