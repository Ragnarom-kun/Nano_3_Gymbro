//
//  PRModalView.swift
//  Nano3_Gymbro
//
//  Created by Christian Gunawan on 15/07/24.
//

import SwiftUI


struct ModalView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var textFieldValue: String = ""
    
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
                HStack{
                    Spacer()
                    Text("Weight Lift")
                    TextField("0", text: $textFieldValue)
                        .textFieldStyle(PlainTextFieldStyle())
                    Spacer()
                    Text("Kg")
                }.padding(20)
                
                HStack {
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
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

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView()
    }
}
