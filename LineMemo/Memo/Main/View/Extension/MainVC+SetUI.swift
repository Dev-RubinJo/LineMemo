//
//  MainVC+SetUI.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/13.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit

extension MainVC {
    func setMainUI() {
        self.addButton.addTarget(self, action: #selector(self.pressAddButton(_:)), for: .touchUpInside)
        
        
        let memoCellNib = UINib.init(nibName: "MemoCell", bundle: nil)
        self.memoListTableView.register(memoCellNib, forCellReuseIdentifier: "MemoCell")
    }
    
    /// add 버튼 함수 정의
    @objc func pressAddButton(_ sender: UIButton) {
        self.actor?.didTapAddButton()
    }
}
