//
//  Food.swift
//  FoodOrderingSystem
//
//  Created by YIP ZI XIAN on 11/01/2023.
//

import Foundation

struct Food: Identifiable {
    let title: String
    let price: Double
    let category: Categories
    let id = UUID()
}
