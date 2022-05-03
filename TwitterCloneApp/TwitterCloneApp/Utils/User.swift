//
//  User.swift
//  TwitterCloneApp
//
//  Created by Ho bin Lee on 2022/05/03.
//

import Foundation

struct User {
    let fullname: String
    let email: String
    let username: String
    var profileImageUrl: URL?
    let uid: String
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        
        // profileImageUrl은 String이므로 URL형태로 만들어서 모델을 사용하는 쪽에서 편하게 사용할 수 있도록 초기화
        if let profileImageUrl = dictionary["profileImageUrl"] as? String{
            guard let url = URL(string: profileImageUrl) else { return }
            self.profileImageUrl = url
        }
    }
}
