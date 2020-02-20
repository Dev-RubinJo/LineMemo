//
//  SplashVC.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/11.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit

class SplashVC: BaseVC, SplashVCProtocol {
    
    @IBOutlet weak var splashLabel: UILabel!
    
    private let _window: UIWindow = UIApplication.shared.windows.first ?? UIApplication.shared.keyWindow ?? UIWindow.init(frame: UIScreen.main.bounds)
    weak var actor: SplashActorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initVC()
        self.delay(0.6) { [weak self] in
            self?.actor?.didLoadSplash()
        }
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
    
    unowned var window: UIWindow {
        get {
            self._window
        }
    }
    
    static func makeSplashVC() -> SplashVC {
        let vc = SplashVC()
        let actor = SplashActor.shared
        
        vc.actor = actor
        actor.view = vc
        return vc
    }
    
    func presentAuthorizationVC() {
        self.window.rootViewController = AuthorizationVC.makeAuthorizationVC()
        self.window.makeKeyAndVisible()
        
        UIView.transition(with: self.window, duration: 0.1, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
    
    func presentMainVC() {
        let mainVC = UINavigationController.init(rootViewController: MainVC.makeMainVC())
        self.window.rootViewController = mainVC
        self.window.makeKeyAndVisible()
        
        UIView.transition(with: self.window, duration: 0.2, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}
