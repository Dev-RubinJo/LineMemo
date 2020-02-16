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
    
    var memoListData: [Memo] {
        get {
            return MemoModel.shared.memoList
        }
    }
    
    func didLoadMainVC() {
        
    }
    
    func didTapAddButton() {
        self.view?.presentMemoDetailVCToAdd()
    }
    
    func didTapMemoListTableViewCell(index: Int) {
        let memo = self.memoListData[index]
        self.view?.presentMemoDetailVCToEdit(targetMemo: memo, index: index)
    }
    
    func deleteMemoData(_ memo: Memo, _ index: Int) {
        MemoModel.shared.deleteMemo(targetMemo: memo, index: index)
    }
}
