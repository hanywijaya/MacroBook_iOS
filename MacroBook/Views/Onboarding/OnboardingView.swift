//
//  OnboardingView.swift
//  MacroBook
//
//  Created by Hany Wijaya on 17/07/26.
//

import SwiftUI

enum Step: Int {
    case welcome
    case name
    case body
    case goal
}

struct OnboardingView: View {
    @ObservedObject var goalsVM: GoalsViewModel
    @State private var currentStep = 0
    
    @State private var name: String = ""
    @State private var age: String = ""
    @State private var gender: String = ""
    @State private var height: String = ""
    @State private var weight: String = ""
    @State private var maintenance: String = ""
    @State private var carbs: String = ""
    @State private var protein: String = ""
    @State private var fat: String = ""
    
    var canContinue: Bool {
        switch currentStep {
        case 1:
            return !name.isEmpty

        case 2:
            return !age.isEmpty &&
                   !gender.isEmpty &&
                   !height.isEmpty &&
                   !weight.isEmpty

        case 3:
            return !maintenance.isEmpty &&
                   !protein.isEmpty &&
                   !carbs.isEmpty &&
                   !fat.isEmpty

        default:
            return true
        }
    }

    let totalSteps: Double = 4
    
    var body: some View {
//        NavigationStack {
            AppContainer(color: .backgroundGray) {
                VStack {
                    ProgressBarView(progress: Double(currentStep)/totalSteps)
                    .padding()
                    .padding(.horizontal)
                    .padding(.top, 24)
                    
                    TabView(selection: $currentStep) {
                        WelcomeStepView()
                            .tag(0)
                        
                        NameStepView(name: $name)
                            .tag(1)
                        
                        BodyStepView(age: $age, gender: $gender, height: $height, weight: $weight)
                            .tag(2)
                        
                        GoalsStepView(maintenance: $maintenance, targetCarbs: $carbs, targetProtein: $protein, targetFat: $fat)
                            .tag(3)
                        
                        FinishStepView()
                            .tag(4)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                }
                .safeAreaInset(edge: .bottom) {
                    
                    if Double(currentStep) >= totalSteps {
                        Button {
                            withAnimation {
                                goalsVM.saveGoals(name: name, gender: gender, age: age, height: height, weight: weight, maintenance: maintenance, targetCarbs: carbs, targetProtein: protein, targetFat: fat)
                            }
                        } label: {
                            HStack {
                                Text("Start Tracking!")
                                    .font(.custom("Poppins-Regular", size: 14))
                                    .foregroundColor(.white)
                                Image(systemName: "arrow.right")
                                    .font(.system(size: 13))
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.darkBrown)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .padding(.horizontal, 32)
                            .transition(.move(edge: .trailing))
                        }
                    } else {
                        Button {
                            if Double(currentStep) < totalSteps {
                                withAnimation {
                                    currentStep += 1
                                }
                            } else {
                                goalsVM.saveGoals(name: name, gender: gender, age: age, height: height, weight: weight, maintenance: maintenance, targetCarbs: carbs, targetProtein: protein, targetFat: fat)
                            }
                        } label: {
                            HStack {
                                if Double(currentStep) < totalSteps {
                                    Text("Continue")
                                        .font(.custom("Poppins-SemiBold", size: 14))
                                        .foregroundColor(.white)
                                } else {
                                    Text("Start Tracking")
                                        .font(.custom("Poppins-SemiBold", size: 14))
                                        .foregroundColor(.white)
                                }
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(canContinue ? .darkBrown : .gray.opacity(0.6))
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .padding(.horizontal, 32)
                        }
                        .disabled(!canContinue)
//                        HStack {
//                            Button {
//                                if Double(currentStep) > 0 {
//                                    withAnimation {
//                                        currentStep -= 1
//                                    }
//                                }
//                            } label: {
//                                HStack {
//                                    Image(systemName: "arrow.left")
//                                        .font(.system(size: 13))
//                                        .foregroundColor(.white)
//                                    Text("Previous")
//                                        .font(.custom("Poppins-Regular", size: 14))
//                                        .foregroundColor(.white)
//                                }
//                                .padding()
//                                .frame(maxWidth: .infinity)
//                                .background(currentStep == 0 ? .gray.opacity(0.6) : .darkBrown)
//                                .clipShape(RoundedRectangle(cornerRadius: 30))
//                                .padding(.leading, 32)
//                            }
//                            .disabled(currentStep == 0)
//                            
//                            Button {
//                                if Double(currentStep) < totalSteps {
//                                    withAnimation {
//                                        currentStep += 1
//                                    }
//                                } else {
//                                    goalsVM.saveGoals(name: name, gender: gender, age: age, height: height, weight: weight, maintenance: maintenance, targetCarbs: carbs, targetProtein: protein, targetFat: fat)
//                                }
//                            } label: {
//                                HStack {
//                                    Text("Next")
//                                        .font(.custom("Poppins-Regular", size: 14))
//                                        .foregroundColor(.white)
//                                    Image(systemName: "arrow.right")
//                                        .font(.system(size: 13))
//                                        .foregroundColor(.white)
//                                }
//                                .padding()
//                                .frame(maxWidth: .infinity)
//                                .background(.darkBrown)
//                                .clipShape(RoundedRectangle(cornerRadius: 30))
//                                .padding(.trailing, 32)
//                            }
//                        }
                    }
                }
//                VStack {
//                    Text("MacroBook")
//                        .font(.custom("Poppins-SemiBold", size: 32))
//                    NavigationLink {
//                        NameStepView()
//                    } label: {
//                        HStack {
//                            Text("Get Started")
//                                .font(.custom("Poppins-Regular", size: 14))
//                            Image(systemName: "arrow.right")
//                                .font(.system(size: 14))
//                        }
//                        .foregroundColor(.white)
//                        .padding()
//                        .padding(.horizontal, 28)
//                        .background(.darkBrown)
//                        .clipShape(RoundedRectangle(cornerRadius: 30))
//                    }
//                }
            }
        }
//    }
}

#Preview {
    OnboardingView(goalsVM: GoalsViewModel(context: PersistenceController.shared.container.viewContext))
}
