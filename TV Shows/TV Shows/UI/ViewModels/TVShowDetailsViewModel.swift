//
//  TVShowDetailsViewModel.swift
//  TV Shows
//
//  Created by Asif Newaz on 27/2/21.
//

import Foundation
import RxSwift
import UIKit

class TVShowDetailsViewModel {

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
    let show: TVShow
    let showDetails: Observable<TVShowDetailsResponse>
    
    init(show: TVShow, apiService: APIService = APIService()) {
        self.show =  show
        let _title = BehaviorSubject<String>(value: show.name ?? "")
        
        self.title = _title.asObservable()
            .map { "\($0)" }
        
        let _alertMessage = PublishSubject<String>()
        self.alertMessage = _alertMessage.asObservable()
        
        self.showDetails = apiService.getTvShowDetails(id: show.id!)
            .catch { error in
                _alertMessage.onNext(error.localizedDescription)
                return Observable.empty()
            }
        
        self.tagLine = self.showDetails.asObservable()
            .map{ ($0.tagline ?? "")}
        self.overView = self.showDetails.asObservable()
            .map{ ($0.overview ?? "")}
        self.genres = self.showDetails.asObservable()
            .map{ ($0.genres?.first?.name ?? "")}
        self.popularity = self.showDetails.asObservable()
            .map{
                if let popularity = $0.popularity {
                    return "\(String(describing:  popularity))"
                } else {
                    return ""
                }
            }
        
        let _uiImage = PublishSubject<UIImage>()
        self.posterPath = _uiImage.asObserver()
        self.posterPath = self.showDetails.asObservable()
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
