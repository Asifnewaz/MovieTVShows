//
//  TVShowViewModel.swift
//  TV Shows
//
//  Created by Asif Newaz on 26/2/21.
//

import RxSwift
import UIKit

struct TVShowViewModel {
    let fullName: String?
    let description: String?
    let id: Int?
    let tvShow: TVShow?
    var posterPath: Observable<UIImage>
    
    init(show: TVShow) {
        self.fullName = show.name
        self.description = show.overview
        self.id = show.id
        self.tvShow = show
        
        let _mvi = BehaviorSubject<TVShow>(value: show)
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
