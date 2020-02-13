//
//  MainActor.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/11.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

class MainActor: MainActorDelegate {
    
    static let shared: MainActorDelegate = MainActor()
    private init() {}
    
    weak var view: MainVCRouterDelegate?
    
    func didLoadMainVC() {
        MemoModel.shared
        print(MemoModel.shared.memoList.count)
    }
    
    func didTapAddButton() {
        self.view?.presentMemoDetailVC()
    }
}
