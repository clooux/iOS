//
//  ViewController.swift
//  Week1
//
//  Created by user249775 on 11/18/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var Result: UILabel!
    
    var number: String = ""
    var currentResult: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func numbers(_ sender: UIButton) {
        if Result.text!.count < 15 {
            if number.first == "0" {
                number.removeFirst()
            }
            number += String(sender.tag)
        }
        Result.text = number
    }
    
    @IBAction func deleteLastNumber(_ sender: UIButton) {
        if !number.isEmpty {
            number.removeLast()
        }
        Result.text = number
    }
    
    @IBAction func deleteAll(_ sender: UIButton) {
        number.removeAll()
        Result.text = number
    }
    
    @IBAction func floatNumber(_ sender: UIButton) {
        number += "."
        Result.text = number
    }
    
    @IBAction func percent(_ sender: UIButton) {
        if !number.isEmpty{
            number += "%"
        }
        Result.text = number
    }
    
    @IBAction func result(_ sender: UIButton) {
        Result.text = currentResult
        number = currentResult
    }
    
    @IBAction func operations(_ sender: UIButton) {
        if sender.tag == 10 {
            devisionOnZero()
            if number.isEmpty {
                number = "0"
            }
            if validInput() && validInputForMinus() && validInputForPercent() {
                let checkedWorkingsForPercent = number.replacingOccurrences(of: "%", with: "*0.01")
                let expression = NSExpression(format: checkedWorkingsForPercent)
                let result = expression.toFloatingPoint().expressionValue(with: nil, context: nil) as! Double
                let resultString = formatResult(result: result)
                currentResult = resultString
            } else {
                self.number = ""
                self.Result.text = "0"
            }
        } else if sender.tag == 11 {
            number += "+"
        } else if sender.tag == 12 {
            number += "-"
        } else if sender.tag == 13 {
            number += "*"
        } else if sender.tag == 14 {
            number += "/"
        }
        Result.text = number
    }
    
    func validInput() -> Bool {
        var count = 0
        var charIndexes = [Int]()
        var previous: Int = -1
        
        for char in number {
            if specialCharacter(char: char) {
                charIndexes.append(count)
            }
            count += 1
        }
        
        for index in charIndexes {
            if index == 0 {
                return false
            } else if (index == number.count - 1) {
                return false
            } else if previous != -1 {
                if index - previous == 1 {
                    return false
                }
            }
            previous = index
        }
        return true
    }
    
    func validInputForMinus() -> Bool {
        if number.last == "-" {
            return false
        }
        return true
    }
    
    func validInputForPercent() -> Bool {
        if number.contains("%+%") {
            return false
        } else if number.contains("%-%") {
            return false
        } else if number.contains("%/%") {
            return false
        } else if number.contains("%*%") {
            return false
        }
        return true
    }
    
    func specialCharacter(char: Character) -> Bool {
        if char == "*" {
            return true
        } else if char == "/" {
            return true
        } else if char == "+" {
            return true
        } else if char == "." {
            return true
        }
        return false
    }
    
    func devisionOnZero() {
        if number.contains("/0") {
            self.number = ""
            self.Result.text = "0"
        }
    }
    
    func formatResult(result: Double) -> String {
        if result.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", result)
        } else {
            return String(format: "%.5f", result)
        }
    }
    
}

extension NSExpression {

    func toFloatingPoint() -> NSExpression {
        switch expressionType {
        case .constantValue:
            if let value = constantValue as? NSNumber {
                return NSExpression(forConstantValue: NSNumber(value: value.doubleValue))
            }
        case .function:
           let newArgs = arguments.map { $0.map { $0.toFloatingPoint() } }
           return NSExpression(forFunction: operand, selectorName: function, arguments: newArgs)
        case .conditional:
           return NSExpression(forConditional: predicate, trueExpression: self.true.toFloatingPoint(), falseExpression: self.false.toFloatingPoint())
        case .unionSet:
            return NSExpression(forUnionSet: left.toFloatingPoint(), with: right.toFloatingPoint())
        case .intersectSet:
            return NSExpression(forIntersectSet: left.toFloatingPoint(), with: right.toFloatingPoint())
        case .minusSet:
            return NSExpression(forMinusSet: left.toFloatingPoint(), with: right.toFloatingPoint())
        case .subquery:
            if let subQuery = collection as? NSExpression {
                return NSExpression(forSubquery: subQuery.toFloatingPoint(), usingIteratorVariable: variable, predicate: predicate)
            }
        case .aggregate:
            if let subExpressions = collection as? [NSExpression] {
                return NSExpression(forAggregate: subExpressions.map { $0.toFloatingPoint() })
            }
        case .anyKey:
            fatalError("anyKey not yet implemented")
        case .block:
            fatalError("block not yet implemented")
        case .evaluatedObject, .variable, .keyPath:
            break // Nothing to do here
        }
        return self
    }
}
