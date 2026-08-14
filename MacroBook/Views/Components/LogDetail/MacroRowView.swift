//
//  MacroRowView.swift
//  MacroBook
//
//  Created by Hany Wijaya on 28/06/26.
//

import SwiftUI

struct MacroRowView: View {
    let title: String
    let value: Double
    
    private var systemName: String {
        switch title {
        case "Carbs":
            return "leaf.fill"
        case "Protein":
            return "fish.fill"
        case "Fat":
            return "drop.fill"
        default:
            return ""
        }
    }
    
    private var macroColor: Color {
        switch title {
        case "Carbs":
            return .coralPink
        case "Protein":
            return .oliveGreen
        case "Fat":
            return .mustardYellow
        default:
            return .gray
        }
    }
    
    private var darkMacroColor: Color {
        switch title {
        case "Carbs":
            return .darkCoralPink
        case "Protein":
            return .darkOliveGreen
        case "Fat":
            return .darkMustardYellow
        default:
            return .gray
        }
    }
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(.darkBrown.opacity(0.06))
                    .frame(width: 28)
                
                
                Image(systemName: systemName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 12)
                    .bold()
                    .foregroundColor(macroColor)
            }
            
            Text(title)
                .font(.custom("Poppins-Regular", size: 12))
                .foregroundColor(.darkBrown)
            
            Spacer()
            
            Text("\(value.display)")
                .font(.custom("Poppins-SemiBold", size: 14))
                .foregroundColor(darkMacroColor)
                .padding(.trailing, -4)
            
            Text("g")
                .font(.custom("Poppins-Regular", size: 12))
                .foregroundColor(darkMacroColor)
        }
    }
}

#Preview {
    MacroRowView(title: "Protein", value: 60)
}
