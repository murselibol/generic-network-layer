//
//  UserDetailVC.swift
//  generic-network-layer
//
//  Created by Mursel Elibol on 23.11.2023.
//

import UIKit

protocol UserDetailVCInterface: AnyObject {
    var userId: Int { get }
    
    func configureUserData(user: User)
    func showAlert(title: String, message: String?)
}


class UserDetailVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!
    
    var userId: Int
    lazy var viewModel = UserDetailVM(view: self)
    
    
    init(id: Int) {
        self.userId = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
    }
    
    @IBAction func onSubmitPostForm(_ sender: UIButton) {
        let form = PostReq(
            title: titleLabel.text ?? "",
            body: bodyTextField.text ?? "",
            userId: userId
        )
        
        viewModel.createPost(form: form)
    }
    
    
}

// MARK: - UserDetailVCInterface
extension UserDetailVC: UserDetailVCInterface {
    func configureUserData(user: User) {
        DispatchQueue.main.async {
            self.titleLabel.text = user.name
        }
    }
    
    func showAlert(title: String, message: String?) {
        DispatchQueue.main.async {
            self.alert(title: title, message: message)
        }
    }
}
