//
//  SplashProtocol.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/11.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

protocol SplashVCDelegate: BaseVCProtocol {
    
    var actor: SplashActorDelegate? { get set }
}

protocol SplashVCRouterDelegate: class {
    
    func makeSplashVC() -> SplashVC
    
    func presentMainVC()
}

protocol SplashActorDelegate: class {
    
    var view: SplashVCRouterDelegate? { get set }
    
    func didLoadSplash()
}
