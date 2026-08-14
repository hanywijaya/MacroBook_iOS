//
//  EditActivityBurnView.swift
//  MacroBook
//
//  Created by Hany Wijaya on 17/07/26.
//

import SwiftUI

struct EditActivityBurnView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var log: Log
    
    @State var title: String = ""
    @State var date: Date = Date()
//    @State var serving: String = "1"
    @State var note: String = ""
    
    @State var calories: String = ""
//    @State var carbs: String = ""
//    @State var protein: String = ""
//    @State var fat: String = ""
    
    @FocusState private var titleFieldFocused: Bool
    
    @ObservedObject var logDetailVM: LogDetailViewModel
    @ObservedObject var homeVM: HomeViewModel
    
    private var isFormValid: Bool {
        !title.isEmpty &&
        !calories.isEmpty
    }
    
    var body: some View {
        VStack {
            ZStack {
                Text("Activity Burn")
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
            
            ActivityBurnFormView(title: $title, date: $date, calories: $calories, note: $note)
            
            Button {
                let newLog = Log(id: log.id, type: log.type, timestamp: date, title: title, note: note, calories: Double(calories) ?? 0, protein: 0, carbs: 0, fat: 0, serving: 1)
                log = newLog
                logDetailVM.editLog(log: newLog)
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
        }
        .background(.backgroundGray)
    }
}

#Preview {
    EditActivityBurnView(log: .constant(Log(id: nil, type: .intake, timestamp: Calendar.current.date(from: DateComponents(year: 2026, month: 6, day: 27, hour: 8, minute: 30))!, title: "Milk", note: "200ml", calories: 60, protein: 6, carbs: 9, fat: 0, serving: 1)), logDetailVM: LogDetailViewModel(context: PersistenceController.shared.container.viewContext), homeVM: HomeViewModel(context: PersistenceController.shared.container.viewContext))
}

