//
//  SupabaseEnvironmentKey.swift
//  BudgetApp
//
//  Created by Mohammad Azam on 6/20/24.
//

import Foundation
import SwiftUI
import Supabase

struct SupabaseEnvironmentKey: EnvironmentKey {
    static var defaultValue: SupabaseClient = .development
}

extension EnvironmentValues {
    var supabaseClient: SupabaseClient {
        get { self[SupabaseEnvironmentKey.self] }
        set { self[SupabaseEnvironmentKey.self] = newValue }
      }
}
