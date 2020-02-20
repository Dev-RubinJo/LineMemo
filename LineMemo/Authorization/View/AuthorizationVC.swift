//
//  AuthorizationVC.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/15.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit

class AuthorizationVC: BaseVC, AuthorizationVCProtocol {
    
    @IBOutlet weak var getAuthorizationButton: UIButton!
    
    private let _window: UIWindow = UIApplication.shared.windows.first ?? UIApplication.shared.keyWindow ?? UIWindow.init(frame: UIScreen.main.bounds)
    
    weak var actor: AuthorizationActorDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initVC()
    }
    
    func initVC() {
        self.getAuthorizationButton.addTarget(self, action: #selector(self.pressGetAuthorizationButton(_:)), for: .touchUpInside)
    }
    
    @objc func pressGetAuthorizationButton(_ sender: UIButton) {
        self.actor?.getCameraAuthorization(toVC: self)
        self.actor?.getPhotoAlbumAuthorization(toVC: self)
        // 동의를 안할 수도 있으므로 바로 Main을 띄울수 있도록 함
        self.presentMainVC()
    }
}
extension AuthorizationVC: AuthorizationVCRouterDelegate {
    
    unowned var window: UIWindow {
        get {
            self._window
        }
    }
    
    static func makeAuthorizationVC() -> AuthorizationVC {
        let vc = AuthorizationVC()
        let actor = AuthorizationActor.shared
        
        vc.actor = actor
        actor.view = vc
        return vc
    }
    
    func presentMainVC() {
        let mainVC = UINavigationController.init(rootViewController: MainVC.makeMainVC())
        self.window.rootViewController = mainVC
        self.window.makeKeyAndVisible()
        
        UIView.transition(with: self.window, duration: 0.2, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}
