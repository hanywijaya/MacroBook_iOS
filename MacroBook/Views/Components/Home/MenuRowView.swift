//
//  MenuRowView.swift
//  MacroBook
//
//  Created by Hany Wijaya on 27/06/26.
//

import SwiftUI

struct MenuRowView: View {
    let icon: String
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Text(title)
                    .font(.custom("Poppins-Medium", size: 13))
                    .foregroundColor(.darkGray)

                Spacer()
                
                Image(systemName: icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 16)
                    .foregroundColor(.darkGray)
            }
            .padding()
            .background(Color.black.opacity(0.0001))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    MenuRowView(icon: "fork.knife", title: "Add Intake") {
        // action
    }
}
