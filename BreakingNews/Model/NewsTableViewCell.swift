//
//  NewsTableViewCell.swift
//  BreakingNews
//
//  Created by Robert Pinl on 30.01.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    @IBOutlet weak var newsSource: UILabel!
    @IBOutlet weak var view: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        newsImage.layer.cornerRadius = 7
    }
}
