//
//  TVShowListViewModel.swift
//  TV Shows
//
//  Created by Asif Newaz on 26/2/21.
//

import Foundation
import RxSwift

class TVShowListViewModel {
    
    // MARK: - Inputs

    // MARK: - Outputs

    /// Emits an array of fetched repositories.
    let tvShows: Observable<[TVShowViewModel]>
    
    /// Emits a formatted title for a navigation item.
    let title: Observable<String>
    
    /// Emits an error messages to be shown.
    let alertMessage: Observable<String>
    
    init(initialLanguage: String,apiService: APIService = APIService()) {
        
        let _title = BehaviorSubject<String>(value: initialLanguage)
        
        self.title = _title.asObservable()
            .map { "\($0)" }
        
        let _alertMessage = PublishSubject<String>()
        self.alertMessage = _alertMessage.asObservable()

        self.tvShows = apiService.getAllTVShows()
            .catch { error in
                _alertMessage.onNext(error.localizedDescription)
                return Observable.empty()
            }
            .map { repositories in repositories.map(TVShowViewModel.init) }
    }
}
