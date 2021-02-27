//
//  MovieListViewModel.swift
//  TV Shows
//
//  Created by Asif Newaz on 26/2/21.
//

import Foundation
import RxSwift

class MovieListViewModel {

    // MARK: - Inputs
    let selectMovieDetails: AnyObserver<MovieViewModel>
    
    // MARK: - Outputs
    /// Emits an array of fetched repositories.
    let movies: Observable<[MovieViewModel]>
    
    /// Emits a formatted title for a navigation item.
    let title: Observable<String>
    
    /// Emits an error messages to be shown.
    let alertMessage: Observable<String>
    
    /// Emits an url of repository page to be shown.
    let showMovieDetails: Observable<Movie?>
    
    
    init(initialLanguage: String, apiService: APIService = APIService()) {
        
        let _title = BehaviorSubject<String>(value: initialLanguage)
        
        self.title = _title.asObservable()
            .map { "\($0)" }
        
        let _alertMessage = PublishSubject<String>()
        self.alertMessage = _alertMessage.asObservable()
        
        self.movies = apiService.getAllMovies()
            .catch { error in
                _alertMessage.onNext(error.localizedDescription)
                return Observable.empty()
            }
            .map { repositories in repositories.map(MovieViewModel.init) }
       
        let _selectMovieDetails = PublishSubject<MovieViewModel>()
        self.selectMovieDetails = _selectMovieDetails.asObserver()
        self.showMovieDetails = _selectMovieDetails.asObservable().map { $0.movie }
    }
}
