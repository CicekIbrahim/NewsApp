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
    var newID = ""
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
                print(errorMessage)
            }
            viewModel.fetchNews()
        }
   
    func didSelectNewsItem(with newsId: String) {
        let detailsVC = DetailsVC()
        detailsVC.didSelectNewsItem(with: newsId)
        self.newID = newsId
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC"{
            let destinationVC = segue.destination as! DetailsVC
            destinationVC.newsId = newID
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsCell
        let newsItem = viewModel.newsList[indexPath.row]
        cell.sectionNameLabel.text = newsItem.sectionName
        cell.webTitleLabel.text = newsItem.webTitle
        cell.trailTextLabel.text = newsItem.fields.trailText
        cell.webPublicationDateLabel.text = newsItem.webPublicationDate.toDate()
        viewModel.thumbnailImage(for: newsItem) { thumbnailImage in
            cell.thumbnailImageView.image = thumbnailImage
        }
        if indexPath.row == viewModel.newsList.count - 1 {
            viewModel.loadMoreNews()
            newsTableView.reloadData()
            print(viewModel.newsList.count)
            }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectNewsItem(with: viewModel.newsList[indexPath.row].id)
    }
}
   

extension String {
    func toDate() -> String? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd-MM-yyyy"

        if let date = dateFormatterGet.date(from: self) {
            return dateFormatterPrint.string(from: date)
        } else {
            return nil
        }
    }
}
