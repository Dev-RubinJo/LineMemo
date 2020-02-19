//
//  MemoDetailVC+UITextView.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/15.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit

extension MemoDetailVC: UITextViewDelegate {
    
    func setMemoDetailTextView(_ textView: UITextView) {
        if self.memoData == nil {
            if textView.text == "내용을 입력해주세요" {
                textView.text = ""
                if #available(iOS 11.0, *) {
                    textView.textColor = UIColor(named: "TextColor")
                } else {
                    textView.textColor = .black
                }
            } else if textView.text == "" {
                textView.text = "내용을 입력해주세요"
                textView.textColor = self.textViewPlaceholderColor
            }
        }
    }
    
    // start editing
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.setMemoDetailTextView(textView)
    }
    
    // end editing
    func textViewDidEndEditing(_ textView: UITextView) {
        self.setMemoDetailTextView(textView)
    }
}
