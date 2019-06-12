//
//  PostsTableViewCell.swift
//  babylonTest
//
//  Created by Amish Patel on 12/06/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import UIKit

final class PostsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(cellViewModel: PostsCellViewModel) {
        self.titleLabel.text = cellViewModel.getTitle()
    }
    
}
