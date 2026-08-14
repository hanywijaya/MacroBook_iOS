//
//  NetResultCardView.swift
//  MacroBook
//
//  Created by Hany Wijaya on 30/06/26.
//

import SwiftUI

struct NetResultCardView: View {
    let title: String
    let netCalories: Double
    let intakeCalories: Double
    let burntCalories: Double
    let calorieTarget: Double
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.custom("Poppins-Medium", size: 13))
                        .foregroundColor(.darkGray)
                    HStack(alignment: .bottom) {
                        Text("\(netCalories.display) kcal")
                            .font(.custom("Poppins-SemiBold", size: 24))
                        if calorieTarget - netCalories > 0 {
                            Text("\((calorieTarget - netCalories).display) deficit")
                                .font(.custom("Poppins-Regular", size: 10))
                                .foregroundColor(.oliveGreen)
                                .padding(2)
                                .padding(.horizontal, 4)
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(.oliveGreen.opacity(0.1))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(.oliveGreen.opacity(0.6), lineWidth: 1)
                                        }
                                )
                                .padding(.bottom, 4)
                                .padding(.horizontal, 4)
                        } else if calorieTarget - netCalories == 0 {
                            Text("maintain")
                                .font(.custom("Poppins-Regular", size: 10))
                                .foregroundColor(.darkMustardYellow)
                                .padding(2)
                                .padding(.horizontal, 4)
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(.mustardYellow.opacity(0.1))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(.darkMustardYellow.opacity(0.6), lineWidth: 1)
                                        }
                                )
                                .padding(.bottom, 4)
                                .padding(.horizontal, 4)
                        } else {
                            Text("\(((calorieTarget - netCalories) * -1).display) surplus")
                                .font(.custom("Poppins-Regular", size: 10))
                                .foregroundColor(.coralPink)
                                .padding(2)
                                .padding(.horizontal, 4)
                                .background(
                                    RoundedRectangle(cornerRadius: 5)
                                        .fill(.coralPink.opacity(0.1))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(.coralPink.opacity(0.6), lineWidth: 1)
                                        }
                                )
                                .padding(.bottom, 4)
                                .padding(.horizontal, 4)
                        }
                    }
                    Text("\(intakeCalories.display) kcal intake • \(burntCalories.display) kcal burned")
                        .font(.custom("Poppins-Regular", size: 11))
                        .foregroundColor(.darkGray)
                }
                .padding(.top, 4)
                
                Spacer()
                
                CalorieProgressView(calorieNow: netCalories, calorieTarget: calorieTarget)
                    .frame(width: 80, height: 80)
                    .padding(.vertical, 8)
                
            }
            
//            Button {
//                showAddIntake = true
//            } label: {
//                HStack {
//                    Image(systemName: "plus.circle")
//                    Text("Add intake")
//                }
//                .font(.custom("Poppins-Medium", size: 12))
//                .foregroundStyle(.white)
//                .frame(maxWidth: .infinity)
//                .padding(.vertical, 8)
//                .background(.darkBrown)
//                .clipShape(RoundedRectangle(cornerRadius: 10))
//            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 24)
        .background(.cardBackground)
        .cornerRadius(10)
        .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 0)
        .padding()
    }
}

#Preview {
    AppContainer(color: .backgroundGray) {
        NetResultCardView(title: "Net calories", netCalories: 1100, intakeCalories: 1500, burntCalories: 400, calorieTarget: 1500)
    }
}
