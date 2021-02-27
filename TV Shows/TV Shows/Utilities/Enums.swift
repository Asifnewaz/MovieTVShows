//
//  Enums.swift
//  TV Shows
//
//  Created by Asif Newaz on 26/2/21.
//

import Foundation

enum UIUserInterfaceIdiom : Int {
    case unspecified
    
    case phone // iPhone and iPod touch style UI
    case pad   // iPad style UI (also includes macOS Catalyst)
}

enum MovieSortBy : String {
    case popularityDesc = "popularity.desc"
    case popularityAsc = "popularity.asc"
    case releaseDateAsc = "release_date.asc"
    case releaseDateDesc = "release_date.desc"
    case revenueAsc = "revenue.asc"
    case revenueDesc = "revenue.desc"
}

enum SearchError: Error {
    case underlyingError(Error)
    case notFound
    case unkowned
}
