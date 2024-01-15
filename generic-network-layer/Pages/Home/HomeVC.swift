//
//  HomeVC.swift
//  generic-network-layer
//
//  Created by Mursel Elibol on 23.11.2023.
//

import UIKit

protocol HomeVCInterface: AnyObject {
    func configurationUserTable()
    func postTableReload()
}


class HomeVC: UIViewController {
    
    @IBOutlet weak var postTableView: UITableView!
    
    lazy var viewModel = HomeVM(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
    }
}

// MARK: - HomeVCInterface
extension HomeVC: HomeVCInterface {
    func configurationUserTable() {
        postTableView.dataSource = self
        postTableView.delegate = self
    }
    
    func postTableReload() {
        DispatchQueue.main.async {
            self.postTableView.reloadData()
        }
    }
}

// MARK: - UITableView
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let posts = viewModel.posts
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = "\(indexPath.row + 1) - \(posts[indexPath.row].title ?? "")"
        content.secondaryText = posts[indexPath.row].body
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UserDetailVC(id: viewModel.posts[indexPath.row].id!)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.colletionViewWillDisplay(at: indexPath)
    }
}
