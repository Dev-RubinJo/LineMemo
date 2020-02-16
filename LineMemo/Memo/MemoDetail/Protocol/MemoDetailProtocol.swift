//
//  MemoDetailProtocol.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/13.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import Foundation

protocol MemoDetailVCProtocol: BaseVCProtocol {
    
    var actor: MemoDetailActorDelegate? { get set }
}

protocol MemoDetailVCRouterProtocol: class {
    
    static func makeMemoDetailVC() -> MemoDetailVC
}

protocol MemoDetailActorDelegate: class {
    var view: MemoDetailVCRouterProtocol? { get set }
    
    func didLoadMemoDetailVC()
    
    func appendImageToMemo(memo: Memo, image: Data)
    
    func didTapAddButtonItem(memo: Memo)
    
    func didTapEditButtonItem(memo: Memo, title: String, content: String)
    
    func presentGetUrlAlert(toVC vc: MemoDetailVC)
}
