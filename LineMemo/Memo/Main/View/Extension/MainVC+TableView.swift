//
//  MainVC+TableView.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/13.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.actor?.memoListData.count ?? 0
//        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MemoCell", for: indexPath) as? MemoCell else {
            return UITableViewCell()
        }
        
        let memoCellData = self.actor?.memoListData[indexPath.row]
        
        cell.memoCellTitleLabel.text = memoCellData?.title
        cell.memoCellContentLabel.text = memoCellData?.content
        if (memoCellData?.imageList.isEmpty)! {
            cell.setMemoCellImageViewHidden(true)
        } else {
            cell.setMemoCellImageViewHidden(false)
            cell.memoCellImageView.image = UIImage(data: (memoCellData?.imageList[0].imageUrl)!)
        }
        return cell
    }
    
    // ios 10 버전도 지원하기 위하여 editActionsForRowAt 함수를 사용
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "삭제") { (action, indexPath) in
            guard let memoCellData = self.actor?.memoListData[indexPath.row] else {
                return
            }
            self.actor?.deleteMemoData(memoCellData, indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.actor?.didTapMemoListTableViewCell(index: indexPath.row)
    }
}
