//
//  Memo.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/12.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import RealmSwift

class Image: Object {
    @objc dynamic var imageUrl: String = ""
}

class Memo: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
//    @objc dynamic var
    @objc dynamic var content: String = ""
}
