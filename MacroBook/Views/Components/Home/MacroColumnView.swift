//
//  MacroColumnView.swift
//  MacroBook
//
//  Created by Hany Wijaya on 27/06/26.
//

import SwiftUI

struct MacroColumnView: View {
    let title: String
    let value: Double

    var body: some View {

        VStack(alignment: .center, spacing: 2) {

            Text(title)
                .font(.custom("Poppins-Medium", size: 10))
                .foregroundColor(.darkGray)

            if title == "Serving" {
                Text("\(value.formatted())")
                    .font(.custom("Poppins-SemiBold", size: 12))
            } else {
                Text("\(value.formatted())g")
                    .font(.custom("Poppins-SemiBold", size: 12))
            }
        }
    }
}

#Preview {
    MacroColumnView(title: "Carbs", value: 50)
}
