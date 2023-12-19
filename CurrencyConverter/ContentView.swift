//
//  ContentView.swift
//  CurrencyConverter
//
//  Created by Влад on 12/19/23.
//

import SwiftUI

struct ContentView: View {
    @State private var itemSelected1 = 0
    @State private var itemSelected2 = 1
    @State private var amount : String = ""
    private let currencies = ["USD", "EUR", "GBP"]
    
    func convert(_ convert : String) -> String {
        var conversion : Double = 1.0
        let amount = Double(convert.doubleValue) 
        let FirstSelectedCurrency = currencies[itemSelected1]
        let SecondSelectedCurrency = currencies[itemSelected2]
        
        let euroRates = ["USD" : 1.10, "EUR" : 1.0, "GBP" : 0.84]
        let usdRates = ["USD" : 1.0, "EUR" : 0.87, "GBP" : 0.73]
        let gbpRates = ["USD" : 1.37, "EUR" : 1.18, "GBP" : 1.0]

        switch FirstSelectedCurrency {
        case "USD":
            conversion = amount * (usdRates[SecondSelectedCurrency] ?? 0.0)
        case "EUR":
            conversion = amount * (euroRates[SecondSelectedCurrency] ?? 0.0)
        case "GBP":
            conversion = amount * (gbpRates[SecondSelectedCurrency] ?? 0.0)
        default:
            conversion = 0.0
        }
        return String(format: "%.2f", conversion)
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("Convert a currency")) {
                    TextField("Enter an amount", text: $amount)
                        .keyboardType(.decimalPad)
                    
                    Picker(selection: $itemSelected1, label: Text("From")){
                        ForEach(0..<currencies.count){ currency in
                            Text(self.currencies[currency]).tag(currency)
                        }
                    }
                    Picker(selection: $itemSelected2, label: Text("To")){
                        ForEach(0..<currencies.count){ currency in
                            Text(self.currencies[currency]).tag(currency)
                        }
                    }
                }
                Section(header: Text("Conversion")){
                    Text("\(convert(amount)) \(currencies[itemSelected2])")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
