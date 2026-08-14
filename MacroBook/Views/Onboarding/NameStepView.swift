//
//  NameStepView.swift
//  MacroBook
//
//  Created by Hany Wijaya on 17/07/26.
//

import SwiftUI

struct NameStepView: View {
    @Binding var name: String
    
    var body: some View {
        NavigationStack {
            AppContainer(color: .backgroundGray) {
                VStack(spacing: 32) {
                    VStack(spacing: 8) {
//                        Image(systemName: "arrow.right")
//                            .font(.system(size: 100))
//                            .padding()
                        Text("Welcome!")
                            .font(.custom("Poppins-SemiBold", size: 24))
                            .foregroundColor(.darkBrown)
                        Text("Let's get to know you before we begin.")
                            .font(.custom("Poppins-Regular", size: 14))
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 32)
                            .foregroundColor(.darkGray)
                    }
                    
                    HStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(.darkMustardYellow.opacity(0.2))
                                .frame(width: 40, height: 40)
                            Image(systemName: "lock.fill")
                                .font(.custom("Poppins-Regular", size: 16))
                                .foregroundColor(.darkBrown)
                        }
                        Text("This information stays on your device and helps Numi to personalize your experience.")
                            .font(.custom("Poppins-Regular", size: 12))
                            .foregroundColor(.darkBrown)
                            .multilineTextAlignment(.leading)
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .background(.darkMustardYellow.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal, 32)
                    
                    VStack(alignment: .leading) {
                        Text("Your name")
                            .font(.custom("Poppins-SemiBold", size: 14))
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.darkGray)
                        TextField("Enter your name", text: $name)
                            .font(.custom("Poppins-Regular", size: 14))
                            .padding(12)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.darkBrown.opacity(0.5), lineWidth: 2))
                    }
                    .padding(.horizontal, 32)
                    
                    Spacer()
                }
                .padding(.top, 32)
            }
        }
    }
}

#Preview {
    NameStepView(name: .constant(""))
}
