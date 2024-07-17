//
//  HowWeCalculateView.swift
//  Nano3_Gymbro
//
//  Created by Annisa Az Zahra on 15/07/24.
//

import Foundation
import SwiftUI

struct HowWeCalculateView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack{
            ZStack {
                Text("How We Calculate")
                    .fontWeight(.semibold)
                    .padding(.top, 20)
                    .padding(.bottom, -10)
                HStack {
                    Spacer()
                    
                    Button(action: {
                                            presentationMode.wrappedValue.dismiss()
                                        }) {
                                            Text("Done")
                                                .fontWeight(.semibold)
                                                .foregroundColor(.blue)
                                                .padding(.top, 20)
                                                .padding(.bottom, -10)
                                        }
                }
                .padding(.horizontal)
            }
            
            List{
                HStack(alignment: .center) {
                    Image(systemName: "plusminus.circle.fill")
                    Text("Mayhew et al. Formula")
                        .font(.body)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .listRowSeparator(.hidden)
                .foregroundStyle(.orange)
                
                HStack{
                    Text("1RM (kg) =").fontWeight(.semibold)

                    VStack{
                        Text("RepWt").listRowSeparator(/*@START_MENU_TOKEN@*/.visible/*@END_MENU_TOKEN@*/).fontWeight(.semibold)
                        
                        Rectangle().frame(height: 2)
                        
                        HStack(alignment: .top){
                            Text("0.522 + 0.419 e")
                                .font(.callout).fontWeight(.semibold)
                            Text("-0.055 RTF")
                                .font(.caption).fontWeight(.semibold)
                        }
                        
                        
                    }
                }.listRowSeparator(.hidden)
                    .padding(.horizontal)
                    .foregroundStyle(.blue)                    .frame(width: 330, height:80)
                    .background(Color.buttonContainerBG)
                    .cornerRadius(12)
                    .overlay(
                    RoundedRectangle(cornerRadius: 12)
                    .inset(by: 0.5)
                    .stroke(Color.gray, lineWidth: 1)
                    )
                
                Text("RPE (Rating of Perceived Exertion) measures training intentisty, especially in weightlifting, indicating how many reps you could still perform in your last set.")
                    .listRowSeparator(.hidden)
                
                HStack{
                    Text("1RM")
                    Rectangle()
                        .frame(width: 30)
                        .foregroundColor(.clear)
                    Text("=")
                    Text("Maximal effort")
                }.listRowSeparator(.hidden)
                
                HStack(alignment: .top){
                    Text("RepWt")
                    Rectangle()
                        .frame(width: 12)
                        .foregroundColor(.clear)
                    Text("=")
                    Text("Repetition weight, a load less than 1RM used to perform repetitions")
                }.listRowSeparator(.hidden)
                
                HStack(alignment: .top){
                    Text("RTF").bold()
                    Rectangle()
                        .frame(width: 32)
                        .foregroundColor(.clear)
                    Text("=")
                    Text("Repetitions to fatigue")
                }.listRowSeparator(.hidden)
            
                HStack(alignment: .center) {
                    Image(systemName: "questionmark.circle.fill")
                    Text("Why max 10 reps input?")
                        .font(.body)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .listRowSeparator(.hidden)
                .foregroundStyle(.orange)
                
                Text("Exceeding 10 reps can reduce the accuracy of your RM value")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.blue)
                    .multilineTextAlignment(.leading)
                    .listRowSeparator(.hidden)
                    .frame(width: 320, height:80)
                    .background(Color.buttonContainerBG)
                    .cornerRadius(12)
                    .overlay(
                    RoundedRectangle(cornerRadius: 12)
                    .inset(by: 0.5)
                    .stroke(Color.gray, lineWidth: 1)
                    )
                
                Text("Brzychi and Ware et al. found that performing fewer than 10 reps to fatigue provides a more accurate estimate of your 1RM")
                    .foregroundColor(Color("FontColor"))
                    .listRowSeparator(.hidden)
                
                
            }
        }
        .background(Color.backgroundBG)
    }
    
}

#Preview {
    HowWeCalculateView()
}
