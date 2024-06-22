//
//  Budget.swift
//  BudgetApp
//
//  Created by Mohammad Azam on 6/20/24.
//

import Foundation

struct Budget: Codable, Identifiable {
    var id: Int?
    let name: String
    let limit: Double 
}
