//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Nowroz Islam on 8/9/23.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Your name", text: $order.address.name)
                TextField("Street address", text: $order.address.street)
                TextField("City", text: $order.address.city)
                TextField("Zip code", text: $order.address.zip)
            }
            
            NavigationLink {
                CheckoutView(order: order)
            } label: {
                Text("Checkout")
                    .foregroundStyle(order.address.isValid ? .white : .secondary)
            }
            .disabled(order.address.isValid == false)
            .listRowBackground(order.address.isValid ? Color.cyan : nil)
            
        }
        .navigationTitle("Delivery Address")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        AddressView(order: Order())
    }
}
