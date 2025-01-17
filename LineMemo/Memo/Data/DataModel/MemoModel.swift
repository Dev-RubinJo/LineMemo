//
//  MemoModel.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/13.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import Foundation
// 메모 데이터 저장을 위해 CoreData 대신 Realm 모바일 DB를 사용
import RealmSwift

class MemoModel {
    
    private let realm = try! Realm()
    
    static let shared = MemoModel()
    private init() {
        guard let memoDatas = RealmManager.default.getObjects(type: Memo.self)?.sorted(byKeyPath: "id", ascending: true) else { return }
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
    
    func editMemo(memo: Memo, title: String, content: String) {
        RealmManager.default.editMemoObjects(memo: memo, title: title, content: content)
    }
    
    func addImage(memo: Memo, imageData: Data) {
        try? self.realm.write ({
            let image = Image(image: imageData)
            memo.imageList.append(image)
            self.realm.add(memo, update: .all)
        })
    }
    
    func removeMemoImage(memo: Memo, imageIndex: Int) {
        try? self.realm.write ({
            let image = memo.imageList[imageIndex]
            memo.imageList.remove(at: imageIndex)
            self.realm.delete(image)
        })
    }
    
    func deleteMemo(targetMemo memo: Memo, index: Int) {
        self._memoList.remove(at: index)
        RealmManager.default.deleteObject(objs: memo)
    }
}
