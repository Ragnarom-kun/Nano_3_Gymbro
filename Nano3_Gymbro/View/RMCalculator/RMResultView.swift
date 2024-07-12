//
//  RMResultView.swift
//  Nano3_Gymbro
//
//  Created by Dinda Ayu Syafitri on 11/07/24.
//

import SwiftUI

struct Customer: Identifiable {
    let id = UUID()
    let name: String
    let email: String
    let creationDate: Date
}

struct RMResultView: View {
    @EnvironmentObject var viewModel: RMCalculatorViewModel

    var body: some View {
        Section {
            VStack(spacing: 16) {
                HStack {
                    HStack(alignment: .top) {
                        Image(systemName: "percent")
                        Text("Results")
                            .font(.body)
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.orange)
                    Spacer()
                    Image(systemName: "info.circle")
                        .foregroundStyle(.blue)
                }

                VStack(spacing: 12) {
                    Text("Your 1RM is ..")
                        .font(.subheadline)
                        .bold()
                    HStack(alignment: .bottom) {
                        Text("\(viewModel.oneRepMax)")
                            .font(.largeTitle)
                            .bold()
                        Text("Kg")
                            .font(.subheadline)
                            .bold()
                    }
                    Button(action: {}, label: {
                        HStack {
                            Image(systemName: "square.and.pencil")
                            Text("Add to Progress")
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .foregroundStyle(.blue)
                        .background(.tertiary)
                        .clipShape(RoundedRectangle(cornerRadius: 12.0))
                    })
                }
            }

            .listRowSeparator(.hidden)
        }
        .listSectionSeparator(.hidden, edges: .top)
    }
}

#Preview {
    RMResultView()
        .environmentObject(RMCalculatorViewModel())
}
