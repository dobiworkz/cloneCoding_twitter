//
//  FeedController.swift
//  TwitterCloneApp
//
//  Created by Ho bin Lee on 2022/04/26.
//

import UIKit
import SDWebImage

// 피드 탭
class FeedController: UIViewController{
    
    // MARK: - Properties
    var user: User? {
        didSet{ configureLeftBarButton() }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // Mark: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        // 네비게이션바에 로고이미지를 넣을 이미지 뷰를 작성
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        // 이미지뷰의 크기를 조정
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    
    func configureLeftBarButton() {
        guard let user = user else { return }
        
        // 네이게이션 바 촤측에 프로필 이미지뷰 작성
        let proFileImageView = UIImageView()
        
        proFileImageView.backgroundColor = .twitterBlue
        proFileImageView.setDimensions(width: 32, height: 32)
        proFileImageView.layer.cornerRadius = 32 / 2
        proFileImageView.layer.masksToBounds = true
        
        // 이미지 로딩에는 시간이 걸릴 수 있으므로 비동기로 작동해야함. 때문에 SDWebImage를 이용하여 이미지 load
        proFileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: proFileImageView)
    }
    
}
