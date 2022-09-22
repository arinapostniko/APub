//
//  ViewController.swift
//  APub
//
//  Created by Arina Postnikova on 10.09.22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var revenuePerDay: UILabel!
    
    @IBOutlet weak var soldBeer: UILabel!
    
    @IBOutlet var beerNames: [UILabel]!
    
    @IBOutlet var beerCountries: [UILabel]!
    
    @IBOutlet var remains: [UILabel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for index in 0..<PubManager.shared.beers.count {
            beerNames[index].text = PubManager.shared.beers[index].name
            beerCountries[index].text = PubManager.shared.beers[index].country
            updateRemains(for: index)
            updateRevenuePerDay()
            updateSoldBeer()
        }
        
        // Do any additional setup after loading the view.
    }

    func updateRemains(for index: Int) {
        let volume = PubManager.shared.beers[index].remain
        remains[index].text = "Left:\n\(volume) L"
    }
    
    func updateRevenuePerDay() {
        let newRevenuePerDay = PubManager.shared.revenuePerDay
        
        revenuePerDay.text = "Revenue per day: \(newRevenuePerDay)$"
    }
    
    func updateSoldBeer() {
        let totalSold = PubManager.shared.soldBeer
        
        soldBeer.text = "Sold beer: \(totalSold) L"
    }
    
    @IBAction func buyBeer(_ sender: UIButton) {
        let tag = sender.tag
        let volume: Double
        let beerIndex = tag / 10
        
        switch tag % 10 {
        case 0:
            volume = 0.33
        case 1:
            volume = 0.5
        case 2:
            volume = 1.0
        default:
            volume = 0
        }
        
        let price = PubManager.shared.buyBeer(index: beerIndex, volume: volume)
        print(price)
        
        showAlert(withPrice: price)
        
        updateRemains(for: beerIndex)
        updateRevenuePerDay()
        updateSoldBeer()
        
    }
    
    func showAlert(withPrice price: Double) {
        if price < 0.01 {
            showAlert(withTitle: "Bad purchase", message: "Not enough beer")
        } else {
            showAlert(withTitle: "Purchase completed successfully", message: "Purchase price: \(price)$")
        }
    }
    
    func showAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
    func showNewShiftAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
    @IBAction func newShift(_ sender: UIButton) {
        showNewShiftAlert(withTitle: "You started a new shift!", message: "Earned last shift: \(PubManager.shared.revenuePerDay)$\nSold last shift: \(PubManager.shared.soldBeer) L")
        print("New Shift!")
        
        PubManager.shared.revenuePerDay = 0.0
        PubManager.shared.soldBeer = 0.0
        
        updateRevenuePerDay()
        updateSoldBeer()
    }
    
}

