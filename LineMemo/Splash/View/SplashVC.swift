//
//  SplashVC.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/11.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit

class SplashVC: BaseVC, SplashVCDelegate {
    
    @IBOutlet weak var splashLabel: UILabel!
    
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
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.setDarkModeUI()
    }
    
    func initVC() {
        self.setDarkModeUI()
    }
    
    func setDarkModeUI() {
        if self.isDarkMode {
            self.view.backgroundColor = .black
            self.splashLabel.textColor = .white
        } else {
            self.view.backgroundColor = UIColor(hex: ColorPalette.splashBGColor, alpha: 1.0)
            self.splashLabel.textColor = .white
        }
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
    
    func presentMainVC() -> String {
        return "Go to Main"
    }
}
