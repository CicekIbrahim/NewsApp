//
//  NewsAPI.swift
//  NewsApp
//
//  Created by Ibrahim Cicek on 9.03.2023.
//

import Alamofire

struct NewsAPI {
    
    private let apiKey = "2abd7b89-5abc-4d96-a493-8a5bfd0dcff6"
    private let baseUrl = "https://content.guardianapis.com/search"
    private let singleBaseUrl = "https://content.guardianapis.com/"
    
    func getNews(page: Int,completion: @escaping (Result<[NewsModel], Error>) -> Void) {
        let parameters: [String: Any] = [
            "api-key": apiKey,
            "show-fields":"thumbnail,trailText",
            "page-size": 10,
            "page": page
            
        ]
        AF.request(baseUrl, parameters: parameters).validate().responseDecodable(of: NewsResponse.self) { response in
            switch response.result {
                       case .success(let newsResponse):
                completion(.success(newsResponse.response.results))
                       case .failure(let error):
                           completion(.failure(error))
                       }
        }
    }
    
    func getSingleNew(id: String,completion: @escaping (Result<NewsModel, Error>) -> Void) {
        let parameters: [String: Any] = [
            "api-key": apiKey,
            "show-fields":"bodyText,thumbnail,webTitle",
        ]
        AF.request("https://content.guardianapis.com/\(id)", parameters: parameters).validate().responseDecodable(of: SingleNewResponse.self) { response in
            switch response.result {
                       case .success(let newsResponse):
                completion(.success(newsResponse.response.content))
                       case .failure(let error):
                           completion(.failure(error))
                       }
        }
    }
}

struct NewsResponse: Decodable {
    let response: Response
}

struct SingleNewResponse: Decodable {
    let response: SingleResponse
}

struct Response: Decodable {
    let currentPage : Int?
    let results: [NewsModel]
}

struct SingleResponse: Decodable {
    let status: String
    let content: NewsModel
}

