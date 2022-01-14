//
//  ViewController.swift
//  TipCalculator
//
//  Created by Gabriel Eduardo on 1/13/22.
//  Copyright © 2022 Gabriel Eduardo. All rights reserved.
//

import UIKit

extension UITextField {
    var floatValue: Float?{
        let formatNumber = NumberFormatter.init()
        formatNumber.numberStyle = .decimal
        let newNumber = formatNumber.number(from: text!)?.floatValue
        return newNumber
    }
    
    var percentValue: Float?{
        get {
            let formatNumber = NumberFormatter.init()
            formatNumber.numberStyle = .decimal
            if let newNumber = formatNumber.number(from: text!)?.floatValue {
                return newNumber / 10
            } else {
                return nil
            }
        }
        set (newValue) {
            var value: Float?
            if let percent = newValue {
                value = percent * 1
            }
            self.text = value == nil ? nil : String.init(format: "%.0f", value!)
        }
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var amountBill: UITextField!
    @IBOutlet weak var calculateTip: UIButton!
    @IBOutlet weak var tipPercentageTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var adjustTipPercentage: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tipPercentageTextField.percentValue = adjustTipPercentage.value
        calculateTip.layer.cornerRadius = 10
    }
    
    @IBAction func amountBillFilled(_ sender: UITextField) {
        tipActionCalculate()
    }
    
    @IBAction func tipPercentageTextFieldFilled(_ sender: UITextField) {
        adjustTipPercentage.value = sender.floatValue! / 100
        tipActionCalculate()
    }
    
    @IBAction func adjustTipPercentage(_ sender: UISlider) {
        let tipValue = sender.value
        print(tipValue)
        tipPercentageTextField.percentValue = tipValue
        tipActionCalculate()
    }
    
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        tipActionCalculate()
    }
    
    
    
    func tipActionCalculate(){
        if let billAmount = amountBill.floatValue {
            tipAmountLabel.text = String.init(format: "$ %.2f", (billAmount * adjustTipPercentage.value) / 100)
        } else {
            tipAmountLabel.text = "Please enter a value below"
        }
    }
    
    public func calculatePercentage(value:Float,percentageVal:Float)->Float{
        let val = amountBill.floatValue! * adjustTipPercentage.value
        return val / 100.0
    }
    
    
}
