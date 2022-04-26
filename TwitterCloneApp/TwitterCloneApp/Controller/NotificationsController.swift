//
//  NotificationsController.swift
//  TwitterCloneApp
//
//  Created by Ho bin Lee on 2022/04/26.
//

import UIKit

// 알림 탭
class NotificationsController: UIViewController{
    
    // MARK: - Properties
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    // Mark: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        // 네비게이션 바에 타이틀 표기
        navigationItem.title = "Notifications"
    }


}
