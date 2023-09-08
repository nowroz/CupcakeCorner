//
//  Order.swift
//  CupcakeCorner
//
//  Created by Nowroz Islam on 8/9/23.
//

import Foundation

@Observable final class Order: Codable {
    enum CodingKeys: CodingKey {
        case flavor, quantity, extraFrosting, addSprinkles, address
    }
    
    var flavor: Flavor = .vanilla
    var quantity: Int = 3
    
    var specialRequests: Bool = false {
        didSet {
            if specialRequests == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting: Bool = false
    var addSprinkles: Bool = false
    
    var address: Address = Address()
    
    init() { }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        flavor = try container.decode(Flavor.self, forKey: .flavor)
        quantity = try container.decode(Int.self, forKey: .quantity)
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        address = try container.decode(Address.self, forKey: .address)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(flavor, forKey: .flavor)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        try container.encode(address, forKey: .address)
    }
}

extension Order {
    var initialPrice: Double {
        Double(quantity) * 2
    }
    
    // $1.0 / cupcake for extra frosting
    var extraFrostingPrice: Double {
        if extraFrosting {
            Double(quantity) * 1
        } else {
            0.0
        }
    }
    
    // $0.50 / cupcake for adding sprinkles
    var sprinklesPrice: Double {
        if addSprinkles {
            Double(quantity) * 0.5
        } else {
            0.0
        }
    }
    
    var totalPrice: Double {
        initialPrice + flavor.additionalPrice + extraFrostingPrice + sprinklesPrice
    }
}
