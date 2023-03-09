//
//  NewsModel.swift
//  NewsApp
//
//  Created by Ibrahim Cicek on 9.03.2023.
//

import Foundation


struct NewsModel: Decodable {
    let id: String
    let sectionName: String
    let webTitle: String
    let webPublicationDate: String
    let fields: Fields
}

struct Fields: Decodable {
    let trailText: String?
    let thumbnail: String?
    let bodyText: String?
}

