//
//  SplashProtocol.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/11.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit

protocol SplashVCProtocol: BaseVCProtocol {
    
    var actor: SplashActorDelegate? { get set }
}

protocol SplashVCRouterDelegate: class {
    
    var window: UIWindow { get }
    
    static func makeSplashVC() -> SplashVC
    
    func presentAuthorizationVC()
    
    func presentMainVC()
}

protocol SplashActorDelegate: class {
    
    var view: SplashVCRouterDelegate? { get set }
    
    func didLoadSplash()
}
