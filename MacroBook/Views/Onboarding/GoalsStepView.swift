//
//  GoalsStepView.swift
//  MacroBook
//
//  Created by Hany Wijaya on 18/07/26.
//

import SwiftUI

struct GoalsStepView: View {
    @Binding var maintenance: String
    @Binding var targetCarbs: String
    @Binding var targetProtein: String
    @Binding var targetFat: String
    
    @State private var showInfo = false
    
    var body: some View {
        NavigationStack {
            AppContainer(color: .backgroundGray) {
                VStack(spacing: 32) {
                    VStack(spacing: 8) {
                        Text("Personalize your weight loss journey")
                            .font(.custom("Poppins-SemiBold", size: 24))
                            .foregroundColor(.darkBrown)
                            .multilineTextAlignment(.center)
                        Text("Customize your calorie and macro goals, then let Numi track your progress.")
                            .font(.custom("Poppins-Regular", size: 14))
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 32)
                            .foregroundColor(.darkGray)
                    }
                    
                    ScrollView {
                        VStack(spacing: 32) {
                            VStack(alignment: .leading) {
                                HStack(alignment: .bottom) {
                                    Text("Maintenance calories")
                                        .font(.custom("Poppins-SemiBold", size: 14))
                                        .multilineTextAlignment(.leading)
                                        .foregroundColor(.darkGray)
                                    Spacer()
                                    Button {
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            showInfo.toggle()
                                        }
                                    } label: {
                                        Image(systemName: "info.circle.fill")
                                            .font(.system(size: 14))
                                            .foregroundColor(.darkGray)
                                    }
                                }
                                HStack {
                                    TextField("0", text: $maintenance)
                                        .font(.custom("Poppins-Regular", size: 14))
                                        .keyboardType(.numberPad)
                                    Text("kcal")
                                        .font(.custom("Poppins-Regular", size: 14))
                                        .foregroundColor(.darkBrown.opacity(0.7))
                                }
                                .padding(12)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.darkBrown.opacity(0.5), lineWidth: 2))
                                
                                if showInfo {
                                    Text("**Activity varies throughout the week?**\nStart with your sedentary maintenance calories and log your workouts to keep your calorie balance accurate.\n\n**Already know your average maintenance (TDEE)?**\nEnter your TDEE maintenance calories instead—no activity logging needed.")
                                        .font(.custom("Poppins-Regular", size: 11))
                                        .foregroundColor(.darkBrown.opacity(0.7))
                                        .padding(.top)
                                        .frame(maxHeight: showInfo ? .infinity : 0)
                                        .clipped()
                                        .opacity(showInfo ? 1 : 0)
                                }
                            }
                            
                            VStack(alignment: .leading) {
                                Text("Carbs goal")
                                    .font(.custom("Poppins-SemiBold", size: 14))
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.darkGray)
                                HStack {
                                    TextField("0", text: $targetCarbs)
                                        .font(.custom("Poppins-Regular", size: 14))
                                        .keyboardType(.numberPad)
                                    Text("g")
                                        .font(.custom("Poppins-Regular", size: 14))
                                        .foregroundColor(.darkBrown.opacity(0.7))
                                }
                                .padding(12)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.darkBrown.opacity(0.5), lineWidth: 2))
                            }
                            .background(.backgroundGray)
                            
                            VStack(alignment: .leading) {
                                Text("Protein goal")
                                    .font(.custom("Poppins-SemiBold", size: 14))
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.darkGray)
                                HStack {
                                    TextField("0", text: $targetProtein)
                                        .font(.custom("Poppins-Regular", size: 14))
                                        .keyboardType(.numberPad)
                                    Text("g")
                                        .font(.custom("Poppins-Regular", size: 14))
                                        .foregroundColor(.darkBrown.opacity(0.7))
                                }
                                .padding(12)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.darkBrown.opacity(0.5), lineWidth: 2))
                            }
                            
                            VStack(alignment: .leading) {
                                Text("Fat goal")
                                    .font(.custom("Poppins-SemiBold", size: 14))
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.darkGray)
                                HStack {
                                    TextField("0", text: $targetFat)
                                        .font(.custom("Poppins-Regular", size: 14))
                                        .keyboardType(.numberPad)
                                    Text("g")
                                        .font(.custom("Poppins-Regular", size: 14))
                                        .foregroundColor(.darkBrown.opacity(0.7))
                                }
                                .padding(12)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.darkBrown.opacity(0.5), lineWidth: 2))
                            }
                            .padding(.bottom)
                        }
                        .padding(.horizontal, 1)
                    }
                    .padding(.horizontal, 32)
                    
                    Spacer()
                }
                .padding(.top, 32)
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    GoalsStepView(maintenance: .constant(""), targetCarbs: .constant(""), targetProtein: .constant(""), targetFat: .constant(""))
}
