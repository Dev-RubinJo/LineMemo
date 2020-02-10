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
    
    func appearIndicator() {
        self.indicator.show()
    }
    
    func disappearIndicator() {
        self.indicator.dismiss()
    }
}
