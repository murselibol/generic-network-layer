//
//  UserDetailVM.swift
//  generic-network-layer
//
//  Created by Mursel Elibol on 23.11.2023.
//

import Foundation

protocol UserDetailVMInterface {
    func viewDidLoad()
    func createPost(form: PostReq)
}

final class UserDetailVM {
    
    private weak var view: UserDetailVCInterface?
    private let userService: UserServiceProtocol
    private let postService: PostServiceProtocol
    var user: User?
    
    
    init(view: UserDetailVCInterface,
         userService: UserServiceProtocol = UserService.shared,
         postService: PostServiceProtocol = PostService.shared
    ) {
        self.view = view
        self.userService = userService
        self.postService = postService
    }
    
    // MARK: - HTTP Requests
    func getUser(id: Int) {
        userService.getUser(id: id) { result in
            switch result {
            case .success(let data):
                self.user = data
                self.view?.configureUserData(user: self.user!)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

// MARK: - UserDetailVMInterface
extension UserDetailVM: UserDetailVMInterface {
    func viewDidLoad() {
        guard let view = self.view else { return }
        self.getUser(id: view.userId)
    }
    
    func createPost(form: PostReq) {
        postService.create(body: form) { result in
            switch result {
            case .success(let data):
                print("Success: ", data)
                self.view?.showAlert(title: "Success", message: data.title)
            case .failure(let error):
                print(error.localizedDescription)
                self.view?.showAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }
}
