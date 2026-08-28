//
//  IntakeDetailView.swift
//  MacroBook
//
//  Created by Hany Wijaya on 29/06/26.
//

import SwiftUI

struct IntakeDetailView: View {
    let log: Log
    
    var body: some View {
        VStack {
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
                    Text("Serving")
                        .font(.custom("Poppins-Regular", size: 12))
                        .foregroundColor(.darkBrown)
                    
                    Spacer()
                    
                    Text("\((log.serving ?? 1).displayWithDecimal)")
                        .font(.custom("Poppins-Regular", size: 12))
                        .foregroundColor(.darkGray)
                }
                .padding(.top, 8)
                
                Divider()
                    .padding(.vertical, 4)
                
                HStack(alignment: .center) {
                    Text("Note")
                        .font(.custom("Poppins-Regular", size: 12))
                        .foregroundColor(.darkBrown)
                    
                    Spacer()
                    
                    Text("\(Formatter.formatEmptyNote(text: log.note ?? ""))")
                        .font(.custom("Poppins-Regular", size: 12))
                        .foregroundColor(.darkGray)
                }
                .padding(.vertical, 4)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(10)
            .shadow(color: .gray.opacity(0.25), radius: 5, x: 0, y: 0)
            .padding(.top)
            .padding(.horizontal)
            
            VStack(alignment: .leading) {
                Text("Macros")
                    .font(.custom("Poppins-Medium", size: 14))
                    .foregroundColor(.darkBrown)
                    .padding(.bottom)
                
                MacroRowView(title: "Carbs", value: (log.carbs ?? 0))
                Divider()
                MacroRowView(title: "Protein", value: (log.protein ?? 0))
                Divider()
                MacroRowView(title: "Fat", value: (log.fat ?? 0))
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(10)
            .shadow(color: .gray.opacity(0.25), radius: 5, x: 0, y: 0)
            .padding()
        }
    }
}


#Preview {
    IntakeDetailView(log: Log(id: nil, type: .intake, timestamp: Calendar.current.date(from: DateComponents(year: 2026, month: 6, day: 27, hour: 8, minute: 30))!, title: "Milk", note: "200ml", calories: 60, protein: 6, carbs: 9, fat: 0, serving: 0.5))
        .background(.cardBackground)
}
