//
//  BudgetDetailScreen.swift
//  BudgetApp
//
//  Created by Mohammad Azam on 6/21/24.
//

import SwiftUI

struct BudgetDetailScreen: View {
    
    let budget: Budget
    
    @State private var name: String = ""
    @State private var limit: Double?
    
    @Environment(ExpenseTrackerStore.self) private var store
    
    private func updateBudget() async {
        
        guard let limit = limit,
              let id = budget.id
        else { return }
        
        
        let updatedValues = Budget(name: name, limit: limit)
        
        do {
            try await store.updateBudget(id: id, updatedValues: updatedValues)
        } catch {
            print(error)
        }
        
    }
    
    private var isFormValid: Bool {
        
        guard let limit = limit, limit > 0 else { return false }
        return !name.isEmptyOrWhiteSpace
    }
    
    var body: some View {
        Form {
            TextField("Enter name", text: $name)
            TextField("Enter limit", value: $limit, format: .number)
            Button("Update") {
                Task {
                    await updateBudget()
                }
            }.disabled(!isFormValid)
             
        }
        .onAppear(perform: {
            name = budget.name
            limit = budget.limit
        })
        .navigationTitle(budget.name)
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack {
        BudgetDetailScreen(budget: Budget(name: "Groceries", limit: 500))
    }
    .environment(\.supabaseClient, .development)
    .environment(ExpenseTrackerStore(supabaseClient: .development))
}
