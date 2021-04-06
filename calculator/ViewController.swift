//
//  ViewController.swift
//  calculator
//
//  Created by Жеребцов Данил on 15.03.2021.
//

import UIKit

enum Actions {
    case addition
    case substraction
    case multiplication
    case division
}

class ViewController: UIViewController {
    var numOne: Double? = nil
    var numTwo: Double? = nil
    var action: Actions? = nil
    var isActionChoosen: Bool = false
    var isDotActive: Bool = false
    var hasTwoParameters: Bool = true

    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet var actionButtons: Array<UIButton>!
    
    @IBAction func numButtons(_ sender: UIButton) {
        for button in actionButtons {
            button.backgroundColor = .systemGray5
        }
        resultLabel.text = resultLabel.text! + String(sender.tag)
    }
    
    func setAction(newAction: Actions, button: UIButton) {
        checkActionIsChoosen()
        resultLabel.text = ""
        action = newAction
        isDotActive = false
        highLightButton(button: button)
    }
    
    // сложение
    @IBAction func additionAction(_ sender: UIButton) {
        setAction(newAction: .addition, button: sender);
    }
    
    // вычитание
    @IBAction func substractionAction(_ sender: UIButton) {
        setAction(newAction: .substraction, button: sender);
    }
    
    // умножение
    @IBAction func multiplicationAction(_ sender: UIButton) {
        setAction(newAction: .multiplication, button: sender);
    }
    
    // деление
    @IBAction func divisionAction(_ sender: UIButton) {
        setAction(newAction: .division, button: sender);
    }
    

    
    // проценты
    @IBAction func percentAction(_ sender: UIButton) {
        if resultLabel.text != "" {
            resultLabel.text = String(numOne! / 100 * Double(resultLabel.text!)!)
        }
    }
    
    //  квадратный корень
    @IBAction func squarerootAction(_ sender: UIButton) {
        if resultLabel.text != "" {
            numOne = Double(resultLabel.text!)!
            resultLabel.text = String(numOne!.squareRoot())
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
        numOne = nil
        numTwo = nil
        action = nil
        isActionChoosen = false
        hasTwoParameters = true
        resultLabel.text = ""
        isDotActive = false
        for button in actionButtons {
            button.backgroundColor = .systemGray5
        }
    }
    
    // точка
    @IBAction func dotAction(_ sender: UIButton) {
        if isDotActive == false && resultLabel.text != "" {
            resultLabel.text = resultLabel.text! + "."
            isDotActive = true
        }
    }
    
    
    // равно
    @IBAction func resultButton(_ sender: UIButton) {
        calculate()
        isActionChoosen = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func trimZero() {
        let inputValue = Double(resultLabel.text!)
        let fract = inputValue!.truncatingRemainder(dividingBy: 1)
        if (fract == 0) {
            resultLabel.text = String(Int(inputValue!))
        }
    }
    
    func checkActionIsChoosen () {
        if isActionChoosen {
            calculate()
        } else if resultLabel.text != "" {
            isActionChoosen = true
            numOne = Double(resultLabel.text!)!
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
            numTwo = numOne
            hasTwoParameters = false
        }
        
        switch action {
            
            case .addition:
                if resultLabel.text == "" {
                    resultLabel.text = String(numOne! + numOne!)
                } else if resultLabel.text != "" && hasTwoParameters == false {
                    numOne! = inputValue! + numTwo!
                    resultLabel.text = String(numOne!)
                } else {
                    numOne = numOne! + inputValue!
                    resultLabel.text = String(numOne!)
                }
            
            case .substraction:
                if resultLabel.text == "" {
                    resultLabel.text = String(numOne! - numOne!)
                } else if resultLabel.text != "" && hasTwoParameters == false {
                    numOne = inputValue! - numTwo!
                    resultLabel.text = String(numOne!)
                } else {
                    numOne = numOne! - inputValue!
                    resultLabel.text = String(numOne!)
                }
            
            case .multiplication:
                if resultLabel.text == "" {
                    resultLabel.text = String(numOne! * numOne!)
                } else if resultLabel.text != "" && hasTwoParameters == false {
                    numOne! = inputValue! * numTwo!
                    resultLabel.text = String(numOne!)
                } else {
                    numOne = numOne! * inputValue!
                    resultLabel.text = String(numOne!)
                }
            
            case .division:
                if resultLabel.text == "" {
                    resultLabel.text = String(numOne! / numOne!)
                } else if resultLabel.text != "" && hasTwoParameters == false {
                    numOne = inputValue! / numTwo!
                    resultLabel.text = String(numOne!)
                } else {
                    numOne = numOne! / inputValue!
                    resultLabel.text = String(numOne!)
                }
            
            case .none:
                break
        }
        if resultLabel.text != "" {
            trimZero()
        }
    }
}

// надо сделать что то с отображением числе в виде Инт и Дабл
