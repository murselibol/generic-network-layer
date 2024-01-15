//
//  HomeVM.swift
//  generic-network-layer
//
//  Created by Mursel Elibol on 23.11.2023.
//

import Foundation

protocol HomeVMInterface {
    func viewDidLoad()
    func colletionViewWillDisplay(at indexPath: IndexPath)
}

final class HomeVM {
    
    private weak var view: HomeVCInterface?
    private let postService: PostServiceProtocol
    var posts: [Post] = []
    private var page: Int = 1
    private let limit: Int = 2
    var paginationQuery: [URLQueryItem] = [
        URLQueryItem(name: "_page", value: "1"),
        URLQueryItem(name: "_limit", value: "10")
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
    
    func colletionViewWillDisplay(at indexPath: IndexPath) {
        guard indexPath.row == posts.count - 3 else { return }
        if let queryIndex = paginationQuery.firstIndex(where: { $0.name == "_page" }) {
            let currentPage = Int(paginationQuery[queryIndex].value!)! + 1
            paginationQuery[queryIndex].value = String(currentPage)
            getPosts()
        }
    }
}
