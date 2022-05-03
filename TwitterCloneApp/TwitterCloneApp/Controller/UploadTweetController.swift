//
//  UploadTweetController.swift
//  TwitterCloneApp
//
//  Created by Ho bin Lee on 2022/05/03.
//

import UIKit

class UploadTweetController: UIViewController {
    // MARK: - Properties
    private let user: User
    
    private lazy var  actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .twitterBlue
        button.setTitle("Tweet", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        
        button.frame = CGRect(x: 0, y: 0, width: 64, height: 32 )
        button.layer.cornerRadius = 32 / 2
        button.layer.masksToBounds = true
        
        button.addTarget(self, action: #selector(handleUploadTweet), for: .touchUpInside)
        
        return button
    }()
    
    private let profileIamgaeView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.setDimensions(width: 48, height: 48)
        iv.layer.cornerRadius = 48 / 2
        iv.clipsToBounds = true
        
        iv.backgroundColor = .twitterBlue
        
        return iv
    }()
    
    private let captionTextView = CaptionTextView()

    // MARK: - LifeCycle
    init(user: User){
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    // MARK: - Selectors
    
    @objc func handleCancel() {
        dismiss(animated: true)
    }
    
    @objc func handleUploadTweet() {
        guard let caption = captionTextView.text else { return }
        
        TweetService.shared.uploadTweet(caption: caption) { error, ref in
            if let error = error {
                print(">>>>> DEBUG: Tweet upload error! \(error.localizedDescription)")
                return
            }
            
            dismiss(animated: true)
        }

    }
    

    // MARK: - API

    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        configureNavigationBar()
        
        let stack = UIStackView( arrangedSubviews: [profileIamgaeView, captionTextView])
        stack.axis = .horizontal
        stack.spacing = 12
        
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                     left: view.leftAnchor,
                     right: view.rightAnchor,
                     paddingTop: 16,
                     paddingLeft: 16,
                     paddingRight: 16)
        // 이미지 정보가 캐싱되어있음.
        profileIamgaeView.sd_setImage(with: user.profileImageUrl, completed: nil)
    }
    
    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground() // 불투명하게

        // 네비게이션에 스타일 적용
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
    }


}
