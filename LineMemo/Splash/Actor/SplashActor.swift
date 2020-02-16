//
//  SplashActor.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/11.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import Foundation
import RealmSwift

class SplashActor: SplashActorDelegate {

    static let shared: SplashActorDelegate = SplashActor()
    private init() {}
    
    private let realm = try! Realm()

    weak var view: SplashVCRouterDelegate?
    
    func didLoadSplash() {
        // UserDefault.standard.bool(forKey: "FirstAppLaunch") 값의 의미: 앱을 설치하고 처음 실행하면 false, 그 이후로는 true
        if !UserDefaults.standard.bool(forKey: "FirstAppLaunch") {
            Memo.checkDefaultMemo(in: self.realm)
            UserDefaults.standard.set(true, forKey: "FirstAppLaunch")
            self.view?.presentAuthorizationVC()
            // Memo 데이터의 id 초기값 1로 설정
            UserDefaults.standard.set(1, forKey: "memoIdNumber")
        } else {
            self.view?.presentMainVC()
        }
    }
}
