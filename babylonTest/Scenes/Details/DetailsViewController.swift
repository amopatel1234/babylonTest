//
//  DetailsViewController.swift
//  babylonTest
//
//  Created by Amish Patel on 12/06/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import UIKit

final class DetailsViewController: UIViewController {

    private let viewModel: DetailViewModel
    
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var numnberOfCommentsLabel: UILabel!
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.bodyTextView.text = viewModel.bodtText()
        self.authorLabel.text = viewModel.authorOfPost()
        self.numnberOfCommentsLabel.text = viewModel.numberOfComments()
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
