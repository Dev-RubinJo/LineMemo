//
//  MemoDetailActor.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/13.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

class MemoDetailActor: MemoDetailActorDelegate {
    
    static let shared = MemoDetailActor()
    private init() {}
    
    weak var view: MemoDetailVCRouterProtocol?
    
    func didLoadMemoDetailVC() {
        
    }
}
