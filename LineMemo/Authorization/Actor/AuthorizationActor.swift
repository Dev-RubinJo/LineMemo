//
//  AuthorizationActor.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/15.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit
import Photos

class AuthorizationActor: AuthorizationActorDelegate {

    weak var view: AuthorizationVCRouterDelegate?
    
    static let shared = AuthorizationActor()
    private init() {}
    
    let dialog = UIAlertController(title: "주의", message: "일부 기능이 동작하지 않습니다. [설정] 에서 허용할 수 있습니다.", preferredStyle: .alert)
    let action = UIAlertAction(title: "확인", style: .default)
    
    func getCameraAuthorization(toVC vc: AuthorizationVC) {
        AVCaptureDevice.requestAccess(for: .video) { response in
            if !response {
                self.dialog.addAction(self.action)
                vc.present(self.dialog, animated: true, completion: nil)
            } else {
                
            }
        }
    }
    
    func getPhotoAlbumAuthorization(toVC vc: AuthorizationVC) {
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status != .authorized {
                    self.dialog.addAction(self.action)
                    vc.present(self.dialog, animated: true, completion: nil)
                } else {
                    //                    self.presentAlert(title: "Photos Access Denied", message: "App needs access to photos library.")
                }
            })
        }
    }
}
