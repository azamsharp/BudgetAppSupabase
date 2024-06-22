//
//  AddBudgetScreen.swift
//  BudgetApp
//
//  Created by Mohammad Azam on 6/21/24.
//

import SwiftUI

struct AddBudgetScreen: View {
    
    @State private var name: String = ""
    @State private var limit: Double?
    
    @Environment(\.dismiss) private var dismiss
    
    @Environment(ExpenseTrackerStore.self) private var store
    
    private func saveBudget() async {
        
        guard let limit = limit else { return }
        
        let budget = Budget(name: name, limit: limit)
        
        do {
            try await store.addBudget(budget)
            dismiss() 
        } catch {
            print(error)
        }
        
    }
    
    var body: some View {
        Form {
            TextField("Enter name", text: $name)
            TextField("Enter limit", value: $limit, format: .number)
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Close") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    Task {
                        await saveBudget()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddBudgetScreen()
    }.environment(ExpenseTrackerStore(supabaseClient: .development))
}
