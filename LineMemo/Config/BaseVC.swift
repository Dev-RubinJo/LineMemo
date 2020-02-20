//
//  BaseVC.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/10.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }

    func delay(_ delay:Double, closure: @escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
}
