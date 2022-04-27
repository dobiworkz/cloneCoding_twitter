//
//  LoginController.swift
//  TwitterCloneApp
//
//  Created by Ho bin Lee on 2022/04/26.
//

import UIKit

class LoginController: UIViewController{
    
    // MARK: - Properties
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "TwitterLogo")
        return iv
    }()
    
    private lazy var emailContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x-1")
        let view = Utilities().inputContainerView(withImage: image, textField: emailTextField)
        return view
    }()
    
    private let emailTextField: UITextField = {
        let tf = Utilities().textField(witPlaceholder: "Email")
        return tf
    }()
    
    private lazy var passwordContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: passwordTextField)
        return view
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utilities().textField(witPlaceholder: "Password", isSecret: true)
        return tf
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        
        button.automaticallyUpdatesConfiguration = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        button.addTarget( self, action: #selector(handleLogin), for: .touchUpInside)
        
        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Don't have an account? ", "Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }

    // MARK: - Selectors
    @objc func handleLogin(){
        print(#function)
    }
    
    @objc func handleShowSignUp(){
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }

    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = UIColor.twitterBlue
        
        // 네비게이션 스타일을 검정으로처리, 시간/베터리등의 정보가 하얀색으로 표시 될 수 있도록 처리
        navigationController?.navigationBar.barStyle = .black
        // 네비게이션 영역을 표시하지 않음
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0)
        logoImageView.setDimensions(width: 150, height: 150)
        
        // 스택뷰 생성
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        // 스택뷰 구조를 세로로
        stack.axis = .vertical
        // 스택뷰 내부 간격
        stack.spacing = 20
        // 스택뷰 내부 크기 분배
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 40, paddingRight: 40)
    }

    
}
