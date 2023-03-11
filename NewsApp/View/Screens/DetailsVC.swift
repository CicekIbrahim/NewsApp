//
//  DetailsVC.swift
//  NewsApp
//
//  Created by Ibrahim Cicek on 9.03.2023.
//

import UIKit

class DetailsVC: UIViewController, NewsViewModelDelegate{
    
    @IBOutlet weak var sectionNameLabel: UILabel!
    @IBOutlet weak var bodyTextLabel: UILabel!
    @IBOutlet weak var webTitleLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var webPublicationDateLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private let viewModel = NewsViewModel()
    var newsId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.bodyTextLabel.sizeToFit()
        viewModel.getNewsDetails(id: newsId)
        viewModel.onFetchCompleted = {
            self.title = self.viewModel.singleNews.webTitle
            self.sectionNameLabel.text = self.viewModel.singleNews.sectionName
            self.bodyTextLabel.text = self.viewModel.singleNews.fields.bodyText
            self.webTitleLabel.text = self.viewModel.singleNews.webTitle
            self.viewModel.thumbnailImage(for: self.viewModel.singleNews) { thumbnailImage in
                self.thumbnailImageView.image = thumbnailImage
            }
            self.webPublicationDateLabel.text = self.viewModel.singleNews.webPublicationDate.toDate()
        }
    }
    
    func didSelectNewsItem(with id: String) {
          self.newsId = id
      }
}
