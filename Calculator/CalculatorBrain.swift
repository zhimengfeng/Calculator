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
    
    //二元运算等待操作缓存
    private var pbo: PendingBinaryOperation?
    
    // 运算符与运算规则的字典明细
    private var operations: Dictionary<String, Operation> = [
        "π": .constant(Double.pi),
        "e": .constant(M_E),
        "√": .unaryOperation(sqrt),
        "cos": .unaryOperation(cos),
        "±": .unaryOperation({ -$0 }),
        // "×": .binaryOperation({(op1: Double, op2: Double) -> Double in return op1 * op2 }),
        // "×": .binaryOperation({(op1, op2) in return op1 * op2 }),
        // "×": .binaryOperation({(op1, op2) in op1 * op2 }),
        "+": .binaryOperation({ $0 + $1 }),
        "−": .binaryOperation({ $0 - $1 }),
        "×": .binaryOperation({ $0 * $1 }),
        "÷": .binaryOperation({ $0 / $1 }),
        "=": .equals
    ]
    
    // 执行计算
    mutating func performOperation(_ symbol: String) {
        // 首先根据操作符，去字典中获取操作规则明细
        if let operation = operations[symbol] {
            switch operation {
            // 常量
            case .constant(let value):
                accumulator = value
            // 一元运算符
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            // 二元运算符
            case .binaryOperation(let function):
                if accumulator != nil {
                    pbo = PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator = nil
                }
            // 等于运算符
            case .equals:
                if (pbo != nil && accumulator != nil) {
                    accumulator = pbo?.perform(with: accumulator!)
                    pbo = nil
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
        // 二元运算符
        case binaryOperation((Double, Double) -> Double)
        // 等于号
        case equals
    }
    
    
    /// 二元运算等待操作结构体
    /// 用于进行二元运算时，对 首位操作数 和 操作方法 的缓存
    private struct PendingBinaryOperation {
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
}
