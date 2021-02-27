//
//  MovieListCoordinator.swift
//  TV Shows
//
//  Created by Asif Newaz on 26/2/21.
//

import UIKit
import RxSwift

class MovieListCoordinator: BaseCoordinator<Void> {

    var viewController: MovieListController
    var rootViewController: UINavigationController
    var tag: Int
    
    init(tag: Int) {
        self.tag = tag
        viewController = MovieListController.initFromStoryboard(name: "Main")
        rootViewController = UINavigationController(rootViewController: viewController)
    }
    
    override func start() -> Observable<Void> {
        let viewModel = MovieListViewModel(initialLanguage: "Discover Movies")
        viewController.viewModel = viewModel
        viewController.movieListCoordinator = self

//        viewModel.showMovieDetails
//            .subscribe(onNext: { [weak self] in _ = self?.showMovieDetails($0)})
//            .disposed(by: disposeBag)
        
        return Observable.never()
    }
    
    func showMovieDetails(_ movie: Movie?) -> Observable<Void> {
        guard let mvi = movie  else {
            return Observable.never()
        }
        let movieDetailsCoordinator = MovieDetailsCoordinator(rootViewController: rootViewController.viewControllers[0], movie: mvi)
        return coordinate(to: movieDetailsCoordinator)
    }
}
