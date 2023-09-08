//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Nowroz Islam on 8/9/23.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    
    let imageURL: String = "https://hws.dev/img/cupcakes@3x.jpg"
    let currencyCode: String = Locale.current.currency?.identifier ?? "USD"
    
    @State private var confirmationTitle: String = ""
    @State private var confirmationMessage: String = ""
    @State private var showingConfirmation: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: imageURL), scale: 3) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                    } else if phase.error != nil {
                        Text("There was an error loading the image from the internet.")
                    } else {
                        ProgressView()
                    }
                }
                .frame(height: 233)
                .frame(maxWidth: .infinity)
                
                Divider()
                
                Text("Order Details")
                    .font(.title.weight(.semibold))
                    .padding()
                
                VStack(alignment: .leading) {
                    LabeledContent {
                        Text(order.initialPrice, format: .currency(code: currencyCode))
                    } label: {
                        Text("• \(order.flavor.rawValue) cupcakes x \(order.quantity)")
                    }
                    
                    LabeledContent {
                        Text(order.flavor.additionalPrice, format: .currency(code: currencyCode))
                    } label: {
                        Text("""
                             • Additional price for
                               special cupcakes
                             """)
                    }
                    
                    LabeledContent {
                        Text(order.extraFrostingPrice, format: .currency(code: currencyCode))
                    } label: {
                        Text("• Extra frosting x \(order.quantity)")
                    }
                    
                    LabeledContent {
                        Text(order.sprinklesPrice, format: .currency(code: currencyCode))
                    } label: {
                        Text("• Add sprinkles x \(order.quantity)")
                    }
                    
                    Divider()
                    
                    LabeledContent {
                        Text(order.totalPrice, format: .currency(code: currencyCode))
                            .font(.headline)
                    } label: {
                        Text("Total Price")
                            .font(.headline)
                    }
                }
                .padding(.horizontal)
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.cyan)
                .frame(maxWidth: .infinity)
                .padding()
            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .alert(confirmationTitle, isPresented: $showingConfirmation) {
            
        } message: {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async {
        guard let url = URL(string: "https://reqres.in/api/cupcakes") else {
            fatalError("Invalid URL")
        }
        
        guard let data = try? JSONEncoder().encode(order) else {
            fatalError("Failed to encode the Order type.")
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (receivedData, _) = try await URLSession.shared.upload(for: request, from: data)
            
            guard let decodedOrder = try? JSONDecoder().decode(Order.self, from: receivedData) else {
                fatalError("Failed to decode the Order type.")
            }
            
            confirmationTitle = "Thank You!"
            confirmationMessage = "Your order of \(decodedOrder.quantity) \(decodedOrder.flavor.rawValue.lowercased()) cupcakes is on the way."
            showingConfirmation = true
        } catch {
            confirmationTitle = "Oops!"
            confirmationMessage = "Network error. Please try again later."
            showingConfirmation = true
        }
    }
}

#Preview {
    NavigationStack {
        CheckoutView(order: Order())
    }
}
