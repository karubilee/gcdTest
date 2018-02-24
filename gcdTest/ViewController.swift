//
//  ViewController.swift
//  gcdTest
//
//  Created by lb. on 2018/2/9.
//  Copyright © 2018年 karubi. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    typealias Task = (_ cancel: Bool) -> Void
    
    func delay(_ time: TimeInterval, task:@escaping ()->()) -> Task? {
        func dispatch_later(block:@escaping ()->() ) {
            let t = DispatchTime.now() + time
            DispatchQueue.main.asyncAfter(deadline: t, execute: block)
        }
        var closure: (()->Void)? = task
        var result: Task?
        let delayedClosure: Task = {
            cancel in
            if let internalClosure = closure {
                if (cancel == false) {
                    DispatchQueue.main.async(execute: internalClosure)
                }
            }
            closure = nil
            result = nil
        }
        result = delayedClosure
        dispatch_later {
            if let delayedClosure = result {
                delayedClosure(false)
            }
        }
        return result
    }
    func cancel(_ task: Task?) {
        task?(true)
    }
    @IBAction func click(_ sender: Any) {
        delay(2) { print("2秒后输出" ) }
        //        let task = delay(5) {
        //            print("打110")
        //        }
        //        cancel(task)
    }
}

