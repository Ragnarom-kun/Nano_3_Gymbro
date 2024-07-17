//
//  RMInputView.swift
//  Nano3_Gymbro
//
//  Created by Dinda Ayu Syafitri on 11/07/24.
//

import SwiftUI

struct RMInputView: View {
    @EnvironmentObject var viewModelRMCalculator: RMCalculatorViewModel
    @EnvironmentObject var viewModelExercise: ExerciseViewModel
    @State var weight: Int = 20
    @State var reps: Int = 1
    @State var sets: Int = 1
    @State var exercise: String = "Bench Press"
    @State var openedPicker: String = ""
    @State var isWeightPickerExpanded: Bool = false
    @EnvironmentObject var router: Router
    @Environment(\.modelContext) public var context

    @Binding var unit: String

    var body: some View {
        Section {
            HStack(alignment: .top) {
                Image(systemName: "plusminus.circle.fill")
                Text("Calculator")
                    .font(.body)
                    .fontWeight(.semibold)
            }
            .listRowSeparator(.hidden)
            .foregroundStyle(.orange)

            VStack {
                DisclosureGroup(
                    content: {
                        Picker("", selection: $weight) {
                            ForEach(5 ... 300, id: \.self) { kgWeight in
                                // Convert kg to lb
                                let lbWeight = Measurement(value: Double(kgWeight), unit: UnitMass.kilograms)
                                    .converted(to: .pounds)
                                    .value
                                if unit == "Kg" {
                                    Text("\(Int(kgWeight)) Kg").tag(kgWeight)
                                } else {
                                    Text("\(Int(lbWeight)) lb").tag(kgWeight)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .pickerStyle(.wheel)
                        .frame(maxHeight: 150)
                    },
                    label: {
                        Text("Weight")
                        Spacer()
                    }
                )
                .disclosureGroupStyle(CustomDisclosureGroupStyle(button: unit == "Kg" ? Text("\(Int(weight)) kg") : Text("\(Int(Measurement(value: Double(weight), unit: UnitMass.kilograms).converted(to: .pounds).value)) lb")))
            }

            VStack {
                DisclosureGroup(
                    content: {
                        Picker("", selection: $reps) {
                            ForEach(1 ... 10, id: \.self) { rep in
                                Text("\(rep)").tag(rep)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .pickerStyle(.wheel)
                        .frame(maxHeight: 150)
                    },
                    label: {
                        Text("Reps")
                        Spacer()
                    }
                )
                .disclosureGroupStyle(CustomDisclosureGroupStyle(button: Text("\(reps)")))
            }

            VStack {
                DisclosureGroup(
                    content: {
                        Picker("", selection: $sets) {
                            ForEach(1 ... 10, id: \.self) { set in
                                Text("\(set)").tag(set)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .pickerStyle(.wheel)
                        .frame(maxHeight: 150)
                    },
                    label: {
                        Text("Sets")
                        Spacer()
                    }
                )
                .disclosureGroupStyle(CustomDisclosureGroupStyle(button: Text("\(sets)")))
            }

            HStack {
                Text("Exercise")
                Spacer()
                Button(action: {
                    router.navigateTo(.ExerciseListView)
                }, label: {
                    HStack{
                        Text(viewModelExercise.activeExercise?.name ?? "No Exercise Selected")
                        Image(systemName: "chevron.right")
                    }
                    
                })
            }

            Button(action: {
                viewModelRMCalculator.calculateRM(weight: Double(weight), reps: Double(reps), sets: Double(sets), unit: unit)
            }, label: {
                Text("Calculate")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .foregroundStyle(.white)
                    .background(.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 12.0))
            })
        }
        .listSectionSeparator(.hidden, edges: .top)
        .onAppear().task {
            let activeTemp = viewModelExercise.activeExercise
            if (activeTemp == nil) {
                viewModelExercise.activeExercise = viewModelExercise.getExerciseByName(name: "Bench Press", context: context)
            }
        }
    }
}

struct CustomDisclosureGroupStyle<Label: View>: DisclosureGroupStyle {
    let button: Label
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Button(action: {
                configuration.isExpanded.toggle()
            }, label: {
                button
            })
            .buttonStyle(BorderedButtonStyle())
        }

        if configuration.isExpanded {
            configuration.content
                .disclosureGroupStyle(self)
        }
    }
}

#Preview {
    RMInputView(unit: .constant("Kg"))
}
