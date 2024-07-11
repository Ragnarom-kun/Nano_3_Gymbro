//
//  PRCardView.swift
//  Nano3_Gymbro
//
//  Created by Christian Gunawan on 11/07/24.
//

import SwiftUI
import SwiftData

struct PRCardView: View {
    @State private var cards: [Card] = [
        Card(id: UUID(), title: "BenchPress", detail: "Detail for Card 1", date: .now, weight: 100),
        Card(id: UUID(), title: "Deadlift", detail: "Detail for Card 1", date: .now, weight: 100),
        Card(id: UUID(), title: "Deadlift", detail: "Detail for Card 1", date: .now, weight: 100),
        Card(id: UUID(), title: "Deadlift", detail: "Detail for Card 1", date: .now, weight: 100),
        Card(id: UUID(), title: "Deadlift", detail: "Detail for Card 1", date: .now, weight: 100),
        Card(id: UUID(), title: "Deadlift", detail: "Detail for Card 1", date: .now, weight: 100),
        Card(id: UUID(), title: "Deadlift", detail: "Detail for Card 1", date: .now, weight: 100),
        Card(id: UUID(), title: "Deadlift", detail: "Detail for Card 1", date: .now, weight: 100),
        Card(id: UUID(), title: "Deadlift", detail: "Detail for Card 1", date: .now, weight: 100),
        Card(id: UUID(), title: "Deadlift", detail: "Detail for Card 1", date: .now, weight: 100),
        Card(id: UUID(), title: "Deadlift", detail: "Detail for Card 1", date: .now, weight: 100),
        Card(id: UUID(), title: "Deadlift", detail: "Detail for Card 1", date: .now, weight: 100),
        Card(id: UUID(), title: "Deadlift", detail: "Detail for Card 1", date: .now, weight: 100),
    ]

    var body: some View {
       
            NavigationView {
                VStack {
                    ScrollView{
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2)) {
                        ForEach(cards) { card in
                            NavigationLink(destination: DetailView(card: card)) {
                                CardView(card: card)
                            }
                        }
                    }
                    .padding()
                     Spacer()
                }
                .navigationTitle("Personal Record")
                .background(Color("BackgroundBG").edgesIgnoringSafeArea(.all))
            }
        }
    }
}

#Preview {
    PRCardView()
}



struct CardView: View {
    let card: Card

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "flame")
                Text(card.title)
            }.foregroundColor(.orange)
            HStack(alignment:.firstTextBaseline) {
                
                Text("\(card.weight)").font(.system(size: 50)).bold()
                Text("Kg")
            }
          
            Text("\(card.date, formatter: dateFormatter)").fontWeight(.thin)
        }
        .font(.headline)
        .padding()
        .background(Color("ContainerColor"))
        .foregroundColor(Color("FontColor"))
        .cornerRadius(10)
        .frame(width: 169, height: 139)
        .padding(5)
        
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()

