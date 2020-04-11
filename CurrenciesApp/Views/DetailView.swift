//
//  DetailView.swift
//  CurrenciesApp
//
//  Created by luca on 08/04/2020.
//  Copyright © 2020 luca. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    @ObservedObject var detailViewModel :DetailViewModel
    @State var fromDate = Date()
    @State var toDate = Date()
    @State var error = false
    
    var body: some View {
        
        ZStack{
            Form {
                Section(header: Text("Select date range")) {
                    DatePicker("From:",selection: $fromDate,
                               in: Date(timeIntervalSinceReferenceDate: 31708800)...toDate, displayedComponents: .date)
                    DatePicker("To:",selection: $toDate,
                               in: fromDate...Date(), displayedComponents: .date)
                    Button("Show") {
                        self.detailViewModel.show(fromDate: self.fromDate, toDate: self.toDate, error: &self.error)}
                        .accentColor(Color.black)
                }
                Section(header: Text(self.detailViewModel.code)) {
                    List(self.detailViewModel.detailList){ record in
                        VStack(alignment: .leading, spacing: 5) {
                        Text("Date: ") + Text(record.effectiveDate)
                        Text("Avg : ") + Text(String(record.mid ?? (record.ask!+record.bid!)/2.0))
                        }
                    }
                }
            }.disabled(detailViewModel.loading)
            ActivityView(show: $detailViewModel.loading)
                
            .listStyle(GroupedListStyle())
            .navigationBarTitle(self.detailViewModel.title.capitalized)
            .navigationBarItems(trailing: Button("Refresh") {
                self.detailViewModel.show(fromDate: self.fromDate, toDate: self.toDate, error: &self.error)
                })
            .onAppear(){
                self.detailViewModel.parseResponse()
            }
            .onDisappear(){
                self.detailViewModel.detailList = []
            }
        }
        .alert(isPresented: $error){
            switch detailViewModel.activeError {
            case .dataError:
                return Alert(title: Text("No data for the chosen date range"))
            case .rangeError:
                return Alert(title: Text("Cannot show data for range greater than a year. Please select smaller date range"))}
        }
    }
    
}

