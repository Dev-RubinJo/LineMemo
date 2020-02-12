//
//  SplashActor.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/11.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

class SplashActor: SplashActorDelegate {

    static var shared: SplashActorDelegate? = SplashActor()
    private init() {}

    weak var view: SplashVCRouterDelegate?
    
    func didLoadSplash() {
        self.view?.presentMainVC()
    }
    
    deinit {
        print("deinit")
    }
}
