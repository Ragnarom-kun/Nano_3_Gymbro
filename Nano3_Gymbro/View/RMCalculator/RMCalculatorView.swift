//
//  RMCalculatorView.swift
//  Nano3_Gymbro
//
//  Created by Dinda Ayu Syafitri on 11/07/24.
//

import SwiftUI

struct RMCalculatorView: View {
    @StateObject var viewModel = RMCalculatorViewModel()

    var body: some View {
        List {
            Section {
                HStack {
                    Text("1RM Calculator")
                        .font(.largeTitle)
                        .bold()
                }
            }
            .listRowBackground(Color.clear)

            RMInputView()

            RMResultView()
        }
        .listStyle(InsetGroupedListStyle())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .environmentObject(viewModel)
    }
}

#Preview {
    RMCalculatorView()
}
