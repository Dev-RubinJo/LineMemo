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
    
    func presentImageDetailVC(fromVC vc: MemoDetailVC, imageIndex: Int)
}

protocol MemoDetailActorDelegate: class {
    // TODO: 이미지 삭제 기능 추가
    // TODO: 이미지 크게 보기 기능 추가

    var view: MemoDetailVCRouterProtocol? { get set }
    
    func didLoadMemoDetailVC()
    
    func appendImageToMemo(memo: Memo, image: Data)
    
    func didTapAddButtonItem(memo: Memo)
    
    func didTapEditButtonItem(memo: Memo, title: String, content: String)
    
    func didTapDeleteButtonItem(memo: Memo, index: Int)
    
    func presentDeleteMemoAlert(toVC vc: MemoDetailVC)
    
    func presentGetUrlAlert(toVC vc: MemoDetailVC)
    
    func presentDeleteImageAlert(toVC vc: MemoDetailVC, memo: Memo, imageIndex: Int)
    
    func didTapImageCell(fromVC vc: MemoDetailVC, imageIndex: Int)
}

