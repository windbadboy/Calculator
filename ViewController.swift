//
//  ViewController.swift
//  Calculator
//
//  Created by ted on 16/8/20.
//  Copyright © 2016年 ted. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    var userIsInTheMiddleOfTypingANumber : Bool = false   //false表示直接在display.text上显示,true表示在display.text上累加显示
    @IBAction func appendDigit(sender: UIButton) {
        if let digit = sender.currentTitle {   //digit显示按下的数值
        if(userIsInTheMiddleOfTypingANumber){
        print("digit is \(digit)")
        display.text = display.text! + digit
        }
        else
        {
            display.text=digit
            userIsInTheMiddleOfTypingANumber = true

        }
        }
    }
    
    var openstack = Array<Double>()   //定义了一个类型为Array<Double>,初始值为空的数组
    private var brain = CalculatorBrain()

    var displayValue: Double {
        get {

            return Double(display.text!)!   //display.text may not be converted
        }
        set {
          //  print("the newValue is \(newValue)")
            display.text = "\(newValue)"
       //     userIsInTheMiddleOfTypingANumber = false
        }
    }
    
    //点击计算符(如sqrt,x),通过setOperand将屏幕显示的数值发送
    //然后获取选择的计算符,执行performOperation
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTypingANumber = false
        }

        if let operate = sender.currentTitle {
            brain.performOperation(operate)
        }
        displayValue = brain.result
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    //   print("displayvalue is \(NSNumberFormatter().numberFromString(display.text!)!.doubleValue)")
    // return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
    
    //        if userIsInTheMiddleOfTypingANumber {
    //            enter()//自动入栈
    //        }
    //        switch operate {
    //        case "✖️":performOperation({ $0 * $1})
    //
    //        case "➗":performOperation { $1 / $0 }
    //
    //        case "➕":performOperation { $0 + $1 }
    //
    //        case "➖":performOperation { $1 - $0 }
    //
    //        case "✔️":performOperation{ sqrt($0) }
    //        default:
    //            break
    //        }
    //    @IBAction func enter() {
    //        userIsInTheMiddleOfTypingANumber=false
    //        openstack.append(displayValue)  //append后面的值必须是double型,这里调用displayvalue的get方法
    //        print("openstack = \(openstack)")
    //    }
//    func performOperation(operation: (Double, Double) -> Double) {
//        if openstack.count >= 2 {
//            displayValue = operation(openstack.removeLast() , openstack.removeLast())
//            enter()
//        }
//    
//    }

//
//    }
//    func performOperation(operation : (Double , Double) -> Double)
//    {
//    if openstack.count >= 2 {
//        displayValue = operation(openstack.removeLast(),openstack.removeLast())
//        enter()
//    }
//        
//    }
//    @objc(methodtwo:)
//    func performOperation(operation: Double -> Double) {
//        if openstack.count >= 1 {
//            displayValue = operation(openstack.removeLast())
//            enter()
//        }
//    }

}

