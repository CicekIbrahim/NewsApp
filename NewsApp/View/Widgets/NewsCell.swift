//
//  NewsCell.swift
//  NewsApp
//
//  Created by Ibrahim Cicek on 9.03.2023.
//

import UIKit

class NewsCell: UITableViewCell {
    
    var newsId: String?
    weak var delegate: NewsViewModelDelegate?
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var sectionNameLabel: UILabel!
    @IBOutlet weak var webPublicationDateLabel: UILabel!
    @IBOutlet weak var webTitleLabel: UILabel!
    @IBOutlet weak var trailTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with newsItem: NewsModel, delegate: NewsViewModelDelegate?) {
            self.delegate = delegate
            newsId = newsItem.id
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            guard let newsId = newsId
            else {return}
            delegate?.didSelectNewsItem(with: newsId)
        }
    }
}
