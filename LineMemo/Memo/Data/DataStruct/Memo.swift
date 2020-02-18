//
//  Memo.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/12.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit
// 메모 데이터 저장을 위해 CoreData 대신 Realm 모바일 DB를 사용
import RealmSwift

class Image: Object {
    
    // MARK: Property
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var imageUrl: Data = Data()
    
    // MARK: Init
    convenience init(image: Data) {
        self.init()
        self.imageUrl = image
    }
    
    // MARK: Meta
    override class func primaryKey() -> String? {
        return "id"
    }
}

class Memo: Object {
    
    // MARK: Properties
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var content: String = ""
    let imageList = List<Image>()
    
    // MARK: Meta
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // MARK: Init
    convenience init(id: Int, title: String, content: String, imageList: [UIImage]) {
        self.init()
        self.id = id
        self.title = title
        self.content = content
    }
    
    // MARK: Default Memo
    private static func createDefaultMemo(in realm: Realm) -> Memo {
        let id = UserDefaults.standard.integer(forKey: "memoIdNumber")
        let memo = Memo(id: id, title: "Tutorial", content: "튜토리얼입니다. 해당 어플리케이션은 메모장 어플리케이션입니다. 위 + 모양의 사각형을 눌러서 이미지를 첨부 할 수 있습니다. 또한 첨부된 이미지는 해당 이미지를 꾹 누르고 계시면 삭제를 할 수가 있고, 한번 누르면 이미지를 크게 볼 수 있습니다. 이미지를 크게 볼때는 첫 이미지부터 볼 수 있습니다.", imageList: [])
        UserDefaults.standard.set(id + 1, forKey: "memoIdNumber")
        try! realm.write {
            realm.add(memo)
        }
        return memo
    }
    
    @discardableResult static func checkDefaultMemo(in realm: Realm) -> Memo {
        return realm.object(ofType: Memo.self, forPrimaryKey: 1) ?? createDefaultMemo(in: realm)
    }
}
