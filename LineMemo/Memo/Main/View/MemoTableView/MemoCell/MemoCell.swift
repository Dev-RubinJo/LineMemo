//
//  MemoCell.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/13.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit
import SnapKit

class MemoCell: UITableViewCell {
    
    @IBOutlet weak var memoCellTitleLabel: UILabel!
    @IBOutlet weak var memoCellContentLabel: UILabel!
    @IBOutlet weak var memoCellImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    /// - Parameter checkBoolean: 참이라면 imageView의 isHidden 프로퍼티 -> true, 반대의 경우 false
    func setMemoCellImageViewHidden(_ checkBoolean: Bool) {
        if checkBoolean {
            self.memoCellImageView.isHidden = true
            self.memoCellContentLabel.snp.makeConstraints { make in
                make.right.equalTo(self.contentView.snp.rightMargin).offset(10)
            }
        } else {
            self.memoCellImageView.isHidden = false
            self.memoCellContentLabel.snp.makeConstraints { make in
                make.right.equalTo(self.memoCellImageView.snp.leftMargin).offset(-10)
            }
        }
    }
}
