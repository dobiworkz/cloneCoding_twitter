//
//  MainTabController.swift
//  TwitterCloneApp
//
//  Created by Ho bin Lee on 2022/04/26.
//

import UIKit
import Firebase

// 메인 탭
class MainTabController: UITabBarController {
    
    // MARK: - Properties
    var user: User? {
        didSet{ // user 정보는 로그인, 회원가입후 메인화면으로 접근할때 fetchUser()를 호출할때 셋팅함.
            // MainTabController가 가지고있는 멤버 viewControllers 배열의 첫번째 데이터가 UINavigationController인지
            // 해당 UINavigationContoller의 첫번쨰 스택이 FeedController인지 확인 후 feedController에 user정보를 넣어줌
            guard let nav = viewControllers?[0] as? UINavigationController else { return }
            guard let feed = nav.viewControllers.first as? FeedController else { return }
            
            feed.user = user
        }
    }
    
    // 메인 뷰컨트롤러에서 추가시 각 탭에 추가하기 편함.
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        
        // 버튼 스타일 설정
        button.tintColor = .white
        button.backgroundColor = UIColor.twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //logout()
        view.backgroundColor = .twitterBlue
        
        // 로그인 유무 확인 후 로그인 페이지로 이동
        authenticateUserAndConfigureUI()
        
    }
    
    // MARK: - API
    
    func fetchUser() {
        UserService.shared.fetchUser{ user in
            self.user = user
        }
    }
    
    func authenticateUserAndConfigureUI() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else{
            configureViewControllers()
            configureUI()
            
            fetchUser()
        }
    }
    
    func logout() {
        do{
            try Auth.auth().signOut()
        } catch let error {
            print("DEBUG: failed to logout. \(error)")
        }
    }
    
    // MARK: - Selectors
    @objc func actionButtonTapped(){
        guard let user = user else { return }
        let controller = UploadTweetController(user: user)
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    
    
    // Mark: - Helpers
    
    func configureUI() {
        view.addSubview(actionButton)
        
        // 버튼 위치 수정
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        
        actionButton.clipsToBounds = true
        actionButton.layer.cornerRadius = 56/2
    }
    
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
        //viewControllers = [nav1, nav2, nav3, nav4]
        self.setViewControllers([ nav1, nav2, nav3, nav4 ], animated: true)
        
        // 탭 스타일 설정
        let appearance = UITabBarAppearance()
        
        // 불투명하게
        appearance.configureWithOpaqueBackground()
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.tintColor = UIColor.twitterBlue
        
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
