//
//  MovieViewModel.swift
//  TV Shows
//
//  Created by Asif Newaz on 26/2/21.
//
import RxSwift
import UIKit

struct MovieViewModel {
    let fullName: String?
    let description: String?
    let id: Int?
    let movie: Movie?
    var posterPath: Observable<UIImage>
    
    init(movie: Movie) {
        self.fullName = movie.title
        self.description = movie.overview
        self.id = movie.id
        self.movie = movie
        
        let _mvi = BehaviorSubject<Movie>(value: movie)
        let _uiImage = PublishSubject<UIImage>()
        self.posterPath = _uiImage.asObserver()
        self.posterPath = _mvi.asObservable()
            .map {
                if let path = $0.posterPath {
                    if let image = APIService().load(path: path) {
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
