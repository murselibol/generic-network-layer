//
//  HomeVM.swift
//  generic-network-layer
//
//  Created by Mursel Elibol on 23.11.2023.
//

import Foundation

protocol HomeVMInterface {
    func viewDidLoad()
    func pullToGetPosts()
}

final class HomeVM {
    
    private weak var view: HomeVCInterface?
    private let postService: PostServiceProtocol
    var posts: [Post] = []
    private var page: Int = 1
    private let limit: Int = 2
    var paginationQuery: [String: String] = [
        "_page": "1",
        "_limit": "10",
    ]
    
    
    init(view: HomeVCInterface, postService: PostServiceProtocol = PostService.shared) {
        self.view = view
        self.postService = postService
    }
    
    // MARK: - HTTP Requests
    func getPosts() {
        postService.getPosts(queryItems: paginationQuery) { result in
            switch result {
            case .success(let data):
                self.posts.append(contentsOf: data)
                self.view?.postTableReload()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

// MARK: - HomeVMInterface
extension HomeVM: HomeVMInterface {
    func viewDidLoad() {
        view?.configurationUserTable()
        self.getPosts()
    }
    
    func pullToGetPosts() {
        if let currentPage = paginationQuery["_page"] {
            paginationQuery["_page"] = String(Int(currentPage)! + 1)
            getPosts()
        }
    }
}
