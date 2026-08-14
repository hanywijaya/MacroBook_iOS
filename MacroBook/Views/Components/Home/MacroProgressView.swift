//
//  CircularProgressView.swift
//  MacroBook
//
//  Created by Hany Wijaya on 03/06/26.
//

import SwiftUI

struct MacroProgressView: View {
    let title: String
    let macroNow: Double
    let macroTarget: Double
    
    private var progress: Double {
        guard macroTarget > 0 else { return 0 }
        return min(macroNow/macroTarget, 1)
    }
    
    private var macroColor: Color {
        switch title {
        case "Protein":
            return Color.oliveGreen
        case "Carbs":
            return Color.coralPink
        case "Fat":
            return Color.mustardYellow
        default:
            return .gray
        }
    }
    
    private var darkMacroColor: Color {
        switch title {
        case "Protein":
            return Color.darkOliveGreen
        case "Carbs":
            return Color.darkCoralPink
        case "Fat":
            return Color.darkMustardYellow
        default:
            return .gray
        }
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(macroColor.opacity(0.5), lineWidth: 7)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(darkMacroColor.opacity(0.5), style: StrokeStyle(lineWidth: 7, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
            
            VStack {
                HStack {
                    Text(title)
                        .font(.custom("Poppins-Medium", size: 10))
                        .foregroundColor(.darkGray)
                }
                Text("\(macroNow.display)g")
                    .font(.custom("Poppins-SemiBold", size: 12))
                Text("/\(macroTarget.display)g")
                    .font(.custom("Poppins-Regular", size: 10))
                    .foregroundColor(darkMacroColor)
            }
            
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 8)
        .background(.cardBackground)
        .cornerRadius(5)
        .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 0)
    }
}

#Preview {
    HStack {
        MacroProgressView(title: "Carbs", macroNow: 10.4563, macroTarget: 160)
            .frame(width: 110)
        MacroProgressView(title: "Protein", macroNow: 40, macroTarget: 160)
            .frame(width: 110)
        MacroProgressView(title: "Fat", macroNow: 16, macroTarget: 160)
            .frame(width: 110)
    }
}
