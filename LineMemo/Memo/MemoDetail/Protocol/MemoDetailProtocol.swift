//
//  MemoDetailProtocol.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/13.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit

protocol MemoDetailVCProtocol: BaseVCProtocol {
    
    var actor: MemoDetailActorDelegate? { get set }
}

protocol MemoDetailVCRouterProtocol: class {
    
    static func makeMemoDetailVC() -> MemoDetailVC
    
    func presentImagePickerController(targetVC vc: UIImagePickerController)
    
    func presentImageDetailVC(fromVC vc: MemoDetailVC, imageIndex: Int)
}

protocol MemoDetailActorDelegate: class {
    
    var view: MemoDetailVCRouterProtocol? { get set }
    
    func appendImageToMemo(memo: Memo, image: Data)
    
    func didTapAddButtonItem(memo: Memo)
    
    func didTapEditButtonItem(memo: Memo, title: String, content: String)

    func presentDeleteMemoAlert(toVC vc: MemoDetailVC)
    
    /// 사진 불러올 때의 액션시트 띄우기 함수
    func showAddImageSheet(toVC vc: MemoDetailVC)
    
    func presentGetUrlAlert(toVC vc: MemoDetailVC)
    
    func presentDeleteImageAlert(toVC vc: MemoDetailVC, memo: Memo, imageIndex: Int)
    
    func didTapImageCell(fromVC vc: MemoDetailVC, imageIndex: Int)
}

