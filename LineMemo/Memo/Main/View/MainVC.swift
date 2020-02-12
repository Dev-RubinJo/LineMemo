//
//  MainVC.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/11.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit

class MainVC: BaseVC, MainVCDelegate {
    
    static let viewRouter: MainVCRouterDelegate = MainVC()
    
    weak var actor: MainActorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initVC()
    }
    
    func initVC() {
        
    }
    
    func setDarkModeUI() {
        
    }
}
extension MainVC: MainVCRouterDelegate {
    func makeMainVC() -> MainVC {
        let vc = MainVC()
        let actor = MainActor.shared
        
        vc.actor = actor
        actor.view = vc
        return vc
    }
}
