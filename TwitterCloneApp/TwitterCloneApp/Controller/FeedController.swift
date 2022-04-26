//
//  FeedController.swift
//  TwitterCloneApp
//
//  Created by Ho bin Lee on 2022/04/26.
//

import UIKit

// 피드 탭
class FeedController: UIViewController{
    
    // MARK: - Properties
    
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

}
