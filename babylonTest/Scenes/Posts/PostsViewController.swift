//
//  PostsViewController.swift
//  babylonTest
//
//  Created by Amish Patel on 07/06/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {

    private let viewModel: PostsViewModel
    
    @IBOutlet weak var tableView: UITableView!
    
    init(viewModel: PostsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "PostsTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "PostsCell")
        
        viewModel.hasLoadedAllData = { [weak self] (hasPost, hasUsers, hasComments) in
            if hasPost && hasUsers && hasComments {
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
        
        viewModel.requestDataLoad()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostsCell", for: indexPath) as? PostsTableViewCell else {return UITableViewCell(style: .default, reuseIdentifier: nil)}
        
        cell.configureCell(cellViewModel: viewModel.cellViewModel(forIndexRow: indexPath.row))
        
        return cell
    }
    
    
}

extension PostsViewController: UITableViewDelegate {
    
}
