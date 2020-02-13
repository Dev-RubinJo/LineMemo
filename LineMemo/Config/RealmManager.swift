//
//  RealmManager.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/12.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import Foundation
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
    func editObjects(objs: Object) {
        try? self.realm!.write ({
            // If update = true, objects that are already in the Realm will be
            // updated instead of added a new.
            self.realm?.add(objs, update: .all)
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
