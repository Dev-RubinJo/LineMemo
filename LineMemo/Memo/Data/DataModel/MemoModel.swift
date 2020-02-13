//
//  MemoModel.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/13.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import Foundation

class MemoModel {
    
    static let shared = MemoModel()
    private init() {
        guard let memoDatas = RealmManager.default.getObjects(type: Memo.self) else { return }
        for memoData in memoDatas {
            guard let memo = memoData as? Memo else { return }
            self._memoList.append(memo)
        }
    }
    
    private var _memoList: [Memo] = []
    
    var memoList: [Memo] {
        get {
            return self._memoList
        }
    }
    
    func addNewMemo(newMemo memo: Memo) {
        self._memoList.append(memo)
        RealmManager.default.saveObjects(objs: memo)
    }
}
