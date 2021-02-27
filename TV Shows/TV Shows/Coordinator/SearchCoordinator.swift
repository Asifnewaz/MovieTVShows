//
//  SearchCoordinator.swift
//  TV Shows
//
//  Created by Asif Newaz on 26/2/21.
//

import UIKit
import RxSwift

class SearchCoordinator: BaseCoordinator<Void> {

    var viewController: SearchViewController
    var rootViewController: UINavigationController
    var tag: Int
    
    init(tag: Int) {
        self.tag = tag
        viewController = SearchViewController.initFromStoryboard(name: "Main")
        rootViewController = UINavigationController(rootViewController: viewController)
    }
    
    override func start() -> Observable<Void> {
        let viewModel = SearchListViewModel(initialLanguage: "Search")
        viewController.viewModel = viewModel
        return Observable.never()
    }
    
    func showMovieDetails(_ movie: Movie?) -> Observable<Void> {
        guard let mvi = movie  else {
            return Observable.never()
        }
        let movieDetailsCoordinator = MovieDetailsCoordinator(rootViewController: rootViewController.viewControllers[0], movie: mvi)
        return coordinate(to: movieDetailsCoordinator)
    }
    
    func showTVShowsDetails(_ show: TVShow?) -> Observable<Void> {
        guard let tvShow = show  else {
            return Observable.never()
        }
        let tvShowDetailsCoordinator = TVShowDetailsCoordinator(rootViewController: rootViewController.viewControllers[0], show: tvShow)
        return coordinate(to: tvShowDetailsCoordinator)
    }
}
