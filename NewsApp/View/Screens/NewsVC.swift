//
//  NewsVC.swift
//  NewsApp
//
//  Created by Ibrahim Cicek on 9.03.2023.
//

import UIKit

class NewsVC: UIViewController , UITableViewDelegate, UITableViewDataSource, NewsViewModelDelegate{
    
    @IBOutlet weak var newsTableView: UITableView!
    
    private let viewModel = NewsViewModel()
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            viewModel.delegate = self
            newsTableView.delegate = self
            newsTableView.dataSource = self
            title = "News"
            
            viewModel.onFetchCompleted = {
                self.newsTableView.reloadData()
            }
            viewModel.onFetchFailed = { errorMessage in
                let alertController = UIAlertController(title: "Error", message: errorMessage.localizedDescription, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default)
                alertController.addAction(okAction)
                self.present(alertController, animated: true)
            }
            viewModel.fetchNews()
        }
   
    func didSelectNewsItem(with newsId: String) {
        let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsVC
        detailsVC.didSelectNewsItem(with: newsId)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        newsTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "newsCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsCell
        let newsItem = viewModel.newsList[indexPath.row]
        cell.sectionNameLabel.text = newsItem.sectionName
        cell.webTitleLabel.text = newsItem.webTitle
        cell.trailTextLabel.text = newsItem.fields.trailText
        cell.webPublicationDateLabel.text = newsItem.webPublicationDate.toDate()
        viewModel.thumbnailImage(for: newsItem) { thumbnailImage in
            cell.thumbnailImageView.image = thumbnailImage
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.newsList.count - 1 {
            viewModel.loadMoreNews()
            }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectNewsItem(with: viewModel.newsList[indexPath.row].id)
    }
}
   

