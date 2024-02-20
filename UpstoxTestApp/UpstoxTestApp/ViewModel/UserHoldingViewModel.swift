//
//  UserHoldingViewModel.swift
//  UpstoxTestApp
//
//  Created by Harsh Raj on 19/02/24.
//

import Foundation

class HoldingViewModel {
    
    var totalCurrentValue = 0.0
    var totalInvestedValue = 0.0
    
    var totalProfitAndLoss: Double {
        Double(round((totalCurrentValue - totalInvestedValue) * 100) / 100)
    }
    
    
    func fetchDataFromApi(completion: @escaping (UserHoldingsResponse) -> Void) {         
        let urlString = "https://run.mocky.io/v3/bde7230e-bc91-43bc-901d-c79d008bddc8"
           
           if let url = URL(string: urlString) {
               NetworkLayer.fetchData(from: url) { result in
                   switch result {
                   case .success(let userHoldingsResponse):
                       completion(userHoldingsResponse)
                   case .failure(let error):
                       print(error)
                   }
               }
           } else {
               return
           }
       }
    
    func getTotalCurrentValue(_ userHolding: [UserHolding]) -> Double {
        totalCurrentValue = userHolding.compactMap{$0.getCurrentValue()}.reduce(0, +)
        return totalCurrentValue
    }
    
    func getTotalInvestment(_ userHolding: [UserHolding]) -> Double {
        totalInvestedValue = userHolding.compactMap{$0.getInvestedValue()}.reduce(0, +)
        return totalInvestedValue
    }
    
    func getTodayProfitAndLoss(_ userHolding: [UserHolding]) -> Double {
        return Double(round(userHolding.compactMap{$0.getTodaysProfit()}.reduce(0, +)*100)/100)
    }
       
}

