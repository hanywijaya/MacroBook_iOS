//
//  ActivityBurnDetailView.swift
//  MacroBook
//
//  Created by Hany Wijaya on 29/06/26.
//

import SwiftUI

struct ActivityBurnDetailView: View {
    let log: Log
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .center) {
                    Text("Calories")
                        .font(.custom("Poppins-Regular", size: 11))
                        .foregroundColor(.darkGray)
                    
                    Text("\(log.calories.display) kcal")
                        .font(.custom("Poppins-Semibold", size: 20))
                        .foregroundColor(.darkBrown)
                }
                .frame(maxWidth: .infinity)
            }
            
            HStack(alignment: .center) {
                Text("Note")
                    .font(.custom("Poppins-Regular", size: 12))
                    .foregroundColor(.darkBrown)
                
                Spacer()
                
                Text("\(Formatter.formatEmptyNote(text: log.note ?? ""))")
                    .font(.custom("Poppins-Regular", size: 12))
                    .foregroundColor(.darkGray)
            }
            .padding(.top, 8)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(10)
        .shadow(color: .gray.opacity(0.25), radius: 5, x: 0, y: 0)
        .padding(.top)
        .padding(.horizontal)
    }
}

#Preview {
    ActivityBurnDetailView(log: Log(id: nil, type: .activityBurn, timestamp: Calendar.current.date(from: DateComponents(year: 2026, month: 6, day: 27, hour: 8, minute: 30))!, title: "15k steps", note: "", calories: 300, protein: 0, carbs: 0, fat: 0, serving: 0))
        .background(.cardBackground)
}
