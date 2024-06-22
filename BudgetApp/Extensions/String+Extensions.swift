//
//  String+Extensions.swift
//  BudgetApp
//
//  Created by Mohammad Azam on 6/21/24.
//

import Foundation

extension String {
    
    var isEmptyOrWhiteSpace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty 
    }
    
}
