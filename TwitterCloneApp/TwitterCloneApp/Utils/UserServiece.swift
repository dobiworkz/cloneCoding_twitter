//
//  UserServiece.swift
//  TwitterCloneApp
//
//  Created by Ho bin Lee on 2022/05/03.
//

import Firebase

struct UserService {
    static let shared = UserService()
    
    func fetchUser(completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        // print(">>>>> DEBUG: current uid is \(uid)")
        
        // realtime database의 해당 uid하위의 정보를 snapshot으로 보여줌
        REF_USERS.child(uid).observeSingleEvent(of: .value) { snapshot in
            // print(">>>>> DEBUG: snapshot \(snapshot)")
            
            // snapshot을 dictionary형태로 변환
            guard let dic = snapshot.value as? [String: AnyObject] else { return }
            // print(">>>>> DEBUG: Dic \(dic)")
            
            guard let username = dic["username"] else { return }

            let user = User(uid: uid, dictionary: dic)

            completion(user)
        }

    }
}
