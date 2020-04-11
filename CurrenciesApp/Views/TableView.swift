//
//  TableView.swift
//  CurrenciesApp
//
//  Created by luca on 09/04/2020.
//  Copyright © 2020 luca. All rights reserved.
//

import SwiftUI

struct TableView: View {
    
    @ObservedObject var currencyViewModel: CurrencyViewModel
    
    var body: some View {
        ZStack{
            List{ ForEach(self.currencyViewModel.currenciesList,id:\.table) { record in
                    ForEach(record.rates,id:\.code) {rates in
                        NavigationLink(destination: DetailView(detailViewModel: DetailViewModel(code: rates.code, table: record.table, date: record.effectiveDate,title: rates.currency))) {
                        VStack(alignment: .leading, spacing: 5) {
                        Text("Date: ") + Text(record.effectiveDate)
                        Text("Name: ") + Text(rates.currency)
                        Text("Code: ") + Text(rates.code)
                        Text("Mid : ") + Text(String(rates.mid ?? self.avg(rates.ask!,rates.bid!)))
                        }
                    }
                }}
            }
            .listStyle(GroupedListStyle())
            .disabled(currencyViewModel.loading)
            ActivityView(show: $currencyViewModel.loading)
        }
    }
    func refresh() {
        self.currencyViewModel.parseResponse()
    }
    
    func avg(_ x: Float, _ y: Float) -> Float {
        return (x+y)/2.0
    }
}


