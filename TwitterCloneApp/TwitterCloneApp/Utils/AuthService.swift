//
//  AuthService.swift
//  TwitterCloneApp
//
//  Created by Ho bin Lee on 2022/05/02.
//

import UIKit
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    static let shared = AuthService()
    
    func registerUser(_ userinfo:AuthCredentials, completion: @escaping(Error?, DatabaseReference) -> Void) {
        
        // 이미지를 업로드하기위한 데이터로 변환
        guard let imageData = userinfo.profileImage.jpegData(compressionQuality: 0.3) else { return }
        
        // 임의의 128비트 값을 생성하고, 고유의 값을 만드는데 좋다. (항상 값이 다르게 나온다.)
        let fileName = NSUUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGES.child(fileName)
        
        // 이미지 업로드
        storageRef.putData(imageData, metadata: nil) { meta, error in
            
            // 이미지 업로드 후 접근 url 가져옴
            storageRef.downloadURL { url, error in
                
                if let error = error {
                    print("DEBUG: Error is \(error.localizedDescription)")
                    return
                } else {
                    print("DEBUG: Succesfully upload image")
                }
                
                
                guard let profileImageUrl = url?.absoluteString else { return }
                
                // 계정 추가
                Auth.auth().createUser(withEmail: userinfo.email, password: userinfo.password) { result, error in
                    if let error = error {
                        print("DEBUG: Error is \(error.localizedDescription)")
                        return
                    }
                    
                    guard let uid = result?.user.uid else { return }
                    
                    // 사용자의 정보를 딕셔너리로 전달하여 realtime database에 정보를 갱신한다.
                    // 이유는 아직 정확하게 확인하지 못했으나 db의 위치를 us-central1으로 처리해야 정상동작한다. url구조가 조금 상이함.
                    let values = ["email" : userinfo.email,
                                  "username" : userinfo.username,
                                  "fullname" : userinfo.fullname,
                                  "profileImageUrl": profileImageUrl]
                    
                    
                    REF_USERS.child(uid).updateChildValues(values){ error, ref in
                        completion(error, ref)
                    }
                    
                    
                }
            }
        }
        
    }
}
