//
//  ContentView.swift
//  CurrenciesApp
//
//  Created by luca on 07/04/2020.
//  Copyright © 2020 luca. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var activeView = 0
    var tableView  = [TableView(currencyViewModel: CurrencyViewModel(table: "A")),
        TableView(currencyViewModel: CurrencyViewModel(table: "B")),
        TableView(currencyViewModel: CurrencyViewModel(table: "C"))]
    
    var body: some View {
        NavigationView{
            TabView(selection: $activeView){
                self.tableView[0]
                    .tabItem({
                        Image(systemName: "a.circle")
                        Text("Table A")
                }).tag(0)
                    .font(Font.system(size: 20, design: .monospaced))
                
                self.tableView[1]
                    .tabItem({
                        Image(systemName: "b.circle")
                        Text("Table B")
                }).tag(1)
                
                self.tableView[2]
                    .tabItem({
                        Image(systemName: "c.circle")
                        Text("Table C")
                }).tag(2)
            }
            .navigationBarTitle("Currencies")
            .navigationBarItems(trailing: Button("Refresh") {
            self.tableView[self.activeView].refresh()
            })
        }
        .font(Font.system(size: 20, design: .monospaced))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
