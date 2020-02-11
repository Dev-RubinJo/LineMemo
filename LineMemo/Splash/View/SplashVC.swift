//
//  SplashVC.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/11.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit

class SplashVC: BaseVC, SplashVCDelegate {
    
    static let viewRouter: SplashVCRouterDelegate = SplashVC()
    weak var actor: SplashActorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initVC()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.actor?.didLoadSplash()
    }
    
    func initVC() {
        self.setDarkModeUI()
    }
    
    func setDarkModeUI() {
        
    }
}
extension SplashVC: SplashVCRouterDelegate {
    func makeSplashVC() -> SplashVC {
        let vc = SplashVC()
        let actor = SplashActor.shared
        
        vc.actor = actor
        actor.view = vc
        return vc
    }
    
    func presentMainVC() {
        
    }
}
