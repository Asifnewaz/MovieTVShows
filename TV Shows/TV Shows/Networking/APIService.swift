//
//  APIService.swift
//  TV Shows
//
//  Created by Asif Newaz on 26/2/21.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

enum ServiceError: Error {
    case cannotParse
}

/// A service that knows how to perform requests for GitHub data.
class APIService {

    private let session: URLSession
    private var baseURL: String = "https://api.themoviedb.org/3/"
    private var imageBaseURL: String = "https://image.tmdb.org/t/p/w500/"
    private var apiKey: String = "eb8aa6f914f794f711fb1841fb141f12"
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func load(path: String) -> UIImage? {
        if let url = URL(string: imageBaseURL + path), let data = try? Data(contentsOf: url) {
            if let image = UIImage(data: data) {
                return image
            }
        }
        return nil
    }

    /// - Parameter language: Language to filter by
    /// - Returns: A list of most popular movies filtered by langugage
    func getAllMovies(language: String = "en-US", sortBy: MovieSortBy = .popularityDesc, adult: Bool = false, page: String = "1") -> Observable<[Movie]> {
        let encodedLanguage = language.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let endPoint = "discover/movie?api_key=\(apiKey)&language=\(encodedLanguage)&sort_by=\(sortBy.rawValue)&include_adult=\(adult)&include_video=false&page=\(page)"
        let completeURL = baseURL + endPoint
        let url = URL(string: completeURL)!
        let request = URLRequest(url: url)
        return session.rx
            .data(request: request)
            .flatMap { data throws -> Observable<[Movie]> in
                
                do {
                    let movieList = try JSONDecoder().decode(MovieAPIRespose.self, from: data)
                    guard let mvies = movieList.results else {
                        return Observable.error(ServiceError.cannotParse)
                    }
                    print(mvies)
                    return Observable.just(mvies)
                } catch let error {
                    print("\(error.localizedDescription)")
                    return Observable.error(ServiceError.cannotParse)
                }
                
            }
    }
    
    /// - Returns: A list of most popular movies filtered by langugage
    func getMovieDetails(id: Int, language: String = "en-US") -> Observable<MovieDetailsResponse> {
        let encodedLanguage = language.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let endPoint = "movie/\(id)?api_key=\(apiKey)&language=\(encodedLanguage)"
        let completeURL = baseURL + endPoint
        let url = URL(string: completeURL)!
        let request = URLRequest(url: url)
        return session.rx
            .data(request: request)
            .flatMap { data throws -> Observable<MovieDetailsResponse> in
                
                do {
                    let details = try JSONDecoder().decode(MovieDetailsResponse.self, from: data)
                    print(details)
                    return Observable.just(details)
                } catch let error {
                    print("\(error.localizedDescription)")
                    return Observable.error(ServiceError.cannotParse)
                }
                
            }
    }
    
    
    /// - Parameter language: Language to filter by
    /// - Returns: A list of most popular tv shows filtered by langugage
    func getAllTVShows(language: String = "en-US", sortBy: MovieSortBy = .popularityDesc, adult: Bool = false, page: String = "1") -> Observable<[TVShow]> {
        let encodedLanguage = language.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let endPoint = "discover/tv?api_key=\(apiKey)&language=\(encodedLanguage)&sort_by=\(sortBy.rawValue)&page=\(page)&timezone=America%2FNew_York&include_null_first_air_dates=false"
        let completeURL = baseURL + endPoint
        let url = URL(string: completeURL)!
        let request = URLRequest(url: url)
        return session.rx
            .data(request: request)
            .flatMap { data throws -> Observable<[TVShow]> in
                
                do {
                    let tvShows = try JSONDecoder().decode(TVShowAPIResponse.self, from: data)
                    guard let shows = tvShows.results else {
                        return Observable.error(ServiceError.cannotParse)
                    }
                    return Observable.just(shows)
                } catch let error {
                    print("\(error.localizedDescription)")
                    return Observable.error(ServiceError.cannotParse)
                }
                
            }
    }
    
    
    /// - Returns: A list of most popular movies filtered by langugage
    func getTvShowDetails(id: Int, language: String = "en-US") -> Observable<TVShowDetailsResponse> {
        let encodedLanguage = language.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let endPoint = "tv/\(id)?api_key=\(apiKey)&language=\(encodedLanguage)"
        let completeURL = baseURL + endPoint
        let url = URL(string: completeURL)!
        let request = URLRequest(url: url)
        return session.rx
            .data(request: request)
            .flatMap { data throws -> Observable<TVShowDetailsResponse> in
                
                do {
                    let details = try JSONDecoder().decode(TVShowDetailsResponse.self, from: data)
                    print(details)
                    return Observable.just(details)
                } catch let error {
                    print("\(error.localizedDescription)")
                    return Observable.error(ServiceError.cannotParse)
                }
                
            }
    }
    
    //MARK:- Search Movies
    func searchMovies(searchString: String,language: String = "en-US",adult: Bool = false, page: String = "1") -> Observable<[Movie]> {
        let encodedSearch = searchString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let endPoint = "search/movie?api_key=\(apiKey)&language=\(language)&query=\(encodedSearch)&page=\(page)&include_adult=\(adult)"
        let completeURL = baseURL + endPoint
        let url = URL(string: completeURL)!
        let request = URLRequest(url: url)
        return session.rx
            .data(request: request)
            .flatMap { data throws -> Observable<[Movie]> in
                
                do {
                    let movieList = try JSONDecoder().decode(MovieAPIRespose.self, from: data)
                    guard let mvies = movieList.results else {
                        return Observable.error(ServiceError.cannotParse)
                    }
                    return Observable.just(mvies)
                } catch let error {
                    print("\(error.localizedDescription)")
                    return Observable.error(ServiceError.cannotParse)
                }
                
            }
    }
    
    func searchTvShows(searchString: String,language: String = "en-US",adult: Bool = false, page: String = "1") -> Observable<[TVShow]> {
        let encodedSearch = searchString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let endPoint = "search/tv?api_key=\(apiKey)&language=\(language)&query=\(encodedSearch)&page=\(page)&include_adult=\(adult)"
        let completeURL = baseURL + endPoint
        let url = URL(string: completeURL)!
        let request = URLRequest(url: url)
        return session.rx
            .data(request: request)
            .flatMap { data throws -> Observable<[TVShow]> in
                
                do {
                    let movieList = try JSONDecoder().decode(TVShowAPIResponse.self, from: data)
                    guard let mvies = movieList.results else {
                        return Observable.error(ServiceError.cannotParse)
                    }
                    return Observable.just(mvies)
                } catch let error {
                    print("\(error.localizedDescription)")
                    return Observable.error(ServiceError.cannotParse)
                }
                
            }
    }
}
