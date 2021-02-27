//
//  MovieDetailsCoordinator.swift
//  TV Shows
//
//  Created by Asif Newaz on 26/2/21.
//

import UIKit
import RxSwift

class MovieDetailsCoordinator: BaseCoordinator<Void> {

    private let rootViewController: UIViewController
    var viewController: MovieDetailsViewController
    private let movie: Movie
    
    init(rootViewController: UIViewController, movie: Movie) {
        self.rootViewController = rootViewController
        self.movie = movie
        viewController = MovieDetailsViewController.initFromStoryboard(name: "Main")
    }
    
    override func start() -> Observable<Void> {
        let viewModel = MovieDetailsViewModel(movie: movie)
        viewController.viewModel = viewModel
        rootViewController.navigationController?
            .pushViewController(viewController, animated: true)
        return Observable.never()
    }
}
