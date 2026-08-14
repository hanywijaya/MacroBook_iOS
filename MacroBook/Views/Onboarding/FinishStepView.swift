//
//  FinishStepView.swift
//  MacroBook
//
//  Created by Hany Wijaya on 18/07/26.
//

import SwiftUI

struct FinishStepView: View {
    var body: some View {
        NavigationStack {
            AppContainer(color: .backgroundGray) {
                VStack(spacing: 32) {
                    Text("You're all set!")
                        .font(.custom("Poppins-SemiBold", size: 32))
                    Text("Your personalized goals have been saved.\n\nStart logging your meals and activities to stay on track with your nutrition goals.")
                        .font(.custom("Poppins-Regular", size: 14))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                        .foregroundColor(.darkGray)
                }
            }
        }
    }
}

#Preview {
    FinishStepView()
}
