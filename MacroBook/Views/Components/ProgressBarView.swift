//
//  ProgressBarView.swift
//  MacroBook
//
//  Created by Hany Wijaya on 18/07/26.
//
import SwiftUI

struct ProgressBarView: View {
    let progress: Double

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(.darkBrown.opacity(0.1))

                Capsule()
                    .fill(.darkBrown)
                    .frame(width: geo.size.width * progress)
            }
        }
        .frame(height: 5)
    }
}

#Preview {
    ProgressBarView(progress: 0.5)
}
