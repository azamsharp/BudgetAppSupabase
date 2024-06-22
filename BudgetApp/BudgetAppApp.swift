//
//  BudgetAppApp.swift
//  BudgetApp
//
//  Created by Mohammad Azam on 6/20/24.
//

import SwiftUI
import Supabase

@main
struct BudgetAppApp: App {
    
    let client = SupabaseClient(supabaseURL: URL(string: "https://syrcnkscmomxhfmujsdl.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN5cmNua3NjbW9teGhmbXVqc2RsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTg5MDQ0MDIsImV4cCI6MjAzNDQ4MDQwMn0.olFc9IY2qcRP1su_674wi49nRUOS_MpPQtTBXb8fQOs")
    
    var body: some Scene {
        WindowGroup {
            BudgetListScreen()
        }
    }
}
