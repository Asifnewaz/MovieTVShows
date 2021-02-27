//
//  TVShow.swift
//  TV Shows
//
//  Created by Asif Newaz on 26/2/21.
//

import Foundation

struct TVShowAPIResponse: Codable {
    var page: Int?
    var results: [TVShow]?
    var totalResults: Int?
    var totalPages: Int?

    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

// MARK: - Result
struct TVShow: Codable {
    var posterPath: String?
    var popularity: Double?
    var id: Int?
    var backdropPath: String?
    var voteAverage: Double?
    var overview: String?
    var firstAirDate: String?
    var originCountry: [String]?
    var genreIDS: [Int]?
    var originalLanguage: String?
    var voteCount: Int?
    var name: String?
    var originalName: String?

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case popularity = "popularity"
        case id = "id"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case overview = "overview"
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case voteCount = "vote_count"
        case name = "name"
        case originalName = "original_name"
    }
}
