//
//  ContentView.swift
//  BudgetApp
//
//  Created by Mohammad Azam on 6/20/24.
//

import SwiftUI

struct BudgetListScreen: View {
    
    @Environment(ExpenseTrackerStore.self) private var store
    
    @State private var isPresented: Bool = false
   
    var body: some View {
        List {
            ForEach(store.budgets) { budget in
                NavigationLink {
                    BudgetDetailScreen(budget: budget)
                        .navigationTitle(budget.name)
                } label: {
                    BudgetCellView(budget: budget)
                }
            }.onDelete(perform: { indexSet in
                guard let index = indexSet.last else { return }
                let budget = store.budgets[index]
                Task { // this can be moved into a deleteBudget function in the View
                    do {
                        try await store.deleteBudget(budget)
                    } catch {
                        print(error)
                    }
                }
            })
        }.task {
            do { // this can be moved into fetchBudgets function in the View
                try await store.loadBudgets()
            } catch {
                print(error)
            }
        }
        .navigationTitle("Budgets")
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add New") {
                    isPresented = true
                }
            }
        })
        .sheet(isPresented: $isPresented, content: {
            NavigationStack {
                AddBudgetScreen()
            }
        })
    }
}

#Preview {
    NavigationStack {
        BudgetListScreen()
    }
    .environment(\.supabaseClient, .development)
    .environment(ExpenseTrackerStore(supabaseClient: .development))
}

struct BudgetCellView: View {
    
    let budget: Budget
    
    var body: some View {
        HStack {
            Text(budget.name)
            Spacer()
            Text(budget.limit, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
        }
    }
}
