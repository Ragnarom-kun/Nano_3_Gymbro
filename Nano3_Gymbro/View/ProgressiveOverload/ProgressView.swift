//
//  ProgressView.swift
//  Nano3_Gymbro
//
//  Created by Romi Fadhurohman Nabil on 17/07/24.
//

import SwiftUI

struct ProgressView: View {
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
                            Text("1RM Progress")
                                .font(.largeTitle)
                                .bold()
                        }
                    }
                }
            }
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets())
            
            LineChartRMView(unit: $selectedUnits)
            ProgressiveOverloadPlanView()
        }
        .listStyle(InsetGroupedListStyle())
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .environmentObject(viewModel)
    }
}

#Preview {
    ProgressView()
}
