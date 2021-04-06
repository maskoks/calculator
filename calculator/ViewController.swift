//
//  ViewController.swift
//  calculator
//
//  Created by Жеребцов Данил on 15.03.2021.
//

import UIKit

class CalculatorApp {
    var numOne: Double? = nil
    var numTwo: Double? = nil
    var action: Actions? = nil
    var isActionChoosen: Bool = false
    var isDotActive: Bool = false
    var hasTwoParameters: Bool = true
}

let calculator = CalculatorApp()


enum Actions {
    case addition
    case substraction
    case multiplication
    case division
}

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    
    @IBOutlet var actionButtons: Array<UIButton>!

    
    @IBAction func numButtons(_ sender: UIButton) {
        for button in actionButtons {
            button.backgroundColor = .systemGray5
        }
        resultLabel.text = resultLabel.text! + String(sender.tag)
    }
    
    func setAction(action: Actions, button: UIButton) {
        checkActionIsChoosen()
        resultLabel.text = ""
        calculator.action = action
        calculator.isDotActive = false
        highLightButton(button: button)
    }
    
    // сложение
    @IBAction func additionAction(_ sender: UIButton) {
        setAction(action: .addition, button: sender);
    }
    
    // вычитание
    @IBAction func substractionAction(_ sender: UIButton) {
        setAction(action: .substraction, button: sender);
    }
    
    // умножение
    @IBAction func multiplicationAction(_ sender: UIButton) {
        setAction(action: .multiplication, button: sender);
    }
    
    // деление
    @IBAction func divisionAction(_ sender: UIButton) {
        setAction(action: .division, button: sender);
    }
    

    
    // проценты
    @IBAction func percentAction(_ sender: UIButton) {
        if resultLabel.text != "" {
            resultLabel.text = String(calculator.numOne! / 100 * Double(resultLabel.text!)!)
        }
    }
    
    //  квадратный корень
    @IBAction func squarerootAction(_ sender: UIButton) {
        if resultLabel.text != "" {
            calculator.numOne = Double(resultLabel.text!)!
            resultLabel.text = String(calculator.numOne!.squareRoot())
        }
    }
    
    // +-
    @IBAction func plusMinusAction(_ sender: UIButton) {
        if resultLabel.text != "" {
            resultLabel.text = "-" + resultLabel.text!
        }
    }
    
    // АС
    @IBAction func allClearButton(_ sender: UIButton) {
        calculator.numOne = nil
        calculator.numTwo = nil
        calculator.action = nil
        calculator.isActionChoosen = false
        calculator.hasTwoParameters = true
        resultLabel.text = ""
        for button in actionButtons {
            button.backgroundColor = .systemGray5
        }
    }
    
    // точка
    @IBAction func dotAction(_ sender: UIButton) {
        if calculator.isDotActive == false && resultLabel.text != "" {
            resultLabel.text = resultLabel.text! + "."
            calculator.isDotActive = true
        }
    }
    
    
    // равно
    @IBAction func resultButton(_ sender: UIButton) {
        calculate()
        calculator.isActionChoosen = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func doubleToInt() {
        let resultString = resultLabel.text!.split(separator: ".")
        if Int(resultString[1]) == 0 {
            resultLabel.text = String(resultString[0])
        }
    }
    
    func checkActionIsChoosen () {
        if calculator.isActionChoosen {
            calculate()
        } else if resultLabel.text != "" {
            calculator.isActionChoosen = true
            calculator.numOne = Double(resultLabel.text!)!
        }
    }
    
    func highLightButton (button: UIButton) {
        for button in actionButtons {
            button.backgroundColor = .systemGray5
        }
        button.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    }
    
    func calculate () {
        let inputValue = Double(resultLabel.text!)
       
        if resultLabel.text == "" {
            calculator.numTwo = calculator.numOne
            calculator.hasTwoParameters = false
        }
        
        switch calculator.action {
            
            case .addition:
                if resultLabel.text == "" {
                    resultLabel.text = String(calculator.numOne! + calculator.numOne!)
                } else if resultLabel.text != "" && calculator.hasTwoParameters == false {
                    calculator.numOne! = inputValue! + calculator.numTwo!
                    resultLabel.text = String(calculator.numOne!)
                } else {
                    calculator.numOne = calculator.numOne! + inputValue!
                    resultLabel.text = String(calculator.numOne!)
                }
            
            case .substraction:
                if resultLabel.text == "" {
                    resultLabel.text = String(calculator.numOne! - calculator.numOne!)
                } else if resultLabel.text != "" && calculator.hasTwoParameters == false {
                    calculator.numOne = inputValue! - calculator.numTwo!
                    resultLabel.text = String(calculator.numOne!)
                } else {
                    calculator.numOne = calculator.numOne! - inputValue!
                    resultLabel.text = String(calculator.numOne!)
                }
            
            case .multiplication:
                if resultLabel.text == "" {
                    resultLabel.text = String(calculator.numOne! * calculator.numOne!)
                } else if resultLabel.text != "" && calculator.hasTwoParameters == false {
                    calculator.numOne! = inputValue! * calculator.numTwo!
                    resultLabel.text = String(calculator.numOne!)
                } else {
                    calculator.numOne = calculator.numOne! * inputValue!
                    resultLabel.text = String(calculator.numOne!)
                }
            
            case .division:
                if resultLabel.text == "" {
                    resultLabel.text = String(calculator.numOne! / calculator.numOne!)
                } else if resultLabel.text != "" && calculator.hasTwoParameters == false {
                    calculator.numOne = inputValue! / calculator.numTwo!
                    resultLabel.text = String(calculator.numOne!)
                } else {
                    calculator.numOne = calculator.numOne! / inputValue!
                    resultLabel.text = String(calculator.numOne!)
                }
            
            case .none:
                break
        }
        doubleToInt()
    }
}

// надо сделать что то с отображением числе в виде Инт и Дабл
