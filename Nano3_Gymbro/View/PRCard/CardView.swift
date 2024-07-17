//
//  CardView.swift
//  Nano3_Gymbro
//
//  Created by Christian Gunawan on 17/07/24.
//

import SwiftData
import SwiftUI

struct CardView: View {
    let exerciseName: ExerciseName
    @EnvironmentObject var viewModel: ExerciseViewModel
    @Binding var units: String

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "flame")
                Text(exerciseName.name)
                Spacer()
            }
            .foregroundColor(.orange)
            .lineLimit(1)
            .truncationMode(.tail)
            
            if let lastPR = exerciseName.sortedListPR.last {
                let lbWeight = Measurement(value: Double(lastPR.value), unit: UnitMass.kilograms)
                    .converted(to: .pounds)
                    .value
                if units == "Kg" {
                    HStack(alignment: .firstTextBaseline) {
                        Text("\(String(format: "%.1f", lastPR.value))").font(.system(size: 34)).bold()
                        Text("Kg")
                    }
                    Text("\(lastPR.date, formatter: dateFormatter)").fontWeight(.thin)
                } else {
                    HStack(alignment: .firstTextBaseline) {
                        Text("\(String(format: "%.1f", lbWeight))").font(.system(size: 34)).bold()
                        Text("lb")
                    }
                    Text("\(lastPR.date, formatter: dateFormatter)").fontWeight(.thin)
                }
            } else {
                if units == "Kg" {
                    HStack(alignment: .firstTextBaseline) {
                        Text("0").font(.system(size: 34)).bold()
                        Text("Kg")
                    }
                    Text("-").fontWeight(.thin)
                } else {
                    HStack(alignment: .firstTextBaseline) {
                        Text("0").font(.system(size: 34)).bold()
                        Text("lb")
                    }
                    Text("-").fontWeight(.thin)
                }
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
