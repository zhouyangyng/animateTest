//
//  TestSwiftController.swift
//  test
//
//  Created by 周洋 on 2018/3/4.
//  Copyright © 2018年 mac1. All rights reserved.
//

import UIKit

class TestSwiftController: UIViewController {
    
    var person:Person?;
    
    @objc lazy var per:Person = {
      
        let per = Person();
        per.name = "哈哈哈😀";
        return per;
    }();

    override func viewDidLoad() {
        super.viewDidLoad()

        print(person!);
        
        //使用柯西特性
        let addTwo = add(num: 2);
        
        
    }
    
    @objc func testType() {
        
        var arr1 = [1, 2];
        
        sweap(someArray: &arr1, num1: 0, num2: 1);
        
        print(arr1);
    }

    //暴露给OC
    @objc func testPrint() {
        
        print(self.per.name);
    }
    
    //泛型、元祖特性
    func sweap<T>(someArray: inout[T], num1: Int, num2: Int) {
        
        (someArray[num1], someArray[num2]) = (someArray[num2], someArray[num1])
        
    }
    
    func add(num: Int) -> (Int) -> Int {
        
        return {val in
            return num + val;
        }
    }

}







