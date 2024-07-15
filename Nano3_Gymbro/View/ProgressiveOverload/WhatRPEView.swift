import SwiftUI

struct WhatRPEView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack{
            ZStack {
                Text("What is RPE?")
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
                    Image(systemName: "questionmark.app.fill")
                    Text("RPE Measurement")
                        .font(.body)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .listRowSeparator(.hidden)
                .foregroundStyle(.orange)
                
                Text("RPE (Rating of Perceived Exertion) measures training intentisty, especially in weightlifting, indicating how many reps you could still perform in your last set.")
                    .listRowSeparator(.hidden)
                Text("It aids in autoregulation, precise training tracking, and planning for progressive weight.")
                    .listRowSeparator(.hidden)
            
                HStack{
                    Text("RPE")
                        .foregroundStyle(Color.blue)
                        //.frame(width: 35)
                    Rectangle()
                        .frame(width: 25)
                        .foregroundColor(.clear)
                    Text("Description")
                        .foregroundStyle(Color.blue)
                }
                
                HStack{
                    Text("10")
                        //.frame(width: 35)
                    Rectangle()
                        .frame(width: 38)
                        .foregroundColor(.clear)
                    Text("Maximal effort")
                }
                
                HStack{
                    Text("9.5")
                        //.frame(width: 35)
                    Rectangle()
                        .frame(width: 32)
                        .foregroundColor(.clear)
                    Text("Maybe could have done 1 more rep")
                }
                
                HStack{
                    Text("9")
                        //.frame(width: 35)
                    Rectangle()
                        .frame(width: 45)
                        .foregroundColor(.clear)
                    Text("Definitely could have done 1 more rep")
                }
                
                HStack{
                    Text("8.5")
                        //.frame(width: 35)
                    Rectangle()
                        .frame(width: 32)
                        .foregroundColor(.clear)
                    Text("Maybe could have done 2 more reps")
                }
                
                HStack{
                    Text("8")
                        //.frame(width: 35)
                    Rectangle()
                        .frame(width: 45)
                        .foregroundColor(.clear)
                    Text("Definitely could have done 2 more reps")
                }
                
                HStack{
                    Text("7.5")
                        //.frame(width: 35)
                    Rectangle()
                        .frame(width: 32)
                        .foregroundColor(.clear)
                    Text("Maybe could have done 3 more reps")
                }
                
                HStack{
                    Text("7")
                        //.frame(width: 35)
                    Rectangle()
                        .frame(width: 45)
                        .foregroundColor(.clear)
                    Text("Definitely could have done 3 more reps")
                }
                
                HStack{
                    Text("6.5")
                        //.frame(width: 35)
                    Rectangle()
                        .frame(width: 32)
                        .foregroundColor(.clear)
                    Text("Maybe could have done 4 more reps")
                }
                
                HStack{
                    Text("6")
                        //.frame(width: 35)
                    Rectangle()
                        .frame(width: 45)
                        .foregroundColor(.clear)
                    Text("Definitely could have done 4 more reps")
                }
                
                HStack{
                    Text("5")
                        //.frame(width: 35)
                    Rectangle()
                        .frame(width: 45)
                        .foregroundColor(.clear)
                    Text("Could have done 5 more reps")
                }
                
                HStack{
                    Text("4")
                        //.frame(width: 35)
                    Rectangle()
                        .frame(width: 45)
                        .foregroundColor(.clear)
                    Text("Could have done 6 more reps")
                }
                
                HStack{
                    Text("3")
                        //.frame(width: 35)
                    Rectangle()
                        .frame(width: 45)
                        .foregroundColor(.clear)
                    Text("Could have done 7 more reps")
                }
                
                HStack{
                    Text("2")
                        //.frame(width: 35)
                    Rectangle()
                        .frame(width: 45)
                        .foregroundColor(.clear)
                    Text("Could have done 8 more reps")
                }
                
                HStack{
                    Text("1")
                        //.frame(width: 35)
                    Rectangle()
                        .frame(width: 45)
                        .foregroundColor(.clear)
                    Text("Could have done 9 more reps")
                }
                
            }
        }
        .background(Color.abuDefault)
    }
    
}

#Preview {
    WhatRPEView()
}
