//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by 朱文杰 on 2023/6/19.
//

import Foundation

/// 计算器模型：计算器大脑
struct CalculatorBrain {
    
    // 累加器
    private var accumulator: Double?
    
    // 执行计算
    mutating func performOperation(_ symbol: String) {
        switch symbol {
        case "π":
            accumulator = Double.pi
        case "√":
            accumulator = sqrt(accumulator!)
        default:
            break
        }
    }
    
    // 设置操作数
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    var result: Double? {
        get {
            return accumulator
        }
    }
    
}
