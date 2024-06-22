//
//  ExpenseTrackerStore.swift
//  BudgetApp
//
//  Created by Mohammad Azam on 6/22/24.
//

import Foundation
import Observation
import Supabase

@Observable
class ExpenseTrackerStore {
    
    var supabaseClient: SupabaseClient
    var budgets: [Budget] = []
    // var expenses: [Expense] = []
    
    init(supabaseClient: SupabaseClient) {
        self.supabaseClient = supabaseClient
    }
    
    func loadBudgets() async throws {
        
        budgets = try await supabaseClient
            .from("budgets")
            .select()
            .execute()
            .value
    }
    
    func deleteBudget(_ budget: Budget) async throws {
        
        guard let id = budget.id else { return }
        
        try await supabaseClient
            .from("budgets")
            .delete()
            .eq("id", value: id)
            .execute()
        
        // remove budget from budgets array
        budgets = budgets.filter { $0.id! != id }
    }
    
    func addBudget(_ budget: Budget) async throws {
        
        let newBudget: Budget = try await supabaseClient
            .from("budgets")
            .insert(budget)
            .select()
            .single()
            .execute()
            .value
        
        budgets.append(newBudget)
    }
    
    func updateBudget(id: Int, updatedValues: Budget) async throws {
        
        let updatedBudget: Budget = try await supabaseClient
            .from("budgets")
            .update(updatedValues)
            .eq("id", value: id)
            .select()
            .single()
            .execute()
            .value
        
        let index = budgets.firstIndex { $0.id == id }
        
        if let index {
            budgets[index] = updatedBudget
        }
         
    }
}
