//
//  EditGoalsView.swift
//  MacroBook
//
//  Created by Hany Wijaya on 06/06/26.
//

import SwiftUI
import CoreData

struct EditGoalsView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var age: String = ""
    @State private var gender: String = ""
    @State private var height: String = ""
    @State private var weight: String = ""
//    @State private var activityLevel: String = ""
    
//    @State private var sedentary: String = ""
    @State private var maintenance: String = ""
    
    @State private var trackCarbs: Bool = true
    @State private var carbsTarget: String = ""
    @State private var trackProtein: Bool = true
    @State private var proteinTarget: String = ""
    @State private var trackFat: Bool = true
    @State private var fatTarget: String = ""
    
    @ObservedObject var goalsVM: GoalsViewModel
    @ObservedObject var homeVM: HomeViewModel
    
    private var isFormValid: Bool {
        !name.isEmpty &&
        !age.isEmpty &&
        !gender.isEmpty &&
        !height.isEmpty &&
        !weight.isEmpty &&
        !maintenance.isEmpty &&
        !carbsTarget.isEmpty &&
        !proteinTarget.isEmpty &&
        !fatTarget.isEmpty
    }
    
    var body: some View {
        VStack{
            ZStack {
                Text("Your Goals")
                    .font(.system(size: 18))
                    .bold()
                
                HStack {
                    
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 18))
                            .foregroundStyle(.black)
                            .frame(width: 40, height: 40)
                            .background(Color.gray.opacity(0.15))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            .padding(.top, 20)
            
            GoalsFormView(name: $name, age: $age, gender: $gender, height: $height, weight: $weight, maintenance: $maintenance, trackCarbs: $trackCarbs, carbsTarget: $carbsTarget, trackProtein: $trackProtein, proteinTarget: $proteinTarget, trackFat: $trackFat, fatTarget: $fatTarget)
            
            Button {
                goalsVM.saveGoals(name: name, gender: gender, age: age, height: height, weight: weight, maintenance: maintenance, targetCarbs: carbsTarget, targetProtein: proteinTarget, targetFat: fatTarget)
                homeVM.refreshDashboard()
                dismiss()

            } label: {
                Text("Save")
                    .font(.custom("Poppins-Bold", size: 14))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(isFormValid ? Color.darkBrown : Color.gray.opacity(0.6))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .disabled(!isFormValid)
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .background(.backgroundGray)
        .task {
            goalsVM.loadUser()
            
            guard let user = goalsVM.user else {return}
            print(name)
            
            name = user.name ?? ""
            gender = user.gender ?? ""
            age = String(user.age.display)
            height = String(user.height.display)
            weight = String(user.weight.display)
//            activityLevel = String(user.activityLevel.display)
//            sedentary = String(user.sedentary.display)
            maintenance = String(user.maintenance.display)
            carbsTarget = String(user.targetCarbs.display)
            proteinTarget = String(user.targetProtein.display)
            fatTarget = String(user.targetFat.display)
        }
    }
}

#Preview {
    EditGoalsView(goalsVM: GoalsViewModel(context: PersistenceController.shared.container.viewContext), homeVM: HomeViewModel(context: PersistenceController.shared.container.viewContext))
}
