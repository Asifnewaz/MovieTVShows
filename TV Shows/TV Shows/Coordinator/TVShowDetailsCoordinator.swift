//
//  TVShowDetailsCoordinator.swift
//  TV Shows
//
//  Created by Asif Newaz on 27/2/21.
//

import UIKit
import RxSwift

class TVShowDetailsCoordinator: BaseCoordinator<Void> {

    private let rootViewController: UIViewController
    var viewController: TVShowDetailsViewController
    private let show: TVShow
    
    init(rootViewController: UIViewController, show: TVShow) {
        self.rootViewController = rootViewController
        self.show = show
        viewController = TVShowDetailsViewController.initFromStoryboard(name: "Main")
    }
    
    override func start() -> Observable<Void> {
        let viewModel = TVShowDetailsViewModel(show: show)
        viewController.viewModel = viewModel
        rootViewController.navigationController?
            .pushViewController(viewController, animated: true)
        return Observable.never()
    }
}
