//
//  CurrencyViewModel.swift
//  CurrenciesApp
//
//  Created by luca on 07/04/2020.
//  Copyright © 2020 luca. All rights reserved.
//

import Foundation

class CurrencyViewModel: ObservableObject {
    
    @Published var currenciesList = [CurrenciesList]()
    @Published var loading = false
    let table :String
    
    init(table: String){
        self.table = table
        self.parseResponse()
    }
    
    func parseResponse() {
        loading = true
        self.currenciesList = []
        guard let url = URL(string: "https://api.nbp.pl/api/exchangerates/tables/\(table)") else {return}
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {return}
            do{
            let currencies = try JSONDecoder().decode([CurrenciesList].self, from: data)
                DispatchQueue.main.async {
                    self.currenciesList = currencies
                    self.loading = false
                }}
            catch {
                print("Error during getting data")
            }
            }.resume()
        }
}
