//
//  RMCalculatorView.swift
//  Nano3_Gymbro
//
//  Created by Dinda Ayu Syafitri on 11/07/24.
//

import SwiftUI

struct RMCalculatorView: View {
    @StateObject var viewModel = RMCalculatorViewModel()
    @State var selectedUnits = "Kg"
    @State var units = ["Kg", "lb"]

    var body: some View {
        List {
            Section {
                VStack(alignment: .leading) {
                    Section {
                        HStack {
                            Spacer()
                            Picker("", selection: $selectedUnits) {
                                ForEach(units, id: \.self) { unit in
                                    Text("\(unit)").tag(unit)
                                }
                            }
                            .frame(maxWidth: 100)
                            .pickerStyle(.segmented)
                            .padding(0)
                        }
                        .frame(maxWidth: .infinity)
                    }

                    Section {
                        HStack {
                            Text("1RM Calculator")
                                .font(.largeTitle)
                                .bold()
                        }
                    }
                }
            }
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets())

            RMInputView(unit: $selectedUnits)

            RMResultView(unit: $selectedUnits)
        }
        .listStyle(InsetGroupedListStyle())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .environmentObject(viewModel)
    }
}

#Preview {
    RMCalculatorView()
}
