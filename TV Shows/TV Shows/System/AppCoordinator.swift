//
//  AppCoordinator.swift
//  TV Shows
//
//  Created by Asif Newaz on 26/2/21.
//

import UIKit
import RxSwift

class AppCoordinator: BaseCoordinator<Void> {

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    override func start() -> Observable<Void> {
        let tabbarCoordinator = TabbarCoordinator(window: window)
        return coordinate(to: tabbarCoordinator)
    }
}
