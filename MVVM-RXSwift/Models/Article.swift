//
//  Article.swift
//  MVVM-RXSwift
//
//  Created by Nitkarsh Gupta on 27/09/20.
//

import Foundation

struct ArticleList: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let title: String?
    let description: String?
    let imageURL: String?
    let navigationURL: String?
    let author: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case imageURL = "urlToImage"
        case navigationURL = "url"
        case author
    }
}
