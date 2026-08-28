//
//  IntakeFormView.swift
//  MacroBook
//
//  Created by Hany Wijaya on 30/06/26.
//

import SwiftUI

struct IntakeFormView: View {
    @Binding var title: String
    @Binding var date: Date
    @Binding var serving: String
    @Binding var note: String
    
    @Binding var calories: String
    @Binding var carbs: String
    @Binding var protein: String
    @Binding var fat: String
    
    @FocusState private var titleFieldFocused: Bool
    
    var body: some View {
//        TextField("Title", text: $title)
//            .font(.custom("Poppins-SemiBold", size: 32))
//            .multilineTextAlignment(.center)
//            .focused($titleFieldFocused)
//            .padding(.top, 32)
//            .onAppear {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//                    titleFieldFocused = true
//                }
//            }
        
        TextField("Title", text: $title, axis: .vertical)
            .font(.custom("Poppins-SemiBold", size: 28))
            .multilineTextAlignment(.center)
            .lineLimit(1...3)
            .focused($titleFieldFocused)
            .padding(.horizontal, 24)
            .padding(.top, 28)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    titleFieldFocused = true
                }
            }
        
        List {
            Section {
                HStack {
                    Text("Date")
                        .font(.custom("Poppins-Regular", size: 14))
                    Spacer()
                    DatePicker("", selection: $date, displayedComponents: .date)
                }
                
                HStack {
                    Text("Serving")
                        .font(.custom("Poppins-Regular", size: 14))
                    Spacer()
                    TextField("1", text: $serving)
                        .font(.custom("Poppins-Regular", size: 14))
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                }
                
                HStack {
                    Text("Note")
                        .font(.custom("Poppins-Regular", size: 14))
                    Spacer()
                    TextField("Add a note", text: $note)
                        .font(.custom("Poppins-Regular", size: 14))
                        .multilineTextAlignment(.trailing)
                }
            }
            
            Section(header: Text("PER SERVING")) {
                HStack {
                    Text("Calories")
                        .font(.custom("Poppins-Regular", size: 14))
                    Spacer()
                    HStack {
                        TextField("0", text: $calories)
                            .font(.custom("Poppins-Regular", size: 14))
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.numberPad)
                        Text("kcal")
                            .font(.custom("Poppins-Regular", size: 14))
                    }
                }
                
                HStack {
                    Text("Carbs")
                        .font(.custom("Poppins-Regular", size: 14))
                    Spacer()
                    HStack {
                        TextField("0", text: $carbs)
                            .font(.custom("Poppins-Regular", size: 14))
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.numberPad)
                        Text("g")
                            .font(.custom("Poppins-Regular", size: 14))
                    }
                }
                
                HStack {
                    Text("Protein")
                        .font(.custom("Poppins-Regular", size: 14))
                    Spacer()
                    HStack {
                        TextField("0", text: $protein)
                            .font(.custom("Poppins-Regular", size: 14))
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.numberPad)
                        Text("g")
                            .font(.custom("Poppins-Regular", size: 14))
                    }
                }
                
                HStack {
                    Text("Fat")
                        .font(.custom("Poppins-Regular", size: 14))
                    Spacer()
                    HStack {
                        TextField("0", text: $fat)
                            .font(.custom("Poppins-Regular", size: 14))
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.numberPad)
                        Text("g")
                            .font(.custom("Poppins-Regular", size: 14))
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(.backgroundGray)
    }
}
