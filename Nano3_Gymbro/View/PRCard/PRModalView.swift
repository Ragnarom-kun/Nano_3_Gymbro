//
//  PRModalView.swift
//  Nano3_Gymbro
//
//  Created by Christian Gunawan on 15/07/24.
//

import SwiftUI
import SwiftData


struct ModalView: View {
    @Environment(\.modelContext) public var context
    @State var exerciseName: ExerciseName
    @Environment(\.presentationMode) var presentationMode
    var viewModel: ExerciseViewModel
    @State private var weight: Double = 0.0
    var body: some View {
        
        VStack {
            Spacer()
            HStack(alignment:.center){
                Text("New Record") .foregroundColor(Color("FontColor"))
                Spacer()
                Button(action: {
                    
                    presentationMode.wrappedValue.dismiss()
                    
                }){
                    Image(systemName: "xmark.circle.fill").foregroundColor(.gray)
                }
            }.padding(20)
            
            
            VStack {
                HStack {
                    Spacer()
                    Text("Weight Lift")
                    TextField("0", value: $weight, formatter: NumberFormatter())
                        .textFieldStyle(PlainTextFieldStyle()).fontWeight(.thin)
                    Spacer()
                    Text("Kg")
                }.foregroundColor(Color("FontColor"))
                    .padding(20)
                
                HStack {
                    Spacer()
                    Button(action: {
                        if let lastPR = exerciseName.sortedListPR.last {
                            if weight > lastPR.value {
                                viewModel.addArrayPR(item: exerciseName, PR: weight, context: context)
                                presentationMode.wrappedValue.dismiss()
                            }
                        } else {
                            // Handle the case where sortedListPR is empty or nil
                            // For example, you might want to add the weight as the first PR
                            viewModel.addArrayPR(item: exerciseName, PR: weight, context: context)
                            
                            
                        }
                        
                    }){
                        Text("Add New Exercise").foregroundColor(Color(.white)).padding(.horizontal,90)
                            .padding(.vertical, 14)
                        
                        
                        
                    }.background(Color("ButtonContainerBG2"))
                        .cornerRadius(12)
                    
                    Spacer()
                }
            } .background(Color("ContainerColor"))
                .padding(.bottom, 20)
                .cornerRadius(20)
            
            
            
        }
        .background(Color("ContainerColor"))
    }
    
    
    
}


