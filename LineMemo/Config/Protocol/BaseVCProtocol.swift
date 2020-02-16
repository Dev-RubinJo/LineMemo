//
//  BaseVCProtocol.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/10.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit

@objc protocol BaseVCProtocol {
    
    func initVC()
    
    @objc optional func setDarkModeUI()
}
