//
//  GoalsFormView.swift
//  MacroBook
//
//  Created by Hany Wijaya on 30/06/26.
//

import SwiftUI

struct GoalsFormView: View {
    
    let genderOptions = ["Male", "Female"]
    
    @Binding var name: String
    @Binding var age: String
    @Binding var gender: String
    @Binding var height: String
    @Binding var weight: String
//    @Binding var activityLevel: String
    
//    @Binding var sedentary: String
    @Binding var maintenance: String
    
    @Binding var trackCarbs: Bool
    @Binding var carbsTarget: String
    @Binding var trackProtein: Bool
    @Binding var proteinTarget: String
    @Binding var trackFat: Bool
    @Binding var fatTarget: String
    
    var body: some View {
        List {
            Section {
                HStack {
                    Text("Name")
                        .font(.custom("Poppins-Regular", size: 14))
                    Spacer()
                    TextField("Add a name", text: $name)
                        .font(.custom("Poppins-Regular", size: 14))
                        .multilineTextAlignment(.trailing)
                }
                
                HStack {
                    Text("Gender")
                        .font(.custom("Poppins-Regular", size: 14))
                    Spacer()
                    Menu {
                        ForEach(genderOptions, id: \.self) { option in
                            Button(option) {
                                gender = option
                            }
                        }
                    } label: {
                        Text(gender.isEmpty ? "Select" : gender)
                            .font(.custom("Poppins-Regular", size: 14))
                        Image(systemName: "chevron.down")
                            .resizable()
                            .frame(width: 10, height: 6)
                    }
                    .foregroundStyle(gender.isEmpty ? .gray.opacity(0.5) : .black)
                }
                
                HStack {
                    Text("Age")
                        .font(.custom("Poppins-Regular", size: 14))
                    Spacer()
                    TextField("0", text: $age)
                        .font(.custom("Poppins-Regular", size: 14))
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.numberPad)
                }
                
                HStack {
                    Text("Height")
                        .font(.custom("Poppins-Regular", size: 14))
                    Spacer()
                    HStack {
                        TextField("0", text: $height)
                            .font(.custom("Poppins-Regular", size: 14))
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.numberPad)
                        Text("cm")
                            .font(.custom("Poppins-Regular", size: 14))
                    }
                }
                
                HStack {
                    Text("Weight")
                        .font(.custom("Poppins-Regular", size: 14))
                    Spacer()
                    HStack {
                        TextField("0", text: $weight)
                            .font(.custom("Poppins-Regular", size: 14))
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.numberPad)
                        Text("kg")
                            .font(.custom("Poppins-Regular", size: 14))
                    }
                }
                
                HStack {
                    Text("Maintenance calories")
                        .font(.custom("Poppins-Regular", size: 14))
                    Spacer()
                    HStack {
                        TextField("0", text: $maintenance)
                            .font(.custom("Poppins-Regular", size: 14))
                            .multilineTextAlignment(.trailing)
                        Text("kcal")
                            .font(.custom("Poppins-Regular", size: 14))
                    }
                }
            }
            
            Section(header: Text("MACRO GOALS")) {
                HStack {
                    Text("Carbs")
                        .font(.custom("Poppins-Regular", size: 14))
                    Spacer()
                    HStack {
                        TextField("0", text: $carbsTarget)
                            .font(.custom("Poppins-Regular", size: 14))
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.numberPad)
                        Text("g")
                            .font(.custom("Poppins-Regular", size: 14))
                    }
                }
                
                HStack {
                    Text("Protein")
                        .font(.custom("Poppins-Regular", size: 14))
                    Spacer()
                    HStack {
                        TextField("0", text: $proteinTarget)
                            .font(.custom("Poppins-Regular", size: 14))
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.numberPad)
                        Text("g")
                            .font(.custom("Poppins-Regular", size: 14))
                    }
                }
                
                HStack {
                    Text("Fat")
                        .font(.custom("Poppins-Regular", size: 14))
                    Spacer()
                    HStack {
                        TextField("0", text: $fatTarget)
                            .font(.custom("Poppins-Regular", size: 14))
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.numberPad)
                        Text("g")
                            .font(.custom("Poppins-Regular", size: 14))
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(.backgroundGray)
    }
}
