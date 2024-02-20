//
//  userHoldingModel.swift
//  UpstoxTestApp
//
//  Created by Harsh Raj on 19/02/24.
//

import Foundation

struct UserHolding: Codable {
    let symbol: String
    let quantity: Int
    let ltp: Double
    let avgPrice: Double
    let close: Double
    
    func getCurrentValue() -> Double {
        return self.ltp * Double(self.quantity)
    }
    
    func getInvestedValue() -> Double {
        return self.avgPrice * Double(self.quantity)
    }
    
    func getProfitLoss() -> Double {
        return getCurrentValue() - getInvestedValue()
    }
    
    func getTodaysProfit() -> Double {
        return (close - ltp) * Double(self.quantity)
    }
}

struct UserHoldingsResponse: Codable {
    let userHolding: [UserHolding]
}
