//
//  SearchListViewModel.swift
//  TV Shows
//
//  Created by Asif Newaz on 26/2/21.
//

import Foundation
import RxSwift

class SearchListViewModel {
    
    // MARK: - Inputs
    
    // MARK: - Outputs

    /// Emits a formatted title for a navigation item.
    let title: Observable<String>
    
    
    
    
    init(initialLanguage: String, apiService: APIService = APIService()) {
        
        let _title = BehaviorSubject<String>(value: initialLanguage)
        
        self.title = _title.asObservable()
            .map { "\($0)" }
    }
}
