//
//  SplashProtocol.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/11.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit

protocol SplashVCDelegate: BaseVCProtocol {
    
    var actor: SplashActorDelegate? { get set }
}

protocol SplashVCRouterDelegate: class {
    
    var window: UIWindow? { get }
    
    func makeSplashVC() -> SplashVC
    
    func presentMainVC()
}

protocol SplashActorDelegate: class {
    
    var view: SplashVCRouterDelegate? { get set }
    
    func didLoadSplash()
}
