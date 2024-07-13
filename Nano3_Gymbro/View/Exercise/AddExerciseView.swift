//
//  AddExerciseView.swift
//  inputExercise
//
//  Created by Shan Havilah on 11/07/24.
//

import SwiftUI

struct AddExerciseView: View{
    @State private var exerciseName: String = ""
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = ExerciseViewModel()
    @Environment(\.modelContext) public var context
    
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                Text("New Exercise")
                    .font(.title)
                    .padding(.leading)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "x.circle.fill")
                        .foregroundColor(.gray)
                        .padding(.trailing)
                }
            }
            .padding(.top)
            
            HStack{
                Text("Name")
                Divider()
                    .frame(width: 20, height: 20).hidden()
                TextField("Enter exercise", text: $exerciseName)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal)
            
            Button(action: {
                viewModel.addItem(name: exerciseName, id: UUID().uuidString, RMBest: 0, context: context)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Add New Exercise")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .padding(.top)
            Spacer()
        }
        .background(Color.clear.edgesIgnoringSafeArea(.all))
        
    }
    
}

#Preview {
    AddExerciseView()
}
