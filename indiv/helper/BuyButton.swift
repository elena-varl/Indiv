//
//  BuyButton.swift
//  indiv
//
//  Created by AIR on 05.01.2024.
//

import SwiftUI

    struct BuyButton: View {
        let urlString: String
        let price: Double?
        let currency: String
        var body: some View {
            if let url = URL (string: urlString),
                let priceText = formattedPrice() {
                Link(destination: url)
                {
                    Text(priceText)
                }
                .buttonStyle(BuyButtonStyle())
            }
            
        }
        func formattedPrice() -> String? {
            
            guard let price = price else {
                return nil
            }
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencyCode = currency
            let priceString = formatter.string(from: NSNumber(value: price))
            return priceString ?? ""
        }
    }



struct BuyButton_Previews: PreviewProvider {
    static var previews: some View {
        let example = Album.example()
        return BuyButton(urlString: example.collectionViewURL, price: example.collectionPrice, currency: example.currency)
        
    }
}
