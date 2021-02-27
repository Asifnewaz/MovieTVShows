//
//  TabbarViewController.swift
//  TV Shows
//
//  Created by Asif Newaz on 26/2/21.
//

import UIKit

class TabbarViewController: UITabBarController {
    
    var window: UIWindow?

    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let movieListCoordinator = MovieListCoordinator(tag: 0)
        let movieListVC  = movieListCoordinator.rootViewController
        movieListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        
        let tvShowListCoordinator = TVShowListCoordinator(tag: 1)
        let tvShowListVC  = tvShowListCoordinator.rootViewController
        tvShowListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 1)
        
        let searchCoordinator = SearchCoordinator(tag: 2)
        let searchVC  = searchCoordinator.rootViewController
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        
        movieListCoordinator.start()
        tvShowListCoordinator.start()
        searchCoordinator.start()
    
        self.viewControllers = [
            movieListVC,
            tvShowListVC,
            searchVC
        ]
    }
    
}
    
