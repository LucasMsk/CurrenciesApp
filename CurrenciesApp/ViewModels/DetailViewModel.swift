//
//  DetailViewModel.swift
//  CurrenciesApp
//
//  Created by luca on 09/04/2020.
//  Copyright © 2020 luca. All rights reserved.
//

import Foundation

enum ActiveError {
    case dataError, rangeError
}

class DetailViewModel: ObservableObject {
    
    @Published var detailList = [Detail]()
    @Published var loading = false
    @Published var activeError: ActiveError = .dataError
    let code, table, date, title :String
    let dateService = DateService()
    
    init(code: String, table: String, date: String,title: String){
        self.code = code
        self.table = table
        self.date = date
        self.title = title
    }
    
    func parseResponse(fromDate: String? = nil, toDate: String? = nil) {
        
        loading = true
        self.detailList = []
        guard let url = URL(string: "https://api.nbp.pl/api/exchangerates/rates/\(table)/\(code)/\(fromDate ?? date)/\(toDate ?? date)") else {return}
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {return}
            do{
            let details = try JSONDecoder().decode(DetailList.self, from: data)
                DispatchQueue.main.async {
                    self.loading = false
                    self.detailList = details.rates
                }}
            catch {
                print("Error during getting data")
            }
            }.resume()
        }
    
    func show(fromDate: Date, toDate: Date, error: inout Bool) {
        if(fromDate.distance(to: toDate)<31708800) {
            let lastDate = self.dateService.strToDate(self.date)
            if(lastDate>fromDate || Calendar.current.isDate(lastDate, equalTo: fromDate, toGranularity: .day)) {
                parseResponse(fromDate: self.dateService.dateToStr(fromDate), toDate: self.dateService.dateToStr(toDate))
            }
            else {
                self.activeError = .dataError
                error = true
            }
        }
        else {
            self.activeError = .rangeError
            error = true
        }
    }
}
