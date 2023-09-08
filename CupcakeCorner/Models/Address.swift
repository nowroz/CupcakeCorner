//
//  Address.swift
//  CupcakeCorner
//
//  Created by Nowroz Islam on 8/9/23.
//

import Foundation

@Observable final class Address: Codable {
    enum CodingKeys: CodingKey {
        case name, street, city, zip
    }
    
    var name: String = ""
    var street: String = ""
    var city: String = ""
    var zip: String = ""
    
    init() { }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        street = try container.decode(String.self, forKey: .street)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(street, forKey: .street)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }
}

extension Address {
    var isValid: Bool {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedStreet = street.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedCity = city.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedZip = zip.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedName.isEmpty || trimmedStreet.isEmpty || trimmedCity.isEmpty || trimmedZip.isEmpty {
            return false
        } else {
            return true
        }
    }
}
