//
//  AddActivityBurnView.swift
//  MacroBook
//
//  Created by Hany Wijaya on 06/06/26.
//

import SwiftUI

struct AddActivityBurnView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State var title: String = ""
    @State var date: Date = Date()
    @State var serving: String = "1"
    @State var note: String = ""
    
    @State var calories: String = ""
    @State var carbs: String = ""
    @State var protein: String = ""
    @State var fat: String = ""
    
    @FocusState private var titleFieldFocused: Bool
    
    @State private var showRecentLogs = false
    
    @ObservedObject var addActivityVM: AddActivityViewModel
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
                    
                    Button {
                        showRecentLogs = true
                    } label: {
                        Image(systemName: "list.bullet")
                            .font(.system(size: 18))
                            .foregroundStyle(.black)
                            .frame(width: 40, height: 40)
                            .background(Color.gray.opacity(0.15))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top, 20)
            
            ActivityBurnFormView(title: $title, date: $date, calories: $calories, note: $note)
            
            Button {
                addActivityVM.addActivityBurn(title: title, date: date, note: note, calories: calories)
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
        .fullScreenCover(isPresented: $showRecentLogs) {
            RecentLogsView(recentLogsVM: RecentLogsViewModel(context: viewContext), type: .activityBurn, title: $title, date: $date, serving: $serving, note: $note, calories: $calories, carbs: $carbs, protein: $protein, fat: $fat)
                .presentationDetents([.large])
        }
    }
}

#Preview {
    AddActivityBurnView(addActivityVM: AddActivityViewModel(context: PersistenceController.shared.container.viewContext), homeVM: HomeViewModel(context: PersistenceController.shared.container.viewContext))
}
