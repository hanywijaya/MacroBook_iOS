//
//  CalorieProgressView.swift
//  MacroBook
//
//  Created by Hany Wijaya on 27/06/26.
//

import SwiftUI

struct CalorieProgressView: View {
    let calorieNow: Double
    let calorieTarget: Double
    
    private var progress: Double {
        guard calorieTarget > 0 else { return 0 }
        return min(calorieNow/calorieTarget, 1)
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.darkBrown.opacity(0.15), lineWidth: 7)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.darkBrown.opacity(0.8), style: StrokeStyle(lineWidth: 7, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
            
            VStack (spacing: 6){
                Image(systemName: "flame.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 18)
                    .foregroundColor(.darkMustardYellow.opacity(0.8))
                Text("\(Int(progress * 100).formatted(.number))%")
                    .font(.custom("Poppins-Medium", size: 12))
                    .foregroundColor(.darkBrown)
            }
            .padding(.top, 2)
        }
    }
}

#Preview {
    HStack {
        CalorieProgressView(calorieNow: 40.5, calorieTarget: 160)
            .frame(width: 90, height: 90)
            .padding(.horizontal, 10)
    }
}
