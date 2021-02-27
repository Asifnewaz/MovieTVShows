//
//  TVShowListCoordinator.swift
//  TV Shows
//
//  Created by Asif Newaz on 26/2/21.
//

import UIKit
import RxSwift

class TVShowListCoordinator: BaseCoordinator<Void> {

    var viewController: TVShowListController
    var rootViewController: UINavigationController
    var tag: Int
    
    init(tag: Int) {
        self.tag = tag
        viewController = TVShowListController.initFromStoryboard(name: "Main")
        rootViewController = UINavigationController(rootViewController: viewController)
    }
    
    override func start() -> Observable<Void> {
        let viewModel = TVShowListViewModel(initialLanguage: "TV Shows")
        viewController.viewModel = viewModel
        viewController.tvShowListCoordinator = self
        return Observable.never()
    }
    
    func showTVShowsDetails(_ show: TVShow?) -> Observable<Void> {
        guard let tvShow = show  else {
            return Observable.never()
        }
        let tvShowDetailsCoordinator = TVShowDetailsCoordinator(rootViewController: rootViewController.viewControllers[0], show: tvShow)
        return coordinate(to: tvShowDetailsCoordinator)
    }
}
