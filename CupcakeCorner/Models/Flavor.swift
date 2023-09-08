//
//  Flavor.swift
//  CupcakeCorner
//
//  Created by Nowroz Islam on 8/9/23.
//

import Foundation

enum Flavor: String, CaseIterable, Identifiable, Codable {
    case vanilla = "Vanilla"
    case strawberry = "Strawberry"
    case chocolate = "Chocolate"
    case rainbow = "Rainbow"
    
    var id: Self {
        self
    }
}

extension Flavor {
    var additionalPrice: Double {
        switch self {
        case .vanilla:
            return 0
        case .strawberry:
            return 0.5
        case .chocolate:
            return 1.0
        case .rainbow:
            return 1.5
        }
    }
}
