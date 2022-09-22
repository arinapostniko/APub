//
//  PubManager.swift
//  APub
//
//  Created by Arina Postnikova on 11.09.22.
//

import Foundation

class PubManager {
    
    private init() { }
    static let shared = PubManager()
    
    var beers = [
        Beer(
            name: "Corona",
            country: "🇲🇽",
            remain: 100,
            price: 1.4
        ),
        Beer(
            name: "Heineken",
            country: "🇳🇱",
            remain: 89,
            price: 0.8
        ),
        Beer(
            name: "Budweiser",
            country: "🇺🇸",
            remain: 68,
            price: 1
        )
    ]
    
    var revenuePerDay = 0.0
    var soldBeer = 0.0
    
    func buyBeer(index: Int, volume: Double) -> Double {
        
        if (beers[index].remain < volume) { return 0 }
        
        beers[index].remain -= volume
        beers[index].remain = round(beers[index].remain)
        
        let price = volume * beers[index].price
        
        revenuePerDay += price
        revenuePerDay = round(revenuePerDay)
        
        soldBeer += volume
        soldBeer = round(soldBeer)
        
        return round(price)
        
    }
    
    func round(_ num: Double) -> Double {
        var result = num * 100
        result += 0.5
        return Double(Int(result)) / 100
    }
    
}
