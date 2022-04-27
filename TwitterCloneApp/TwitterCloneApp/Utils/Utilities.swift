//
//  Utilities.swift
//  TwitterCloneApp
//
//  Created by Ho bin Lee on 2022/04/26.
//

import UIKit

class Utilities {
    
    func inputContainerView(withImage image: UIImage, textField: UITextField) -> UIView {
        let view = UIView()
        view.anchor(height: 50)
        
        let iv = UIImageView()
        iv.image = image
        
        view.addSubview(iv)
        iv.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, paddingLeft: 8, paddingBottom: 8)
        iv.setDimensions(width: 24, height: 24)
        
        view.addSubview(textField)
        textField.anchor(left: iv.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, paddingBottom: 8, paddingRight: 8)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        
        view.addSubview(dividerView)
        dividerView.anchor(top: iv.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 2, paddingLeft: 8, paddingRight: 8, height: 0.7)
        
        return view
    }
    
    func textField(witPlaceholder placeholder: String, isSecret: Bool = false) -> UITextField {
        let tf = UITextField()
        tf.textColor = .white
        tf.font = UIFont.systemFont(ofSize: 16)
        // placeholder 색상 설정
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        
        tf.isSecureTextEntry = isSecret
        
        // strong password로 텍스트필드가 묶이는 것을 방지.
        //iOS12부터 패스워드를 자동으로 강력한 패스워드(Strong Password) 타입으로 자동으로 만들 수 (AutoFill) 있는데,
        //강력한 패스워드가 자동으로 생성되면, 해당 내용은 iCloud Keychain 에 저장된다. 문제는 iCloud Keychain에 접근권한이 없어서 발생하는 문제로 파악된다.
        if isSecret, #available(iOS 12.0, *){ tf.textContentType = .oneTimeCode }
        
        return tf
    }
    
    func attributedButton(_ firstPart: String, _ secondPart: String) -> UIButton {
        let button = UIButton(type: .system)
        
        // 버튼의 서식을 다르게 적용하기 위해서 사용
        let attributeTitle = NSMutableAttributedString(string: firstPart, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSMutableAttributedString.Key.foregroundColor: UIColor.white])
        
        attributeTitle.append(NSMutableAttributedString(string: secondPart, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSMutableAttributedString.Key.foregroundColor: UIColor.white]))
        
        button.setAttributedTitle(attributeTitle, for: .normal)
        
        return button
    }
}
