//
//  SearchViewModel.swift
//  TV Shows
//
//  Created by Asif Newaz on 27/2/21.
//

import Foundation

struct SearchViewModel {
    let info: (name:String, data: Any)
  
    
    init(mvi: Movie)  {
        self.info.name = mvi.title ?? ""
        self.info.data = mvi
    }
}
