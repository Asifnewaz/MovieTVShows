//
//  TabbarCoordinator.swift
//  TV Shows
//
//  Created by Asif Newaz on 26/2/21.
//

import UIKit
import RxSwift

class TabbarCoordinator: BaseCoordinator<Void> {

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let viewController = TabbarViewController()
        viewController.window = self.window
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        return Observable.never()
    }
    
}
