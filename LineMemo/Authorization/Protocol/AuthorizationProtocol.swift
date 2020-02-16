//
//  AuthorizationProtocol.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/15.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit

protocol AuthorizationVCDelegate: BaseVCProtocol {
    
    var actor: AuthorizationActorDelegate? { get set }
}

protocol AuthorizationVCRouterDelegate: class {
    
    var window: UIWindow { get }
    
    static func makeAuthorizationVC() -> AuthorizationVC
    
    func presentMainVC()
}

protocol AuthorizationActorDelegate: class {
    
    var view: AuthorizationVCRouterDelegate? { get set }
    
    func getCameraAuthorization(toVC vc: AuthorizationVC)
    
    func getPhotoAlbumAuthorization(toVC vc: AuthorizationVC)
}
