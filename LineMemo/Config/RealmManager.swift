//
//  RealmManager.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/12.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import Foundation
// 메모 데이터 저장을 위해 CoreData 대신 Realm 모바일 DB를 사용
import RealmSwift

class RealmManager {
    
    static let `default` = RealmManager()
    private let realm = try? Realm()
    
    // delete table
    func deleteDatabase() {
        try! self.realm?.write({
            self.realm?.deleteAll()
        })
    }
    
    // delete particular object
    func deleteObject(objs : Object) {
        try? self.realm!.write ({
            self.realm?.delete(objs)
        })
    }
    
    // Save array of objects to database
    func saveObjects(objs: Object) {
        try? self.realm!.write ({
            // If update = false, adds the object
            self.realm?.add(objs, update: .error)
        })
    }
    
    // editing the object
    func editMemoObjects(memo: Memo, title: String, content: String) {
        try? self.realm!.write ({
            memo.title = title
            memo.content = content
            self.realm?.add(memo, update: .all)
        })
    }
    
    // Returns an Object
    func getObject(type: Object.Type, objectId: Int) -> Object? {
        return self.realm!.objects(type).filter("id == \(objectId)").first
    }
    
    // Returns an array as Results<object>?
    func getObjects(type: Object.Type) -> Results<Object>? {
        return self.realm!.objects(type)
    }
}
