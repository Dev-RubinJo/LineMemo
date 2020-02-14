//
//  MemoDetailProtocol.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/13.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

protocol MemoDetailVCProtocol: BaseVCProtocol {
    
    var actor: MemoDetailActorDelegate? { get set }
}

protocol MemoDetailVCRouterProtocol: class {
    
    static func makeMemoDetailVC() -> MemoDetailVC
}

protocol MemoDetailActorDelegate: class {
    var view: MemoDetailVCRouterProtocol? { get set }
    
    func didLoadMemoDetailVC()
}
