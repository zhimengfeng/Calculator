//
//  ViewController.swift
//  Calculator
//
//  Created by 朱文杰 on 2023/6/17.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    // 用户正在输入中
    var userIsInTheMiddOfTyping: Bool = false

    // 数字按键 触摸事件
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = (sender.titleLabel?.text)!
        
        if (userIsInTheMiddOfTyping) {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        }
        else {
            display.text = digit
            userIsInTheMiddOfTyping = true
        }
    }

    // 计算属性：显示内容的浮点值
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            // newValue 为set方法默认的新值
            display.text = String(newValue)
        }
    }

    // 运算符 触摸事件
    @IBAction func performOperation(_ sender: UIButton) {
        userIsInTheMiddOfTyping = false
        if let mathmaticalSymbol = sender.titleLabel?.text {
            switch mathmaticalSymbol {
            case "π":
                // display.text = "\(Double.pi)"
                // display.text = String(Double.pi)
                displayValue = Double.pi
            case "√":
                // let operand = Double(display.text!)!
                // display.text = String(sqrt(operand))
                displayValue = sqrt(displayValue)
            default:
                break
            }
        }
    }
    
}

