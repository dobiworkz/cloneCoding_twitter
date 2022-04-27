//
//  RegistrationController.swift
//  TwitterCloneApp
//
//  Created by Ho bin Lee on 2022/04/26.
//

import UIKit

class RegistrationController: UIViewController{
    
    // MARK: - Properties
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)
        
        return button
    }()
    
    private let imagePicker = UIImagePickerController()
    
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
    
    private lazy var fullNameContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_person_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: fullNameTextField)
        return view
    }()
    
    private let fullNameTextField: UITextField = {
        let tf = Utilities().textField(witPlaceholder: "Full Name")
        return tf
    }()
    
    private lazy var userNameContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_person_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: userNameTextField)
        return view
    }()
    
    private let userNameTextField: UITextField = {
        let tf = Utilities().textField(witPlaceholder: "User Name")
        return tf
    }()
    
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        
        button.automaticallyUpdatesConfiguration = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        button.addTarget( self, action: #selector(signUp), for: .touchUpInside)
        
        return button
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Already have an account? ", "Log in")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()


    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }

    // MARK: - Selectors
    
    @objc func handleAddProfilePhoto() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func handleShowLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func signUp() {
        print(#function)
    }


    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = UIColor.twitterBlue
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0)
        plusPhotoButton.setDimensions(width: 128, height: 128)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, fullNameContainerView, userNameContainerView, signUpButton])
        // 스택뷰 구조를 세로로
        stack.axis = .vertical
        // 스택뷰 내부 간격
        stack.spacing = 20
        // 스택뷰 내부 크기 분배
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 40, paddingRight: 40)
    }

    
}

extension RegistrationController: UIImagePickerControllerDelegate {
    // 이미지 선택을 위한 메소드 정의
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else { return }
        
        // image에 렌더링을 해줘야 이미지 셋티잉 완료됨
        self.plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        
        plusPhotoButton.layer.cornerRadius = 128/2
        plusPhotoButton.layer.masksToBounds = true
        
        plusPhotoButton.imageView?.contentMode = .scaleToFill
        plusPhotoButton.imageView?.clipsToBounds = true
        
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 3
        
        dismiss(animated: true, completion: nil)
    }
}

extension RegistrationController: UINavigationControllerDelegate {
    
}
