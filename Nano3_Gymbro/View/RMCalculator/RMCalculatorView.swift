//
//  RMCalculatorView.swift
//  Nano3_Gymbro
//
//  Created by Dinda Ayu Syafitri on 11/07/24.
//

import SwiftUI

struct RMCalculatorView: View {
    @StateObject var viewModel = RMCalculatorViewModel()
    @State var weight = 0.0
    @State var username = ""

    var body: some View {
        List {
            Section {
                HStack {
                    Text("RM Calculator")
                        .font(.largeTitle)
                        .bold()
                }
            }
            .listRowBackground(Color.clear)

            RMInputView()

            Section {
                Text("Result")
                Text("\(viewModel.oneRepMax)")
            }
        }
        .listStyle(InsetGroupedListStyle())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .environmentObject(viewModel)
    }
}

#Preview {
    RMCalculatorView()
}
