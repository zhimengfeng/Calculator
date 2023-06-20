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

    // 计算器模型：计算器大脑
    private var brain = CalculatorBrain()
    
    // 数字按键 触摸事件
    @IBAction func touchDigit(_ sender: UIButton) {
        // 输入的数字
        let digit = (sender.titleLabel?.text)!
        
        // 正在输入中，那么当前输入的数字自动拼接至当前显示内容的尾部
        if (userIsInTheMiddOfTyping) {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        }
        // 否则，将当前显示的内容更改为当前输入的数字
        else {
            // 小数点特殊处理：当无显示内容直接输入小数点时，前部自动拼接数字零
            display.text = "." == digit ? "0." : digit
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
        // 如果当前为用户正在输入的过程中，那么设置操作数为当前显示的内容
        if (userIsInTheMiddOfTyping) {
            brain.setOperand(displayValue)
            userIsInTheMiddOfTyping = false
        }
        // 如果有运算符，那么使用运算符进行计算
        if let mathmaticalSymbol = sender.titleLabel?.text {
            brain.performOperation(mathmaticalSymbol)
        }
        if let result = brain.result {
            displayValue = result
        }
    }
    
}

