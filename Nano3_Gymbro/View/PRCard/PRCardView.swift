//
//  PRCardView.swift
//  Nano3_Gymbro
//
//  Created by Christian Gunawan on 11/07/24.
//

import SwiftData
import SwiftUI

struct PRCardView: View {
    @Query public var exercises: [ExerciseName]
    @EnvironmentObject var viewModel: ExerciseViewModel
    @State private var cards: [Card] = [
    ]

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
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
    // let exerciseValue: ExerciseName

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
            HStack(alignment: .firstTextBaseline) {
                Text("\(String(format: "%.1f", exerciseName.sortedListPR.last?.value ?? 0.0))").font(.system(size: 34)).bold()
                Text("Kg")
            }

            if exerciseName.sortedListPR.last?.date != nil {
                Text("\(exerciseName.sortedListPR.last!.date, formatter: dateFormatter)").fontWeight(.thin)
            } else {
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
