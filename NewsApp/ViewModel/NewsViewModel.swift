//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Ibrahim Cicek on 9.03.2023.
//

import AlamofireImage
import Alamofire

class NewsViewModel{
    
    
    weak var delegate: NewsViewModelDelegate?
    private let newsAPI = NewsAPI()
    var placeholderUrl = "https://dogruer.com/wp-content/themes/consultix/images/no-image-found-360x260.png"
    var newsList: [NewsModel] = []
    var singleNews: NewsModel = NewsModel(id: "", sectionName: "", webTitle: "", webPublicationDate: "", fields: Fields(trailText: nil, thumbnail: "", bodyText: ""))
    var onFetchCompleted: (() -> Void)?
    var onFetchFailed: ((Error) -> Void)?
    var currentPage = 1
    var newsId: String?
    
    func didSelectNewsItem(with id: String) {
        self.newsId = id
    }
    
    func fetchNews() {
        newsAPI.getNews(page: currentPage) { result in
            switch result {
            case .success(let newsList):
                self.newsList = newsList
                self.onFetchCompleted?()
            case .failure(let error):
                self.onFetchFailed?(error)
            }
        }
    }
    
    func getNewsDetails(id: String) {
        newsAPI.getSingleNew(id: id) { result in
            switch result {
            case .success(let singleNews):
                self.singleNews = singleNews
                self.onFetchCompleted?()
            case .failure(let error):
                print(error)
                self.onFetchFailed?(error)
            }
        }
    }
    
    func loadMoreNews() {
        currentPage += 1
        newsAPI.getNews(page: currentPage) { result in
            switch result {
            case .success(let moreNews):
                self.newsList = self.newsList + moreNews
                self.onFetchCompleted?()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func thumbnailImage(for newsItem: NewsModel, completion: @escaping (UIImage?) -> Void) {
        guard let thumbnailUrl = URL(string: newsItem.fields.thumbnail ?? placeholderUrl) else {
            completion(nil)
            return
            
        }
        AF.request(thumbnailUrl).responseImage { response in
            completion(response.value)
        }
    }
}

protocol NewsViewModelDelegate: AnyObject {
    func didSelectNewsItem(with id: String)
}
