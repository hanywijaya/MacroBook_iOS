//
//  BodyStepView.swift
//  MacroBook
//
//  Created by Hany Wijaya on 18/07/26.
//

import SwiftUI

struct BodyStepView: View {
    let genderOptions = ["Male", "Female"]
    
    @Binding var age: String
    @Binding var gender: String
    @Binding var height: String
    @Binding var weight: String
    
    var body: some View {
        NavigationStack {
            AppContainer(color: .backgroundGray) {
                VStack(spacing: 32) {
                    VStack(spacing: 8) {
                        Text("Tell us about yourself")
                            .font(.custom("Poppins-SemiBold", size: 24))
                            .foregroundColor(.darkBrown)
                        Text("We'll use these information to personalize your progress profile and track your progress.")
                            .font(.custom("Poppins-Regular", size: 14))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 32)
                            .foregroundColor(.darkGray)
                    }
                    
                    ScrollView {
                        VStack(spacing: 32) {
                            VStack(alignment: .leading) {
                                Text("Age")
                                    .font(.custom("Poppins-SemiBold", size: 14))
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.darkGray)
                                TextField("Enter your age", text: $age)
                                    .font(.custom("Poppins-Regular", size: 14))
                                    .keyboardType(.numberPad)
                                    .padding(12)
                                    .background(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(.darkBrown.opacity(0.5), lineWidth: 2))
                            }
                            
                            VStack(alignment: .leading) {
                                Text("Gender")
                                    .font(.custom("Poppins-SemiBold", size: 14))
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.darkGray)
                                HStack(spacing: 12) {
                                    ForEach(genderOptions, id: \.self) { option in
                                        Button {
                                            gender = option
                                        } label: {
                                            Text(option)
                                                .font(.custom("Poppins-Medium", size: 14))
                                                .frame(maxWidth: .infinity)
                                                .padding(.vertical, 12)
                                                .background(gender == option ? Color.darkBrown : Color.white)
                                                .foregroundStyle(gender == option ? .white : .darkGray)
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .stroke(.darkBrown.opacity(0.5), lineWidth: 2)
                                                }
                                        }
                                    }
                                }
                            }
                            
                            VStack(alignment: .leading) {
                                Text("Height")
                                    .font(.custom("Poppins-SemiBold", size: 14))
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.darkGray)
                                HStack {
                                    TextField("Enter your height", text: $height)
                                        .font(.custom("Poppins-Regular", size: 14))
                                        .keyboardType(.numberPad)
                                    Text("cm")
                                        .font(.custom("Poppins-Regular", size: 14))
                                        .foregroundColor(.darkBrown.opacity(0.7))
                                }
                                .padding(12)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.darkBrown.opacity(0.5), lineWidth: 2))
                            }
                            
                            VStack(alignment: .leading) {
                                Text("Weight")
                                    .font(.custom("Poppins-SemiBold", size: 14))
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.darkGray)
                                HStack {
                                    TextField("Enter your weight", text: $weight)
                                        .font(.custom("Poppins-Regular", size: 14))
                                        .keyboardType(.numberPad)
                                    Text("kg")
                                        .font(.custom("Poppins-Regular", size: 14))
                                        .foregroundColor(.darkBrown.opacity(0.7))
                                }
                                .padding(12)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.darkBrown.opacity(0.5), lineWidth: 2))
                            }
                        }
                        .padding(.horizontal, 32)
                    }
                    .scrollIndicators(.hidden)
                    
                    Spacer()
                }
                .padding(.top, 32)
            }
        }
    }
}

#Preview {
    @Previewable @State var gender = ""
    
    BodyStepView(age: .constant(""), gender: $gender, height: .constant(""), weight: .constant(""))
}
