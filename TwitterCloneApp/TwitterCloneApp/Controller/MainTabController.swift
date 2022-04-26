//
//  MainTabController.swift
//  TwitterCloneApp
//
//  Created by Ho bin Lee on 2022/04/26.
//

import UIKit

// 메인 탭
class MainTabController: UITabBarController {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewControllers()
    }
    
    // Mark: - Helpers
    
    func configureViewControllers() {
        
        let feed = FeedController()
        let nav1 = templateNavigationController(image: UIImage(named: "home_unselected"), rootViewContoller: feed)
        
        let explore = ExploreController()
        let nav2 = templateNavigationController(image: UIImage(named: "search_unselected"), rootViewContoller: explore)
        
        let notifications = NotificationsController()
        let nav3 = templateNavigationController(image: UIImage(named: "like_unselected"), rootViewContoller: notifications)
        
        let conversations = ConversationsController()
        let nav4 = templateNavigationController(image: UIImage(named: "ic_mail_outline_white_2x-1"), rootViewContoller: conversations)
        
        // 탭 구성하기
        viewControllers = [nav1, nav2, nav3, nav4]
        
        // 탭 스타일 설정
        let appearance = UITabBarAppearance()
        
        // 불투명하게
        appearance.configureWithOpaqueBackground()
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        
    }
    
    func templateNavigationController( image: UIImage?, rootViewContoller: UIViewController) -> UINavigationController{
        let nav = UINavigationController(rootViewController: rootViewContoller)
        
        // 탭에 이미지 넣기
        nav.tabBarItem.image = image
        
        // 네비게이션 스타일 설정
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        //appearance.backgroundColor = .brown     // 색상설정
        //appearance.configureWithTransparentBackground()  // 투명으로
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.compactAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = appearance
        
        //nav.modalPresentationStyle = .fullScreen
        
        return nav
    }

}
