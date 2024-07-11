//
//  PRDetailView.swift
//  Nano3_Gymbro
//
//  Created by Christian Gunawan on 11/07/24.
//

import SwiftUI
import SwiftUICharts

struct DetailView: View {
    let card: Card
    @State private var selectedItem = 0
    @State private var selection = 0
     let segments = ["D", "W", "M", "Y"]
       let options = ["BenchPress", "Deadlift", "Squat", "Angkat Galon"]
    
    var body: some View {
        VStack {
            VStack{
                Image(systemName: "dumbbell.fill").foregroundColor(.orange).font(.largeTitle).font(.system(size: 100))
                
                HStack(alignment:.firstTextBaseline) {
                    
                    Text("\(card.weight)").font(.system(size: 50)).bold()
                    Text("Kg")
                }
                Text("Last Updated \(card.date,formatter: dateFormatter)").fontWeight(.thin)
                
                Button(action: {
                    
                    print("Button tapped!")
                }) {
                    Text("Add New Record")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .font(.headline)
                        .cornerRadius(10)
                }
            }
            VStack(alignment: .leading){
                HStack{
                    Image(systemName: "flame")
                    Text("Your Progress")
                    Picker(selection: $selectedItem, label: Text("Options")) {
                                  ForEach(0 ..< options.count) {
                                      Text(self.options[$0])
                                  }
                              }
                              .pickerStyle(MenuPickerStyle())
                              .padding()
                }
            }
            Picker(selection: $selection, label: Text("Segments")) {
                           ForEach(0 ..< segments.count) { index in
                               Text(self.segments[index])
                                   .tag(index)
                           }
                       }
                       .pickerStyle(SegmentedPickerStyle())
            .padding()
            HStack{
                VStack{
                    Text("Start")
                    Text("25.5 Kg")
                }
                VStack{
                    Text("Last")
                    Text("25.5 Kg")
                }
                
            }
            

            LineView(data: [8,23,54,32,12,37,7,23,43], title: "Line chart", legend: "Full screen")
            
        }
        Spacer()
      
        .navigationTitle("Personal Record")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(card: Card(id: UUID(), title: "Sample Card", detail: "Detail for Sample Card", date: Date(), weight: 100))
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()
