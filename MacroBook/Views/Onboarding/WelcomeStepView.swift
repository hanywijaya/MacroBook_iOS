//
//  WelcomeStepView.swift
//  MacroBook
//
//  Created by Hany Wijaya on 17/07/26.
//

import SwiftUI

struct WelcomeStepView: View {
    var body: some View {
        VStack {
            Image(.appLogo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 64)
                .padding(.horizontal, 48)
            Text("Start personalizing your own weight loss journey!")
                .font(.custom("Poppins-Regular", size: 14))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
                .padding(.top, 16)
                .foregroundStyle(.darkGray)
//            NavigationLink {
//                NameStepView()
//            } label: {
//                HStack {
//                    Text("Get Started")
//                        .font(.custom("Poppins-Regular", size: 14))
//                    Image(systemName: "arrow.right")
//                        .font(.system(size: 14))
//                }
//                .foregroundColor(.white)
//                .padding()
//                .padding(.horizontal, 28)
//                .background(.darkBrown)
//                .clipShape(RoundedRectangle(cornerRadius: 30))
//            }
        }
    }
}

#Preview {
    WelcomeStepView()
}
