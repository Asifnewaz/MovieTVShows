//
//  MovieDetailsViewModel.swift
//  TV Shows
//
//  Created by Asif Newaz on 26/2/21.
//

import Foundation
import RxSwift
import UIKit

class MovieDetailsViewModel {

    // MARK: - Inputs
    
    // MARK: - Outputs
    
    /// Emits a formatted title for a navigation item.
    let title: Observable<String>
    let tagLine: Observable<String>
    let overView: Observable<String>
    let genres: Observable<String>
    let popularity: Observable<String>
    var posterPath: Observable<UIImage>
    
    /// Emits an error messages to be shown.
    let alertMessage: Observable<String>
    
    let movie: Movie
    let movieDetails: Observable<MovieDetailsResponse>
    
    init(movie: Movie, apiService: APIService = APIService()) {
        self.movie =  movie
        let _title = BehaviorSubject<String>(value: movie.title ?? "")
        
        self.title = _title.asObservable()
            .map { "\($0)" }
        
        
        let _alertMessage = PublishSubject<String>()
        self.alertMessage = _alertMessage.asObservable()

        self.movieDetails = apiService.getMovieDetails(id: movie.id!)
            .catch { error in
                _alertMessage.onNext(error.localizedDescription)
                return Observable.empty()
            }
        
        self.tagLine = self.movieDetails.asObservable()
            .map{ ($0.tagline ?? "")}
        self.overView = self.movieDetails.asObservable()
            .map{ ($0.overview ?? "")}
        self.genres = self.movieDetails.asObservable()
            .map{ ($0.genres?.first?.name ?? "")}
        self.popularity = self.movieDetails.asObservable()
            .map{
                if let popularity = $0.popularity {
                    return "\(String(describing:  popularity))"
                } else {
                    return ""
                }
            }
        
        let _uiImage = PublishSubject<UIImage>()
        self.posterPath = _uiImage.asObserver()
        self.posterPath = self.movieDetails.asObservable()
            .map {
                if let path = $0.posterPath {
                    if let image = apiService.load(path: path) {
                        return image
                    } else {
                        return UIImage(named: "movieTvDummy")!
                    }
                } else {
                    return UIImage(named: "movieTvDummy")!
                }
            }
    }

}

