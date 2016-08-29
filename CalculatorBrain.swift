//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by ted on 16/8/22.
//  Copyright © 2016年 ted. All rights reserved.
//

import Foundation

func multiple(op1 : Double , op2 : Double) -> Double
{
    return op1 * op2 
}
class CalculatorBrain
{
    private var accumulator = 0.0

    var operations: Dictionary<String,Operation> = [
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "✔️" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "✖️" : Operation.BinaryOperation(){$0 * $1},
        "➗" : Operation.BinaryOperation(){$0 / $1},
        "➕" : Operation.BinaryOperation(){$0 + $1},
        "➖" : Operation.BinaryOperation(){$0 - $1},
        "=" : Operation.Equals
    ]

    enum Operation {
        case Constant(Double)  //associate value应用
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double,Double) -> Double)
        case Equals
    }
    func setOperand(operand: Double){
        accumulator = operand
        
    }
    func performOperation(symbol: String){
        if let operation = operations[symbol] { //operations是dictionary,此时operation已获取Constant的association value
//        accumulator = constant
//        }
        switch operation {
        case .Constant(let associatedConstantValue) : accumulator = associatedConstantValue
        case .UnaryOperation(let function) : accumulator = function(accumulator)
        case .BinaryOperation(let function) :
            executePendingBinaryOperation()
            pending = PendingBinaryOperationInfo(binaryOperation: function, firstOperand: accumulator)
        case .Equals:
            executePendingBinaryOperation()
            
//        default:
//            break;
        }
        }
    }
    private func executePendingBinaryOperation()
    {
        if pending != nil {
            accumulator = pending!.binaryOperation(pending!.firstOperand,accumulator)
            pending = nil
        }
    }
    private var pending: PendingBinaryOperationInfo?
    struct PendingBinaryOperationInfo {
        var binaryOperation : (Double,Double) -> Double
        var firstOperand : Double
    }
    var result: Double {
        get {
            return accumulator
        }
    }
}