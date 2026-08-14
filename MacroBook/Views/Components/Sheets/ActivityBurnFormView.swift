//
//  ActivityBurnFormView.swift
//  MacroBook
//
//  Created by Hany Wijaya on 30/06/26.
//

import SwiftUI

struct ActivityBurnFormView: View {
    
    @Binding var title: String
    @Binding var date: Date
    @Binding var calories: String
    @Binding var note: String
    
    @FocusState private var titleFieldFocused: Bool
    
    var body: some View {
        TextField("Title", text: $title)
            .font(.custom("Poppins-SemiBold", size: 32))
            .multilineTextAlignment(.center)
            .focused($titleFieldFocused)
            .padding(.top, 32)
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
                    Text("Note")
                        .font(.custom("Poppins-Regular", size: 14))
                    Spacer()
                    TextField("Add a note", text: $note)
                        .font(.custom("Poppins-Regular", size: 14))
                        .multilineTextAlignment(.trailing)
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(.backgroundGray)
    }
}
