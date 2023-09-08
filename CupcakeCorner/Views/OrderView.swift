//
//  OrderView.swift
//  CupcakeCorner
//
//  Created by Nowroz Islam on 8/9/23.
//

import SwiftUI

struct OrderView: View {
    @Bindable var order: Order = Order()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select flavor", selection: $order.flavor) {
                        ForEach(Flavor.allCases) { flavor in
                            Text(flavor.rawValue)
                        }
                    }
                    
                    Stepper("Number of cupcakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Special requests", isOn: $order.specialRequests.animation())
                    
                    if order.specialRequests {
                        Toggle("Extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add sprinkles", isOn: $order.addSprinkles)
                    }
                }
                
                NavigationLink {
                    AddressView(order: order)
                } label: {
                    Text("Delivery address")
                        .foregroundStyle(.white)
                }
                .listRowBackground(Color.cyan)
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

#Preview {
    OrderView()
}
