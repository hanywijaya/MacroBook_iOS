//
//  LogCardView.swift
//  MacroBook
//
//  Created by Hany Wijaya on 04/06/26.
//

import SwiftUI

struct LogCardView: View {
    let timestamp: Date
    let title: String
    let calories: Double
    let type: LogType
    let carbs: Double?
    let protein: Double?
    let fat: Double?
    let serving: Double?
    
    private var isIntake: Bool {
        type == .intake
    }
    
    private var calorieText: String {
        if isIntake {
            return "+ \(calories.display) kcal"
        } else {
            return "- \(calories.display) kcal"
        }
    }
    
    init(timestamp: Date, title: String, calories: Double, type: LogType, carbs: Double? = nil, protein: Double? = nil, fat: Double? = nil, serving: Double? = nil) {
        self.timestamp = timestamp
        self.title = title
        self.calories = calories
        self.type = type
        self.carbs = carbs
        self.protein = protein
        self.fat = fat
        self.serving = serving
    }
    
    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter
    }()
    
    var body: some View {
        HStack(alignment: .top) {
            ZStack {
                Circle()
                    .fill(.darkMustardYellow.opacity(0.15))
                    .frame(width: 40)
                
                if isIntake {
                    Image(systemName: "fork.knife")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 18)
                        .bold()
                        .foregroundColor(.darkBrown.opacity(0.8))
                } else {
                    Image(systemName: "figure.run")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 18)
                        .bold()
                        .foregroundColor(.darkBrown.opacity(0.8))
                }
            }
            .padding(.trailing, 4)
            .padding(.top, 1)
            
            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    VStack(alignment: .leading) {
                        Text(timeFormatter.string(from: timestamp))
                            .font(.custom("Poppins-Medium", size: 11))
                            .foregroundColor(.darkGray)
                        Text(title)
                            .font(.custom("Poppins-SemiBold", size: 14))
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                    .padding(.trailing, 16)
                    
                    Spacer()
                    
                    Text(calorieText)
                        .font(.custom("Poppins-SemiBold", size: 12))
                        .padding(.top, -10)
                }
                .padding(.bottom, 4)
                
                if isIntake {
                        HStack {
                            MacroColumnView(title: "Carbs", value: carbs ?? 0)
                            Spacer()
                            Divider()
                            Spacer()
                            MacroColumnView(title: "Protein", value: protein ?? 0)
                            Spacer()
                            Divider()
                            Spacer()
                            MacroColumnView(title: "Fat", value: fat ?? 0)
                            Spacer()
                            Divider()
                            Spacer()
                            MacroColumnView(title: "Serving", value: serving ?? 0)
                            Spacer()
                        }
                        .frame(height: 38)

                    } else {

                        Divider()

                        Text("Activity Burn")
                            .font(.custom("Poppins-Medium", size: 11))
                            .foregroundColor(.darkGray)
                    }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 0)
    }
}

#Preview {
    VStack {
        LogCardView(timestamp: Calendar.current.date(from: DateComponents(year: 2026, month: 6, day: 27, hour: 8, minute: 30))!, title: "NutriMotion Banana Meal Replacement", calories: 847, type: .intake, carbs: 50, protein: 70, fat: 50, serving: 1)
        LogCardView(timestamp: Calendar.current.date(from: DateComponents(year: 2026, month: 6, day: 27, hour: 8, minute: 30))!, title: "Gyukaku", calories: 847, type: .intake, carbs: 50, protein: 70, fat: 50, serving: 1)
        LogCardView(timestamp: Calendar.current.date(from: DateComponents(year: 2026, month: 6, day: 27, hour: 8, minute: 30))!, title: "2500 steps", calories: 847, type: .activityBurn)
        LogCardView(timestamp: Calendar.current.date(from: DateComponents(year: 2026, month: 6, day: 27, hour: 8, minute: 30))!, title: "2500 steps", calories: 847, type: .activityBurn)
    }
    .padding(.horizontal, 16)
}
