//
//  MovieModel.swift
//  GetFlix
//
//  Created by Mac on 7/24/24.
//

import Foundation

struct MovieModel: Codable {
    let id: Int?
    let backdropPath: String?
    let genres: [String]?
    let originalTitle: String?
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let contentType: String?

    // Coding keys to map JSON keys to Swift property names
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case backdropPath = "backdrop_path"
        case genres
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case contentType
    }
}

struct MovieCategory : Codable{
    let categoryTitle: String
    let movies : [MovieModel]
}
