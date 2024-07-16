//
//  PRCardView.swift
//  Nano3_Gymbro
//
//  Created by Christian Gunawan on 11/07/24.
//

import SwiftUI
import SwiftData

struct PRCardView: View {
    
    @Query public var exercises: [ExerciseName]
    @EnvironmentObject var viewModel: ExerciseViewModel
    @State private var cards: [Card] = [
    ]

    var body: some View {
        
        if exercises.isEmpty{
            Text("No Data Avaible").foregroundColor(Color("FontColor"))
        }
            NavigationView {
                VStack {
                    ScrollView{
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2)) {
                        
                        ForEach(exercises) { exercise in
                            NavigationLink(destination: DetailView(exerciseName: exercise)) {
                                CardView(exerciseName: exercise)
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



struct CardView: View {
    let exerciseName: ExerciseName
    @EnvironmentObject var viewModel: ExerciseViewModel

    var body: some View {
     

        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "flame")
                Text(exerciseName.name)
                Spacer()
            }.foregroundColor(.orange)
            .lineLimit(1)
            .truncationMode(.tail)
            
            if let lastPR = exerciseName.sortedListPR.last {
                  HStack(alignment: .firstTextBaseline) {
                      Text("\(String(format: "%.1f", lastPR.value))").font(.system(size: 34)).bold()
                      Text("Kg")
                  }
                  Text("\(lastPR.date, formatter: dateFormatter)").fontWeight(.thin)
              } else {
                  HStack(alignment: .firstTextBaseline) {
                      Text("0").font(.system(size: 34)).bold()
                      Text("Kg")
                  }
                  Text("-").fontWeight(.thin)
              }
    
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



