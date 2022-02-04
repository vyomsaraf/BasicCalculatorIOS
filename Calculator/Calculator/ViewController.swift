//
//  ViewController.swift
//  Calculator
//
//  Created by Ontic on 02/02/22.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    var displayText : String?
    var tempString : String = ""
    var decimalCount = 0
    var tempCount = 0.0
    var temp = 0.0
    var temp1 = 0.0
    var numberArray : [Double] = [0]
    var functionArray : [String] = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var calculatrDisplay: UILabel!
    @IBOutlet weak var allClearButton: UIButton!
    @IBAction func percentageFunction(_ sender: UIButton) {
        functionBeingEntered(function: "%")
    }
    @IBAction func divideFunction(_ sender: UIButton) {
        functionBeingEntered(function: "/")
    }
    @IBAction func sevenInsertAction(_ sender: UIButton) {
        numberBeingEntered(digit: 7)
    }
    @IBAction func eightInsertAction(_ sender: UIButton) {
        numberBeingEntered(digit: 8)
    }
    @IBAction func nineInsertAction(_ sender: UIButton) {
        numberBeingEntered(digit: 9)
    }
    @IBAction func multiplyFunction(_ sender: UIButton) {
        functionBeingEntered(function: "X")
    }
    @IBAction func fourInsertAction(_ sender: UIButton) {
        numberBeingEntered(digit: 4)
    }
    @IBAction func fiveInsertAction(_ sender: UIButton) {
        numberBeingEntered(digit: 5)
    }
    @IBAction func sixInsertAction(_ sender: UIButton) {
        numberBeingEntered(digit: 6)
    }
    @IBAction func subtractFunction(_ sender: UIButton) {
        functionBeingEntered(function: "-")
    }
    @IBAction func oneInsertAction(_ sender: UIButton) {
        numberBeingEntered(digit: 1)
    }
    @IBAction func twoInsertAction(_ sender: UIButton) {
        numberBeingEntered(digit: 2)
    }
    @IBAction func threeInsertAction(_ sender: UIButton) {
        numberBeingEntered(digit: 3)
    }
    @IBAction func additionFunction(_ sender: UIButton) {
        functionBeingEntered(function: "+")
    }
    @IBAction func zeroInsertAction(_ sender: UIButton) {
        numberBeingEntered(digit: 0)
    }
    @IBAction func allClearAction(_ sender: UIButton) {
        allClearFunction()
    }
    @IBAction func backspaceAction(_ sender: UIButton) {
        backspaceFunction()
    }
    
    @IBAction func decimalInsertFunction(_ sender: UIButton) {
        decimalInsertionFunction()
    }
    @IBAction func computeFunction(_ sender: UIButton) {
        computeExpression()
    }
    
    func numberBeingEntered(digit :Int){
        if calculatrDisplay.text != "0"{
            displayText = calculatrDisplay.text
            displayText?.append("\(digit)")
            calculatrDisplay.text = displayText
        }
        else{
            calculatrDisplay.text = "\(digit)"
        }
        if decimalCount == 0{
            var tempString = String(Int(tempCount))
            tempString.append(String(digit))
            tempCount = Double(tempString)!
        }
        else{
            var tempString = String(tempCount)
            tempString.append(String(digit))
            tempCount = Double(tempString)!
        }
    }
    
    func functionBeingEntered(function :String){
        if calculatrDisplay.text != "0"{
            if tempCount != Double(0){
                numberArray.append(tempCount)
                tempCount = 0
                displayText = calculatrDisplay.text
                displayText?.append(function)
                calculatrDisplay.text = displayText
                functionArray.append(function)
                decimalCount = 0
            }
        }
    }
    
    func allClearFunction(){
        calculatrDisplay.text = "0"
        decimalCount = 0
        tempCount = 0.0
        numberArray.removeAll()
        functionArray.removeAll()
    }
    
    func backspaceFunction(){
        displayText = calculatrDisplay.text
        if(displayText != "0"){
            if displayText?.last! != "%" && displayText?.last! != "+" && displayText?.last! != "-" && displayText?.last! != "/" && displayText?.last! != "X"{
                if decimalCount == 0{
                    tempString = String(Int(tempCount))
                    if tempString.count > 1{
                        tempString.removeLast()
                        tempCount = Double(tempString)!
                    }
                    else{
                        tempCount = 0.0
                    }
                    displayText?.removeLast()
                    calculatrDisplay.text = displayText
                }
                else{
                    if displayText?.last! == "."{
                        decimalCount = 0
                        displayText?.removeLast()
                        calculatrDisplay.text = displayText
                    }
                    else{
                        tempString = String(tempCount)
                        tempString.removeLast()
                        tempCount = Double(tempString)!
                        displayText?.removeLast()
                        calculatrDisplay.text = displayText
                    }
                }
            }
            else
            {
                if !functionArray.isEmpty{
                    displayText?.removeLast()
                    calculatrDisplay.text = displayText
                    functionArray.removeLast()
                    if !numberArray.isEmpty{
                        tempCount = numberArray[numberArray.endIndex - 1]
                        numberArray.removeLast()
                    }
                    else{
                        tempCount = 0.0
                    }
                }
                else{
                    let alert = UIAlertController(title: "Error", message: "Nothing left to clear", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    func decimalInsertionFunction(){
        if decimalCount == 0{
            decimalCount = 1
            if calculatrDisplay.text?.last! != "%" && calculatrDisplay.text?.last! != "+" && calculatrDisplay.text?.last! != "-" && calculatrDisplay.text?.last! != "X" &&
                calculatrDisplay.text?.last! != "/"{
                displayText = calculatrDisplay.text
                displayText?.append(".")
                calculatrDisplay.text = displayText
            }
            else{
                displayText = calculatrDisplay.text
                displayText?.append("0.")
                calculatrDisplay.text = displayText
            }
        }
    }
    
    func functionRecursionDivideMultiply(numberArray : [Double],functionArray : [String]){
        var counter = 0
        for (index,element) in functionArray.enumerated(){
            if element == "/"{
                if self.numberArray.count >= index + 1{
                    temp = numberArray[index]
                    temp1 = numberArray[index + 1]
                    self.numberArray.remove(at: (index+1))
                    temp = Double(Double(temp) / Double(temp1))
                    self.numberArray[index] = temp
                    self.functionArray.remove(at: index)
                    counter = 1
                }
                break
            }
            if element == "X"{
                if self.numberArray.count >= index + 1{
                    temp = numberArray[index]
                    temp1 = numberArray[index + 1]
                    self.numberArray.remove(at: (index+1))
                    temp = Double(Double(temp) * Double(temp1))
                    self.numberArray[index] = temp
                    self.functionArray.remove(at: index)
                    counter = 1
                }
                break
            }
        }
        if counter == 1{
            functionRecursionDivideMultiply(numberArray: self.numberArray, functionArray: self.functionArray)
        }
    }
    
    func functionRecursionAdditionSubtraction(numberArray : [Double],functionArray : [String]){
        var counter = 0
        for (index,element) in functionArray.enumerated(){
            if element == "+"{
                if self.numberArray.count >= index + 1{
                    temp = numberArray[index]
                    temp1 = numberArray[index + 1]
                    self.numberArray.remove(at: (index+1))
                    temp = Double(Double(temp) + Double(temp1))
                    self.numberArray[index] = temp
                    self.functionArray.remove(at: index)
                    counter = 1
                }
                break
            }
            if element == "-"{
                if self.numberArray.count >= index + 1{
                    temp = numberArray[index]
                    temp1 = numberArray[index + 1]
                    self.numberArray.remove(at: (index+1))
                    temp = Double(Double(temp) - Double(temp1))
                    self.numberArray[index] = temp
                    self.functionArray.remove(at: index)
                    counter = 1
                }
                break
            }
        }
        if counter == 1{
            functionRecursionAdditionSubtraction(numberArray: self.numberArray, functionArray: self.functionArray)
        }
    }
    
    func functionRecursionPercentage(numberArray: [Double], functionArray : [String]){
        var counter = 0
        for (index,element) in functionArray.enumerated(){
            if element == "%"{
                if self.numberArray.count >= index + 1{
                    temp = numberArray[index]
                    temp1 = numberArray[index + 1]
                    self.numberArray.remove(at: (index+1))
                    temp = Double(Double(temp) * Double(temp1))
                    temp = Double(Double(temp) / Double(100))
                    self.numberArray[index] = temp
                    self.functionArray.remove(at: index)
                    counter = 1
                }
                break
            }
        }
        if counter == 1{
            functionRecursionPercentage(numberArray: self.numberArray, functionArray: self.functionArray)
        }
    }
    
    func computeExpression(){
        numberArray.append(tempCount)
        if !numberArray.isEmpty{
            if numberArray[0] == Double(0){
                numberArray.remove(at: 0)
            }
        }
        if !functionArray.isEmpty{
            if functionArray[0] == ""{
                functionArray.remove(at: 0)
            }
        }
        functionRecursionDivideMultiply(numberArray: numberArray, functionArray: functionArray)
        
        functionRecursionAdditionSubtraction(numberArray: numberArray, functionArray: functionArray)
        
        functionRecursionPercentage(numberArray: numberArray, functionArray: functionArray)
        
        if Double(Int(numberArray[0])) == numberArray[0] {
            displayText = String(Int(numberArray[0]))
            calculatrDisplay.text = displayText
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                let alert = UIAlertController(title: "Result", message: "Your final computation result is \(self.numberArray[0])", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alert, animated: true)
                self.allClearFunction()
            }
        }
        else{
            displayText = String(numberArray[0])
            calculatrDisplay.text = displayText
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                let alert = UIAlertController(title: "Result", message: "Your final computation result is \(self.numberArray[0])", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                self.present(alert, animated: true)
                self.allClearFunction()
            }
        }
    }
}
