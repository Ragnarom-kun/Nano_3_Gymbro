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
    let cards: [Card]
    @State private var selectedItem = 0
    @State private var selection = 0
    @State private var options: [String] = []
    let segments = ["D", "W", "M", "Y"]
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    VStack(alignment:.center,spacing: 16){
                        Spacer()
                        Image(systemName: "dumbbell.fill").foregroundColor(.orange).font(.system(size: 80))
                        HStack(alignment:.firstTextBaseline) {
                            Spacer()
                            Text("\(card.weight)").font(.system(size: 34)).bold()
                            Text("Kg").font(.system(size: 15))
                            Spacer()
                        }
                        Text("Last Updated \(card.date, formatter: dateFormatter)").font(.system(size: 15))
                        
                        Button(action: {
                            print("Button tapped!")
                        }) {
                            HStack {
                                Spacer()
                                Image(systemName: "square.and.pencil")
                                Text("Add New Record")
                                Spacer()
                            }
                            .padding()
                            .background(Color("ButtonContainerBG"))
                            .foregroundColor(.blue)
                            .font(.headline)
                            .cornerRadius(10)
                            .padding()
                        }
                        Spacer()
                    }
                    .background(Color("ContainerColor"))
                    .padding(10)
                    .cornerRadius(50)
                }
                
                VStack(spacing:16){
                    HStack {
                        Spacer()
                        HStack(alignment: .firstTextBaseline) {
                            Image(systemName: "flame")
                            Text("Your Progress").bold()
                        }
                        .foregroundColor(.orange)
                        .alignmentGuide(HorizontalAlignment.trailing) { _ in
                            return UIScreen.main.bounds.width / 2 // Adjust as needed
                        }

                        Picker(selection: $selectedItem, label: Text("Options")) {
                            ForEach(0 ..< options.count, id: \.self) {
                                Text(self.options[$0])
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding()
                    }
                    Picker(selection: $selection, label: Text("Segments")) {
                        ForEach(0 ..< segments.count) { index in
                            Text(self.segments[index])
                                .tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    VStack {
                        HStack{
                            VStack{
                                Text("Start").foregroundColor(.blue)
                                Text("\(card.weight) Kg")
                            }
                            Divider()
                                .background(Color.gray)
                                .frame(height: 30)
                            VStack{
                                Text("Last").foregroundColor(.blue)
                                Text("\(card.weight) Kg")
                            }
                        }
                        
                           Text("Ini Chart")

                    }
                    Spacer()
                }.background(Color("ContainerColor"))
                    .padding(10)
                    .cornerRadius(50)
                
            }
            .padding(.bottom,1000)
            .background(Color("BackgroundBG"))
            .navigationTitle("Personal Record")
        }
        .onAppear {
            self.options = cards.map { $0.title }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(
            card: Card(id: UUID(), title: "Sample Card", detail: "Detail for Sample Card", date: Date(), weight: 100),
            cards: [
                Card(id: UUID(), title: "Sample Card 1", detail: "Detail for Sample Card 1", date: Date(), weight: 100),
                Card(id: UUID(), title: "Sample Card 2", detail: "Detail for Sample Card 2", date: Date(), weight: 200),
                Card(id: UUID(), title: "Sample Card 2", detail: "Detail for Sample Card 2", date: Date(), weight: 200)
                
            ]
        )
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()
