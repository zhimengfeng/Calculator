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
    
    private var operations: Dictionary<String, Operation> = [
        "π": .constant(Double.pi),
        "e": .constant(M_E),
        "√": .unaryOperation(sqrt),
        "cos": .unaryOperation(cos),
        "±": .unaryOperation(changeSign)
    ]
    
    // 执行计算
    mutating func performOperation(_ symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            }
        
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
    
    
    /// 运算枚举
    private enum Operation {
        // 常量
        case constant(Double)
        // 一元运算符
        case unaryOperation((Double) -> Double)
    }
}

/// 值取反
/// - Parameter operand: 操作数
/// - Returns: 对操作数取反后的值
private func changeSign(operand: Double) -> Double {
    return -operand
}
