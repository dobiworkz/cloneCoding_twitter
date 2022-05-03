//
//  CaptionTextView.swift
//  TwitterCloneApp
//
//  Created by Ho bin Lee on 2022/05/03.
//

import UIKit

class CaptionTextView: UITextView {
    
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.text = "What's happening?"
        return label
    }()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        backgroundColor = .white
        font = UIFont.systemFont(ofSize: 16)
        isScrollEnabled = false
        heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        addSubview(placeholderLabel)
        // ViewController가 아닌 View이므로 앵커에 바로 접근 가능
        placeholderLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 4)
        
        // 타이핑이 일어나면 placeholderLabel을 보이지 않게 처리하기 위함
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors

    @objc func handleTextInputChange() {
        // 여기서 text는 UIViewText에 text
        placeholderLabel.isHidden = !text.isEmpty

    }
}
